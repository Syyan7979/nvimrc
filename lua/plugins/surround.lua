return {
    'echasnovski/mini.surround',
    version = false,
    event = 'VeryLazy',
    config = function()
        require('mini.surround').setup()
        -- Defaults: sa to add, sd to delete, sr to replace
    end,
}

