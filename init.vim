"set encoding=utf-8
scriptencoding=utf-8

" Plug
" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

Plug 'mhinz/vim-startify'

" Plug 'benekastah/neomake'
Plug 'w0rp/ale'

Plug 'pangloss/vim-javascript'
Plug 'digitaltoad/vim-jade'
Plug 'posva/vim-vue'

Plug 'rizzatti/dash.vim'

Plug 'itchyny/lightline.vim'
Plug 'taohex/lightline-buffer'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'metakirby5/codi.vim', { 'on': 'Codi' }

Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] }

Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesToggle' }
Plug 'junegunn/limelight.vim', { 'on': 'Limelight' }

Plug 'maxst/flatcolor'

" Initialize plugin system
call plug#end()


" ALE
let g:ale_linters = {
  \ 'javascript': ['eslint'],
  \ 'vue': ['stylelint', 'eslint'],
  \ 'html': ['tidy']
  \ }

augroup FiletypeGroup
  autocmd!
  au BufNewFile,BufRead *.vue set filetype=vue.pug.javascript.sass
augroup END



" " Neomake
" augroup lint-maker
"   autocmd! BufWritePost * Neomake
" augroup END

" let g:neomake_yarndev_maker = {
"   \ 'exe': 'yarn',
"   \ 'args': ['run', 'dev'],
"   \ 'errorformat': '%f:%l:%c: %m',
"   \ }

" let g:neomake_javascript_enabled_makers = ['standard']


" Lightline
set showtabline=2   " always show tabline

  " use lightline-buffer in lightline & add colorscheme
let g:lightline = {
    \ 'tabline': {
        \ 'left': [ [ 'bufferinfo' ], [ 'bufferbefore', 'buffercurrent', 'bufferafter' ], ],
        \ 'right': [ [ 'close' ], ],
        \ },
    \ 'component_expand': {
        \ 'buffercurrent': 'lightline#buffer#buffercurrent2',
        \ },
    \ 'component_type': {
        \ 'buffercurrent': 'tabsel',
        \ },
    \ 'component_function': {
        \ 'bufferbefore': 'lightline#buffer#bufferbefore',
        \ 'bufferafter': 'lightline#buffer#bufferafter',
        \ 'bufferinfo': 'lightline#buffer#bufferinfo',
        \ },
    \ 'colorscheme': 'flatcolor',
    \ }

  " remap arrow keys
nnoremap <Left> :bprev!<CR>
nnoremap <Right> :bnext!<CR>

  " lightline-buffer ui settings
  " replace these symbols with ascii characters if your environment does not support unicode
let g:lightline_buffer_logo = ''
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '≠'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = ' '

  " lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1
let g:lightline_buffer_rotate = 0
let g:lightline_buffer_fname_mod = ':t'
let g:lightline_buffer_excludes = ['vimfiler']

let g:lightline_buffer_maxflen = 30
let g:lightline_buffer_maxfextlen = 3
let g:lightline_buffer_minflen = 16
let g:lightline_buffer_minfextlen = 3
let g:lightline_buffer_reservelen = 20


" Startify
let g:startify_bookmarks = ['~/.config/nvim/init.vim', '~/.zshrc']
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
"set nocompatible
"filetype plugin indent on
"syntax enable
set path+=**
set textwidth=80
set number
set relativenumber
set cursorline
set showcmd

if has('patch-7.4.1778')
  set guicolors
endif
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

colorscheme flatcolor

" Whitespace
"set autoindent
set smartindent
set tabstop=2 shiftwidth=2
set expandtab
"set backspace=indent,eol,start
set list listchars=tab:\ \ ,trail:◊,precedes:←,extends:→

" Key Remap
let g:mapleader = "\<Space>"
nnoremap j jzz
nnoremap k kzz
nnoremap <C-h> :Dash<CR>

" Searching
"set incsearch
set ignorecase
set smartcase

if !exists(':DiffOrig')
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
                  \ | wincmd p | diffthis
endif

set wildmode=list,longest
