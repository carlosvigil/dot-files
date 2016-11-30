set nocompatible
filetype off

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'leonid-shevtsov/ambient_theme.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
call vundle#end()

" airline ^
set laststatus=2
set ttimeoutlen=10
set noshowmode

" \/\/\ Main \/\/\
filetype plugin indent on
syntax enable
set encoding=utf-8
set autoindent
set showcmd

set background=dark
colorscheme solarized

nnoremap j jzz
nnoremap k kzz

" Whitespace
set tabstop=2 shiftwidth=2
set expandtab
set backspace=indent,eol,start
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

set wildmode=list,longest

