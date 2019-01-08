let mapleader="\<Space>"

map <Tab> :NERDTreeToggle<CR>

nnoremap ; :
nnoremap Q @Q

" Remove trailing whitespace
command Nows :%s/\s\+$//

" Remove blank lines
command Nobl :g/^\s*$/d

" Make current buffer executable
command Chmodx :!chmod a+x %
