return {
    'folke/trouble.nvim',
    branch = 'main',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    cmd = { 'Trouble' },
    opts = {},
    config = function(_, opts)
        require('trouble').setup(opts)
        local map = vim.keymap.set
        map('n', '<leader>xx', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Trouble (buffer)' })
        map('n', '<leader>xw', '<cmd>Trouble diagnostics toggle<CR>', { desc = 'Trouble (workspace)' })
        map('n', '<leader>xr', '<cmd>Trouble lsp toggle focus=false win.position=right<CR>', { desc = 'Trouble (references)' })
        map('n', '<leader>xt', '<cmd>TodoTrouble<CR>', { desc = 'Trouble (TODOs)' })
        map('n', '<leader>xq', '<cmd>Trouble qflist toggle<CR>', { desc = 'Trouble (quickfix)' })
    end,
}
