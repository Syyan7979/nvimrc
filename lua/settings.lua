vim.opt.number = true        -- Show line numbers
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true     -- Use spaces instead of tabs
vim.opt.clipboard = 'unnamedplus'
vim.g.netrw_liststyle = 3  -- Set to tree view
vim.g.netrw_banner = 0  -- Disable netrw banner

-- Phase 1: core UX settings
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 200

-- Recommended for which-key responsiveness
vim.o.timeout = true
vim.o.timeoutlen = 300
