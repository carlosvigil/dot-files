scriptencoding=utf-8

" Plug_____________________________
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

" Specify a directory for plugins
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

Plug 'mhinz/vim-startify'
Plug 'rizzatti/dash.vim'
Plug 'itchyny/lightline.vim'
"Plug 'taohexxx/lightline-buffer'

"Plug 'maximbaz/lightline-ale'
Plug 'w0rp/ale'
Plug 'mlent/ale' " for multiline ghc errors

Plug 'othree/html5.vim', { 'for': ['html', 'css'] }
Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] }
Plug 'pangloss/vim-javascript'
Plug 'eagletmt/ghcmod-vim'
Plug 'Shougo/vimproc'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'

Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'overcache/NeoSolarized'

Plug 'ryanoasis/vim-devicons'
" __________________________________Plug
call plug#end()

let g:python_host_prog  = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" ALE
let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'vue': ['stylelint', 'eslint'],
  \ 'html': ['tidy'],
  \ 'python': ['flake8']
  \ }

" Startify
let g:startify_bookmarks = ['~/.config']
let g:startify_list_order = [
        \ ['    Most Recently Used:'], 'files',
        \ ['    MRU in directory:'], 'dir',
        \ ['    Bookmarks:'], 'bookmarks',
        \ ['    Saved Session:'], 'sessions',
        \ ['    Commands:'], 'commands']
let g:startify_update_oldfiles = 0
let g:startify_change_to_dir = 1
let g:startify_padding_left = 5
let g:startify_session_sort = 0
let g:startify_relative_path = 0


" \/\/\ NEOVIM \/\/\
set path+=**
set encoding=UTF-8
set textwidth=79
set number
set cursorline
set showcmd
set number relativenumber

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

"COLORS
if !has('gui_running')
  set t_Co=256
endif

if has('nvim') || has('termguicolors')
  set termguicolors
endif

colorscheme challenger_deep

" Whitespace
set smartindent
set tabstop=2 shiftwidth=2
set expandtab
" set backspace=indent,eol,start
set list listchars=tab:\ \ ,trail:◊,precedes:←,extends:→

" Key Remap
let g:mapleader = "\<Space>"
nnoremap j jzz
nnoremap k kzz
nnoremap <C-h> :Dash<CR>
nnoremap <Left> :bprev!<CR>
nnoremap <Right> :bnext!<CR>

" Searching
set ignorecase
set smartcase

if !exists(':DiffOrig')
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

set wildmode=list,longest


