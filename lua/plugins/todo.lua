return {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
        signs = true,
        highlight = { keyword = 'bg' },
        search = { command = 'rg', args = { '--color=never', '--no-heading', '--with-filename', '--line-number', '--column' } },
    },
    config = function(_, opts)
        require('todo-comments').setup(opts)
        local map = vim.keymap.set
        map('n', '<leader>td', '<cmd>TodoTelescope<CR>', { desc = 'Find TODOs' })
        map('n', '<leader>tq', '<cmd>TodoQuickFix<CR>', { desc = 'TODOs to quickfix' })
    end,
}

