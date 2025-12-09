return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'windwp/nvim-ts-autotag',
    },
    config = function()
        require('nvim-treesitter.configs').setup {
            -- Ensure parsers for target languages and common web formats
            ensure_installed = {
                'c', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline',
                'javascript', 'typescript', 'tsx', 'html', 'css', 'json', 'yaml',
                'go', 'rust', 'python', 'php',
            },

            sync_install = false,
            auto_install = true,

            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            -- Auto-close and rename tags in HTML/TSX
            autotag = {
                enable = true,
            },

            -- Basic textobjects for functions/classes/parameters
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']]'] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer',
                    },
                },
            },
        }
    end,
}
