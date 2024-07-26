set number
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set showtabline=2
set title
set completeopt-=preview " For No Previews
set encoding=UTF-8

" Shortcuts
source $HOME/.config/nvim/modules/shortcuts.vim

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

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

inoremap <expr> <Tab> pumvisible() ? coc#_select_confirm() : "<Tab>"

" Reminder to install
" :CocInstall coc-prettier coc-jest coc-html coc-eslint coc-tsserver coc-python coc-json coc-java coc-css coc-prisma
