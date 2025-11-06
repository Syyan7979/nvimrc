return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
        plugins = { spelling = true },
        win = { border = 'single' },
    },
    config = function(_, opts)
        local wk = require('which-key')
        wk.setup(opts)
        wk.add({
            { '<leader>f', group = 'Find/Telescope' },
            { '<leader>g', group = 'Git/Gitsigns' },
            { '<leader>c', group = 'Code/Conform/Lint' },
            { '<leader>x', group = 'Diagnostics/Trouble' },
            { '<leader>t', group = 'TODO/Tools' },
            { '<leader>o', group = 'Outline' },
        })
    end,
}
