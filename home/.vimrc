set nocompatible               " be iMproved
filetype off                   " required by vundle

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

"settings

set encoding=utf8

syntax enable               " enable syntax highlighting
set laststatus=2            " always show statusbar
set autoindent              " align the new line indent with the previous line
set number                  " linenumbers
set cursorline              " highlight current line
set hidden                  " better multiple buffer handling
set backspace=2             " sane backspace behavior
set showcmd                 " Show incomplete cmds down the bottom
set wildmenu                " Enhanced command line completion.	
set autoread                " reload file after external modification
set visualbell              " visual indication instead of bell
set scrolloff=3             " scroll 3 lines before horizontal window border
set wrap linebreak nolist   " dont wrap lines in the middle of word

" whitespace
set shiftwidth=4	" operation >> indents 4 columns; << unindents 4 columns
set tabstop=4		" a hard TAB displays as 4 columns
set expandtab		" insert spaces when hitting TABs
set softtabstop=4	" insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround		" round indent to multiple of 'shiftwidth'

" ruby specific
autocmd BufNewFile,BufRead Berksfile setlocal filetype=ruby
autocmd BufNewFile,BufRead Cheffile setlocal filetype=ruby
autocmd BufNewFile,BufRead Gemfile setlocal filetype=ruby
autocmd BufNewFile,BufRead Puppetfile setlocal filetype=ruby
autocmd BufNewFile,BufRead Vagrantfile setlocal filetype=ruby
autocmd FileType ruby setlocal tabstop=2 softtabstop=2 shiftwidth=2

" python specific	
autocmd BufNewFile,BufRead *.wsgi setlocal filetype=python
autocmd FileType python setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufNewFile,BufRead *.py setlocal nosmartindent		"better python indentation

" set colorcolumn for code files
autocmd FileType cpp,c,cxx,h,hpp,python,sh,ruby,vim  setlocal cc=80

" searching
set hlsearch
set incsearch
set ignorecase      " make searches case-sensitive 
set smartcase       " only if they contain upper-case characters

" folding. 'za' to open and close folds
set foldmethod=indent
set foldlevel=99

"appearance
set t_Co=256
if has('gui_macvim')
  set guifont=Menlo\ Regular:h12
  set linespace=3
elseif has('gui_gtk') || has('gui_gtk2')
  set guifont="Ubuntu Mono":h15
  set linespace=3
elseif has('gui_win32')
  set guifont=Consolas\ 13
  set linespace=3
else
  set guifont=Iconsolata\ 15
  set linespace=3
endif




"custom key bindings

:let mapleader = ","	"set leader to ,
nmap <C-s> :w<CR>	"Ctrl + S to save file
"unmap arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" CTRL j/k to switch buffers
map <C-J> :bnext<CR>
map <C-K> :bprev<CR>

"vim bundles

Bundle 'altercation/vim-colors-solarized'
Bundle 'molokai'
if has('gui_running')
	set background=light
	colorscheme solarized
    let g:solarized_termtrans=1
    let g:solarized_termcolors=256
    let g:solarized_contrast="high"
    let g:solarized_visibility="high"
else
    set background=dark
    colorscheme molokai
endif 

Bundle 'bling/vim-airline'
if has('gui_running')
    let g:airline_theme='solarized'
else
    let g:airline_theme='dark'
endif
let g:airline_enable_syntastic=1

Bundle 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

Bundle 'fholgado/minibufexpl.vim'

Bundle 'jiangmiao/auto-pairs'

Bundle 'scrooloose/syntastic'
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': ['ruby', 'php', 'python'],
                           \ 'passive_filetypes': ['puppet'] }

" maps to <leader>ig
Bundle 'nathanaelkane/vim-indent-guides'

Bundle 'kien/rainbow_parentheses.vim'
au Syntax * RainbowParenthesesLoadRound
nnoremap <Leader>rt :RainbowParenthesesToggle<CR>

" load largefiles faster
Bundle 'vim-scripts/LargeFile'

" simple search highlighting
" doc: https://github.com/vim-scripts/SearchHighlightign	
" * toggles highlighting for current word/visual selection on/off	
Bundle 'SearchHighlighting'

"Bundle 'myusuf3/numbers.vim'
"nnoremap <F3> :NumbersToggle<CR> 
Bundle 'vim-scripts/RelOps'

Bundle 'Valloric/YouCompleteMe'

" like f but takes two characters. for quick jumps inside a line
" seek motion summoned by 's'
Bundle 'goldfeld/vim-seek'

Bundle 'scrooloose/nerdtree'
map <Leader>n :NERDTreeToggle<CR>
" close vim if NERDTree is last open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


filetype plugin indent on     " required by vundle

