" Plugins {{{
set nocompatible
filetype off

set runtimepath+=~/.vim/

if empty(glob('~/.vim/autoload/plug.vim'))
  silent call system('mkdir -p ~/.vim/{autoload,bundle,cache,undo,backups,swaps}')
  silent call system('curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  execute 'source ~/.vim/autoload/plug.vim'
  augroup plugsetup
    au!
    autocmd VimEnter * PlugInstall
  augroup end
endif

call plug#begin('~/.vim/plugged')

Plug 'cespare/vim-toml'
Plug 'kien/rainbow_parentheses.vim'
Plug 'lilydjwg/colorizer'
Plug 'nanotech/jellybeans.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'

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

" Navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

" UI {{{
set shortmess+=I " No startup message

colorscheme jellybeans
set background=dark

set showmatch " Show matching parentheses/brackets

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

let mapleader="\<Space>"

map <Tab> :NERDTreeToggle<CR>

nnoremap ; :
nnoremap Q @Q

nnoremap <Leader>r :call NumberToggle()<CR>
nnoremap <Leader>cc :call Comment()<CR>
nnoremap <Leader>cu :call Uncomment()<CR>

nnoremap <Leader>pt :RainbowParenthesesToggle<CR>
nnoremap <Leader>pl :RainbowParenthesesLoadRound<CR>:RainbowParenthesesLoadSquare<CR>:RainbowParenthesesLoadBraces<CR>
" :RainbowParenthesesLoadChevrons<CR>

" Remove trailing whitespace
command Nows :%s/\s\+$//

" Remove blank lines
command Nobl :g/^\s*$/d

" Make current buffer executable
command Chmodx :!chmod a+x %
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
