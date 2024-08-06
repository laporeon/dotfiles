call plug#begin()

  " Color Schemes
  Plug 'https://github.com/folke/tokyonight.nvim'
  
  " Productivity
  Plug 'wakatime/vim-wakatime'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
  Plug 'https://github.com/folke/which-key.nvim'
  Plug 'numToStr/Comment.nvim'  
  Plug 'jiangmiao/auto-pairs'  
  Plug 'romgrk/barbar.nvim'  
  " Syntax and highlight  
  Plug 'sheerun/vim-polyglot' 
  Plug 'Yggdroot/indentLine' 
  Plug 'editorconfig/editorconfig-vim' 
  Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'} 
  Plug 'neovim/nvim-lspconfig'
  Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
  " File tree and terminal
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }  
  Plug 'nvim-tree/nvim-web-devicons' 
  Plug 'nvim-tree/nvim-tree.lua'  
  Plug 'akinsho/toggleterm.nvim', {'tag' : 'v2.*'}
  Plug 'nvim-lualine/lualine.nvim'
  " Git integration
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'sindrets/diffview.nvim'
  " Database related
  Plug 'pantharshit00/vim-prisma'  
  Plug 'https://github.com/lifepillar/pgsql.vim' 

call plug#end()

