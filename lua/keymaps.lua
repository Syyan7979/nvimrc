local opts = { noremap = true, silent = true }

-- Defining the leader key
vim.g.mapleader = " "

-- Going back to main directory
vim.keymap.set("n", "<leader>pv", "<cmd>NeoTreeGlobalToggle<CR>", opts)

-- Opening a vertical terminal
vim.keymap.set("n", "<leader>tv", ":vsplit | term<CR>", opts)

-- Opening a horizontal terminal
vim.keymap.set("n", "<leader>th", ":split | term<CR>", opts)

-- Quiting Vim
vim.keymap.set("n", "<leader>q", ":q<CR>", opts)

-- Saving file
vim.keymap.set("n", "<leader>w", ":w<CR>", opts)

-- Clearing highlights after search
vim.keymap.set("n", "<leader>/", ":noh<CR>", opts)

-- Remap <Esc> in terminal mode to exit terminal mode and go to normal mode
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]])

-- Remap create new tab
vim.keymap.set("n", "<C-t>", ":tabnew<CR>")

-- Remap close other tabs other than what you are currently on
vim.keymap.set("n", "<C-q>", ":tabo<CR>")

-- Remap tab navigation
vim.keymap.set("n", "<leader>1", "1gt")
vim.keymap.set("n", "<leader>2", "2gt")
vim.keymap.set("n", "<leader>3", "3gt")
vim.keymap.set("n", "<leader>4", "4gt")
vim.keymap.set("n", "<leader>5", "5gt")
vim.keymap.set("n", "<leader>6", "6gt")
vim.keymap.set("n", "<leader>7", "7gt")
vim.keymap.set("n", "<leader>8", "8gt")
vim.keymap.set("n", "<leader>9", "9gt")
vim.keymap.set("n", "<leader>0", "10gt")

-- create new line without entering insert mode
vim.keymap.set("n", "oo", "o<Esc>")
vim.keymap.set("n", "OO", "O<Esc>")

-- LSP keymaps
local M = {}

-- Define the on_attach function
M.on_attach = function(client, bufnr)
    local buf_set_keymap = vim.api.nvim_buf_set_keymap

    -- Define keymap bindings for LSP
    buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)           -- Go to definition
    buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)                 -- Hover documentation
    buf_set_keymap(bufnr, 'n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)       -- Go to implementation
    buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)           -- Find references
    buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)          -- Go to declaration
    buf_set_keymap(bufnr, 'n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)       -- Rename symbol
    buf_set_keymap(bufnr, 'n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)  -- Code action
    buf_set_keymap(bufnr, 'n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)         -- Previous diagnostic
    buf_set_keymap(bufnr, 'n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)         -- Next diagnostic
    buf_set_keymap(bufnr, 'n', '<leader>e', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts) -- Show diagnostics
end

return M
