return {
    'folke/trouble.nvim',
    branch = 'main',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'Trouble', 'TroubleToggle' },
    opts = {
        use_diagnostic_signs = true,
    },
    config = function(_, opts)
        require('trouble').setup(opts)
        local map = vim.keymap.set
        map('n', '<leader>xx', '<cmd>TroubleToggle document_diagnostics<CR>', { desc = 'Trouble (buffer)' })
        map('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>', { desc = 'Trouble (workspace)' })
        map('n', '<leader>xr', '<cmd>TroubleToggle lsp_references<CR>', { desc = 'Trouble (references)' })
        map('n', '<leader>xt', '<cmd>TodoTrouble<CR>', { desc = 'Trouble (TODOs)' })
        map('n', '<leader>xq', '<cmd>TroubleToggle quickfix<CR>', { desc = 'Trouble (quickfix)' })
    end,
}

