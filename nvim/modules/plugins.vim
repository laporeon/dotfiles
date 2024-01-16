call plug#begin()

  " Temas
  Plug 'ayu-theme/ayu-vim'
  Plug 'https://github.com/folke/tokyonight.nvim'
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'navarasu/onedark.nvim'
  
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' } " Find Files
  Plug 'pangloss/vim-javascript' " Suporte à liguagem JavaScript
  Plug 'sheerun/vim-polyglot' " Adicionar syntax hightlight para várias linguagens
  Plug 'jiangmiao/auto-pairs'   " Fazer fechamento automático de pares (parênteses, colchetes, aspas, etc)
  Plug 'wakatime/vim-wakatime'
  Plug 'editorconfig/editorconfig-vim' " Editorconfig
  Plug 'nvim-tree/nvim-web-devicons' " NerdTree File icons
  Plug 'nvim-tree/nvim-tree.lua' " Better NerdTree
  Plug 'https://github.com/tpope/vim-commentary' " For Commenting gcc & gc
  Plug 'https://github.com/vim-airline/vim-airline' " Status bar
  Plug 'https://github.com/lifepillar/pgsql.vim' " PSQL Pluging needs :SQLSetType pgsql.vim
  Plug 'https://github.com/ap/vim-css-color' " CSS Color Preview
  Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}  " Auto Completion
  Plug 'lewis6991/gitsigns.nvim' " OPTIONAL: for git status
  Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Vim multiple cursors
  Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'} " Terminal
  Plug 'Yggdroot/indentLine' " Indentation level
  Plug 'romgrk/barbar.nvim' " Multiple tabs
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' } " Markdown preview
  Plug 'https://github.com/folke/which-key.nvim' " Key bindings
  " Plug 'andweeb/presence.nvim' " Discord presence
  Plug 'pantharshit00/vim-prisma' " Prisma syntax highlight 
  set encoding=UTF-8

call plug#end()

