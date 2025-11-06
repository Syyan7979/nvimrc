return {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    dependencies = { 'nvim-telescope/telescope.nvim' },
    config = function()
        local ok, telescope = pcall(require, 'telescope')
        if ok then
            telescope.load_extension('fzf')
        end
    end,
}

