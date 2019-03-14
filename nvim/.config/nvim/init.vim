" Plugins {{{
set nocompatible
filetype off

call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'cespare/vim-toml'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'flazz/vim-colorschemes'
Plug 'kien/rainbow_parentheses.vim'
Plug 'lilydjwg/colorizer'
Plug 'morhetz/gruvbox'
Plug 'nanotech/jellybeans.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'rust-lang/rust.vim'
Plug 'scrooloose/nerdtree'
Plug 'srcery-colors/srcery-vim'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

filetype plugin indent on
" }}}

" General {{{
syntax on

" Case insensitive searching
set ignorecase
set smartcase
set infercase

" Automatically remove trailing whitespace on buffer write
autocmd BufWritePre * %s/\s\+$//e
" }}}

" UI {{{
let g:gruvbox_contrast_dark='hard'
"let g:airline_theme='gruvbox'
let g:airline_theme='jellybeans'

set background=dark
set termguicolors
colorscheme jellybeans

set nohlsearch " No highlighting when searching
set number " Show line numbers
set nowrap " No line wrapping
set cursorline " Highlight cursor
set ruler " Show line and column of cursor position

set colorcolumn=81,101,121

set expandtab " Use spaces when inserting a <Tab>
set smarttab
set tabstop=2 " Tabs are worth 2 spaces
set shiftwidth=2

set nobackup
set nowritebackup
set noswapfile

" Show invisible characters
set list
set listchars=
set listchars+=tab:>-
set listchars+=trail:·
set listchars+=nbsp:░
set listchars+=precedes:«
set listchars+=extends:»
set listchars+=eol:¬

" Split style
set fillchars=vert:▒

set foldmethod=marker
" }}}

" Commands {{{
" Functions {{{
function! Comment()
  let ext = tolower(expand('%:e'))

  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/^/\#/g
  elseif ext == 'vim'
    silent s/^/\"/g
  elseif ext == 'clj'
    silent s/^/\;/g
  elseif ext == 'hs'
    silent s/^/--/g
  else
    silent s/^/\/\//g
  endif
endfunction

function! Uncomment()
  let ext = tolower(expand('%:e'))

  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/\#//g
  elseif ext == 'vim'
    silent s/^\"//g
  elseif ext == 'clj' || ext == 'vim'
    silent s/^\;//g
  elseif ext == 'hs'
    silent s/^--//g
  else
    silent s/^\/\///g
  endif
endfunction

function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  end
endfunction
" }}} Functions

let mapleader="\<Space>"

map <Tab> :NERDTreeToggle<CR>

" Navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap ; :
nnoremap Q @Q

nnoremap <Leader>r :call NumberToggle()<CR>
nnoremap <Leader>cc :call Comment()<CR>
nnoremap <Leader>cu :call Uncomment()<CR>

nnoremap <A-t> :tabnew<CR>
nnoremap <A-w> :tabclose<CR>
nnoremap <A-l> :tabnext<CR>
nnoremap <A-h> :tabprevious<CR>

" Remove trailing whitespace
command Nows :%s/\s\+$//

" Remove blank lines
command Nobl :g/^\s*$/d

" Make current buffer executable
command Chmodx :!chmod a+x %

" Get color under cursor
command Color :echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")
" }}}

" Plugin Settings {{{
" NERDTree
let NERDTreeChDirMode=2
let NERDTreeDirArrows=1
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1

" Rainbow parentheses
let g:rbpt_colorpairs = [
  \ ['white', '#a16946'],
  \ ['white', '#ba8baf'],
  \ ['white', '#5194ad'],
  \ ['white', '#86c1b9'],
  \ ['white', '#a1b56c'],
  \ ['white', '#f7ca88'],
  \ ['white', '#dc9656'],
  \ ['white', '#ab4642'],
  \ ['white', '#a16946'],
  \ ['white', '#ba8baf'],
  \ ['white', '#5194ad'],
  \ ['white', '#86c1b9'],
  \ ['white', '#a1b56c'],
  \ ['white', '#f7ca88'],
  \ ['white', '#dc9656'],
  \ ['white', '#ab4642'],
  \ ]

let g:rbpt_max=16
let g:rbpt_loadcmd_toggle=0

autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces
"autocmd Syntax * RainbowParenthesesLoadChevrons
" }}}
