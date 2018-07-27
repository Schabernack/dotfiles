" autoinstall vim-plug if not available
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !mkdir -p ~/.vim/autoload
  silent !curl -fLo ~/.vim/autoload/plug.vim
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
" Plug 'bling/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/syntastic'
" fixes messed up signcolumn for default solarized.
" https://github.com/altercation/solarized/issues/252
Plug 'hdima/python-syntax'
" Plug 'jwhitley/vim-colors-solarized'
Plug 'morhetz/gruvbox'
" Plug 'chriskempson/base16-vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdtree' ", { 'on':  'NERDTreeToggle'  }
Plug 'tpope/vim-surround'
" Plug 'airblade/vim-gitgutter'
Plug 'hynek/vim-python-pep8-indent'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'FelikZ/ctrlp-py-matcher'
" Plug 'Raimondi/delimitMate'
Plug 'moll/vim-bbye'
Plug 'alvan/vim-closetag'
if version > 702 
    Plug 'myusuf3/numbers.vim'
endif
Plug 'terryma/vim-expand-region'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'tmhedberg/SimpylFold'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/LargeFile'
Plug 'mitsuhiko/vim-rst'
Plug 'wincent/ferret'
Plug 'tpope/vim-dispatch'
Plug 'jeetsukumaran/ctrlp-pythonic.vim'
Plug 'hashivim/vim-terraform'
call plug#end()

set t_ut=

set nocompatible
filetype plugin indent on

set t_Co=256
" set t_Co=16
set background=dark
" colorscheme base16-monokai
colorscheme gruvbox
" soft / medium / hard
let g:gruvbox_contrast_dark = "soft"
" let g:gruvbox_invert_signs = 1
" let g:gruvbox_hls_cursor = "gray"

" let g:solarized_termcolors=256
" let g:solarized_termcolors=16
" let g:solarized_visibility = "normal"
" let g:solarized_contrast = "normal"
" let g:solarized_termtrans = 1

" set iskeyword-=_        "_ will be treated as a word boundary (though not a WORD boundary w vs W)
set encoding=utf8
syntax enable           " enable syntax highlighting
set laststatus=2        " always show statusbar
set autoindent          " align the new line indent with the previous line
set number              " linenumbers
set cursorline          " highlight current line
set hidden              " better multiple buffer handling
set backspace=2         " sane backspace behavior
set showcmd             " Show incomplete cmds down the bottom
set wildmenu            " Enhanced command line completion.
set autoread            " reload file after external modification
set visualbell          " visual indication instead of bell
set scrolloff=5         " scroll 5 lines before horizontal window border
set wrap linebreak nolist   " dont wrap lines in the middle of word
set showbreak=↪         " linewrapping character
set mouse=a             " enable mouse scrolling

" whitespace
set shiftwidth=4        " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4           " a hard TAB displays as 4 columns
set expandtab           " insert spaces when hitting TABs
set softtabstop=4       " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround          " round indent to multiple of 'shiftwidth'
set list                " list invisibles:
set listchars=extends:»,precedes:«,nbsp:¬,tab:›\ ,trail:·
" set iskeyword-=_

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
autocmd BufNewFile,BufRead *.py setlocal nosmartindent  "better python indentation
"
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
"" better highlighting
let python_highlight_all = 1
let python_highlight_builtins = 0
let  python_version_2 = 1


"set colorcolumn for code files
if exists('+colorcolumn')
    autocmd FileType cpp,c,cxx,h,hpp,python,sh,ruby,vim setlocal cc=80
endif


set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux"
set wildignore+=*.o,*.obj,*~,*.pyc "stuff to ignore when tab completing"
set wildignore+=.git,.gitkeep


" searching
set hlsearch
set incsearch
set ignorecase          " make searches case-sensitive
set smartcase           " only if they contain upper-case characters

"custom key bindings
nnoremap Q <nop>        "no accidental exmode

"move up/down by row, not line
nnoremap j gj
nnoremap k gk

:let mapleader = ","        "set leader to ,

inoremap jj <ESC>

"unmap arrow keys
" map <Left> <Nop>
" map <Right> <Nop>
" map <Up> <Nop>
" map <Down> <Nop>

"make Y yank until end of line.
nmap Y y$

nnoremap <leader>x "_x
vnoremap <leader>x "_x
nnoremap <leader>d "_d
nnoremap <leader>dd "_dd
vnoremap <leader>d "_d
vnoremap <leader>p "_dP"

" folding. 'za' to open and close folds
" zo - open; zc - close
set foldmethod=indent
set foldlevel=99
nnoremap <space> za
vnoremap <space> zf


" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Clear last search highlighting
map <Leader><Space> :noh<cr>

map <leader>w :w<CR>

"enter for autocomplete enter
:inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

if has('unnamedplus')
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

"plugins

"ctrlp
let g:ctrlp_map = ''
nnoremap <c-p> :NERDTreeClose\|CtrlP<CR>  

" let g:ctrlp_dont_split = 'NERD'
"let g:ctrlp_map = '<c-p>'
" close nerdtree so we dont open file in NT
"let g:ctrlp_cmd = ':NERDTreeClose | CtrlP'
" let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll|pyc)$',
            \ 'link': 'some_bad_symbolic_links',
            \ }
let g:ctrlp_match_window = 'results:50' " overcome limit imposed by max height"
"let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
" set grepprg=ag\ --nogroup\ --nocolor
" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
" let g:ctrlp_user_command = 'ag %s --files-with-matches --hidden -g "" --ignore "\.git$\|\.hg$\|\.svn$\|\.pyc$"'
" let g:ctrlp_user_command = 'ag --nogroup --nobreak --noheading --nocolor -g "" %s '
" let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
" ag is fast enough that CtrlP doesn't need to cache
" let g:ctrlp_use_caching = 0
" use faster ctrlp matcher
" https://github.com/FelikZ/ctrlp-py-matcher
let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch'  }
" let g:ctrlp_clear_cache_on_exit = 1
" let g:ctrlp_working_path_mode = '0'
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_extensions = ['pythonic']
nnoremap <Leader>py :CtrlPPythonic<Cr>

"airline
let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#syntastic#enabled = 1

"syntastic
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✠'
let g:syntastic_warning_symbol = '∆'
let g:syntastic_style_warning_symbol = '≈'
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'active_filetypes': ['ruby' ],
            \ 'passive_filetypes': ['puppet'] }
let g:syntastic_mode_map = { 'mode': 'active'}
let g:syntastic_python_checkers = ['flake8']

"nerdtree
map <Leader>n :NERDTreeToggle<CR>
" close vim if NERDTree is last open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") &&  b:NERDTreeType == "primary") | q | endif
let NERDTreeIgnore = ['\.pyc$']

" jedi vim
let g:jedi#usages_command = "<leader>u"
" use c-space instead
let g:jedi#popup_on_dot = 1
let g:jedi#show_call_signatures = "0"
" no docstring window
autocmd FileType python setlocal completeopt-=preview

"multicursor
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

"bbye
:nnoremap <Leader>q :Bdelete<CR>

"expand region
" use + and - to expand and shrink regions

set shortmess+=I

" autocmd VimEnter * nnoremap <silent> <c-j> :TmuxNavigateDown<cr>:redraw!<cr>
