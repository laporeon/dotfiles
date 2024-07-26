-- ToggleTerm
require("toggleterm").setup{
  size = 10,
  open_mapping = [[<c-k>]],
  hide_numbers = true, 
  shade_filetypes = {},
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true, 
  terminal_mappings = true, 
  persist_size = true,
  direction = 'horizontal', 
  close_on_exit = true, 
  float_opts = {
    border = 'curved', 
    winblend = 3,
  }
}

function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  -- vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Nvim Tree
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false
  },
})

-- Nvim Web Icons
require'nvim-web-devicons'.setup {
 override = {
  zsh = {
    icon = "",
    color = "#428850",
    cterm_color = "65",
    name = "Zsh"
  }
 };
 color_icons = true;
 default = true;
 strict = true;
 override_by_filename = {
  [".gitignore"] = {
    icon = "",
    color = "#f1502f",
    name = "Gitignore"
  }
 };
 override_by_extension = {
  ["log"] = {
    icon = "",
    color = "#81e043",
    name = "Log"
  }
 };
}

-- Discord Presence
require("presence").setup({
    auto_update         = true,                       
    neovim_image_text   = "The One True Text Editor", 
    main_image          = "neovim",                   
    client_id           = "793271441293967371",      
    log_level           = nil,                        
    debounce_timeout    = 10,                          
    enable_line_number  = false,                     
    blacklist           = {},                         
    buttons             = true,                       
    file_assets         = {},                        
    editing_text        = "Editing %s",               
    file_explorer_text  = "Browsing %s",              
    git_commit_text     = "Committing changes",      
    plugin_manager_text = "Managing plugins",         
    reading_text        = "Reading %s",               
    workspace_text      = "Working on %s",           
    line_number_text    = "Line %s out of %s",       
})

