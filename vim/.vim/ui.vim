syntax on
filetype plugin indent on

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
