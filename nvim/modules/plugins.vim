call plug#begin()

  " Color Schemes
  Plug 'https://github.com/folke/tokyonight.nvim'
  
  " Productivity
  Plug 'wakatime/vim-wakatime'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
  Plug 'https://github.com/folke/which-key.nvim'
  Plug 'https://github.com/tpope/vim-commentary'  
  Plug 'jiangmiao/auto-pairs'  
  Plug 'romgrk/barbar.nvim'  
  Plug 'mg979/vim-visual-multi', {'branch': 'master'} 
  " Syntax and highlight  
  Plug 'pangloss/vim-javascript'
  Plug 'sheerun/vim-polyglot' 
  Plug 'Yggdroot/indentLine' 
  Plug 'editorconfig/editorconfig-vim' 
  Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'} 
  " File tree and terminal
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }  
  Plug 'nvim-tree/nvim-web-devicons' 
  Plug 'nvim-tree/nvim-tree.lua'  
  Plug 'https://github.com/vim-airline/vim-airline' 
  Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'} 
  " Git integration
  Plug 'sindrets/diffview.nvim'
  " Database related
  Plug 'pantharshit00/vim-prisma'  
  Plug 'https://github.com/lifepillar/pgsql.vim' 
  Plug 'andweeb/presence.nvim'    

call plug#end()

