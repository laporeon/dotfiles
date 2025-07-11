set number
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set showtabline=2
set title
set completeopt-=preview " For No Previews
set encoding=UTF-8
set splitright
set splitbelow
set smartcase

" Plugins
source $HOME/.config/nvim/modules/plugins.vim
lua require('plugins')

" Cores
" Habilita syntax highlight
syntax on
" Tema
colorscheme tokyonight

" indentLine configuration
let g:indentLine_enabled = 1
let g:indentLine_char = '·'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_defaultGroup = 'SpecialKey'
