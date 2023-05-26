set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'mhinz/vim-startify'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'

Plugin 'mattn/emmet-vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-surround'

Plugin 'junegunn/limelight.vim'
Plugin 'metakirby5/codi.vim'
Plugin 'rizzatti/dash.vim'
call vundle#end()

" Startify
let g:startify_bookmarks = ['~/.vimrc', '~/.zshrc']
let g:startify_update_oldfiles = 0
let g:startify_change_to_dir = 1
let g:startify_padding_left = 15
let g:startify_session_sort = 0
let g:startify_relative_path = 0

" Airline
set laststatus=2
set ttimeoutlen=10
set noshowmode

" NERDTree

" \/\/\ VIM \/\/\
filetype plugin indent on
syntax enable
set encoding=utf-8
set autochdir
set textwidth=80
set nowrap
set number
set relativenumber
set cursorline
set showcmd

" Whitespace
set autoindent
set tabstop=2 shiftwidth=2
set expandtab
set backspace=indent,eol,start
set list listchars=tab:\ \ ,trail:◊,precedes:←,extends:→

" Key Remap
nnoremap j jzz
nnoremap k kzz
map <C-n> :NERDTreeToggle<CR>

" Searching
set incsearch
set ignorecase
set smartcase

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

set wildmode=list,longest
