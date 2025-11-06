return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
        indent = { char = '│' },
        scope = { enabled = true, show_start = true, show_end = false },
        exclude = {
            filetypes = { 'help', 'alpha', 'neo-tree', 'Trouble', 'lazy', 'mason' },
            buftypes = { 'terminal', 'nofile', 'quickfix', 'prompt' },
        },
    },
}

