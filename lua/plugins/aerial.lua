return {
    'stevearc/aerial.nvim',
    event = 'VeryLazy',
    opts = {
        backends = { 'lsp', 'treesitter', 'markdown' },
        layout = { default_direction = 'prefer_right' },
        show_guides = true,
    },
    config = function(_, opts)
        require('aerial').setup(opts)
        vim.keymap.set('n', '<leader>o', '<cmd>AerialToggle!<CR>', { desc = 'Toggle outline (Aerial)' })
    end,
}

