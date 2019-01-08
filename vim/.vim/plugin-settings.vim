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

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons
