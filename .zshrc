# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh
export PATH=/usr/local/share/python:/usr/local/bin:/usr/local/sbin:$PATH
ZSH_THEME="gentoo"
plugins=(git git-extras zsh-syntax-highlighting supervisor autojump ssh-agent)
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities unata
DISABLE_AUTO_UPDATE="true"

source $ZSH/oh-my-zsh.sh

export HISTSIZE=60000         # Increases size of history
export SAVEHIST=60000
export VISUAL=vim
export EDITOR="$VISUAL"
#emacs mode
bindkey -e
if [ -f ~/.custom ]; then
    source ~/.custom
fi

# User configuration
typeset -U path cdpath fpath manpath
path=(/usr/local/bin ${HOME}/local/bin/  ${HOME}/bin $path  /usr/local/lib/)


# overwrite shell defaults for gruvbox colorscheme
if [[ -f "~/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh" ]]; then
    ~/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh
fi

export PYTHONDONTWRITEBYTECODE=1

LD_LIBRARY_PATH=/usr/local/lib
export LD_LIBRARY_PATH
#
# Load virtualenv
if [[ -f "/data/virtualenv/default/bin/activate" ]]; then
  source "/data/virtualenv/default/bin/activate"
fi


bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward

bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word
bindkey "^H" backward-delete-char      # Control-h also deletes the previous char
bindkey "^U" backward-kill-line
# Time in which two keys have to be pressed in order to be recognized as a
# single command (in centiseconds, set to 0.4 sec by default -- may be
# modified as needed).
export KEYTIMEOUT=10


autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down]]]]"


SOCK="/tmp/ssh-agent-$USER-screen"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER-screen
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi


alias ta="tmux   attach-session -t"
alias ts="tmux   new-session -s"
alias tl="tmux   list-sessions"
alias tkss="tmux   kill-session -t"

alias ta_legacy="/usr/bin/tmux -S /tmp/tmux-$USER attach-session -t"
alias ts_legacy="/usr/bin/tmux -S /tmp/tmux-$USER new-session -s"
alias tl_legacy="/usr/bin/tmux -S /tmp/tmux-$USER list-sessions"
alias tkss_legacy="/usr/bin/tmux -S /tmp/tmux-$USER kill-session -t"

alias dockerrmrf="docker rm -v \$(docker ps -aq -f status=exited)"

tshare() {  # {{{3
# Share tmux session
  # If no tmux session present, stop.
  if [[ -z "$TMUX" ]]; then
    echo "$0 -> no tmux server running!" >&2
    return 1
  fi

  # Get socket and session name
  local SOCKET=$(echo $TMUX | cut -d, -f1)
  local SESSION=$(/usr/bin/tmux display-message -p "#S")

  # Enable access
  chgrp deploy $SOCKET
  chmod g+rwx $SOCKET

  echo -e "
  Access to your tmux session has been enabled for the deploy group.
  Group members can now join with the following command:

    ssh $HOSTNAME -t 'tmux -S $SOCKET attach -t $SESSION -r'
  "
}

u_tmux(){
if [[ "$TERM" != "screen-256color" ]]; then
  # Create symlink to new socket before attaching to tmux.
  # Needs `set-environment -g 'SSH_AUTH_SOCK' ~/.ssh/.ssh_auth_sock`
  if [[ -n "$SSH_AUTH_SOCK" && "$SSH_AUTH_SOCK" == /tmp/* ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/.ssh_auth_sock
  fi

  # Create new or attach to existing tmux session.
  tmux -S /tmp/tmux-$USER attach-session -t "unata" \
    || tmux -S /tmp/tmux-$USER new-session -s "unata"
    # \; source-file "${HOME}/.tmux/unata"
fi
}


_tmux_pane_words() {
  local expl
  local -a w
  if [[ -z "$TMUX_PANE" ]]; then
    _message "not running inside tmux!"
    return 1
  fi
  w=( ${(u)=$(tmux capture-pane \; show-buffer \; delete-buffer)} )
  _wanted values expl 'words from current tmux pane' compadd -a w
}

zle -C tmux-pane-words-prefix   complete-word _generic
zle -C tmux-pane-words-anywhere complete-word _generic
bindkey '^Xt' tmux-pane-words-prefix
bindkey '^X^X' tmux-pane-words-anywhere
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' completer _tmux_pane_words
zstyle ':completion:tmux-pane-words-(prefix|anywhere):*' ignore-line current
zstyle ':completion:tmux-pane-words-anywhere:*' matcher-list 'b:=* m:{A-Za-z}={a-zA-Z}'

export ANSIBLE_HOST_KEY_CHECKING=False

