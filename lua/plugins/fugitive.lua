return {
    'tpope/vim-fugitive',
    config = function() 
        -- Use <leader>gg for Fugitive status to avoid conflict with gitsigns <leader>gs
        vim.keymap.set("n", "<leader>gg", vim.cmd.Git)
    end,
}
