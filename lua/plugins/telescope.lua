return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local builtin = require('telescope.builtin')

        local function tab_contains_named_buffer()
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= "" then
                    return true
                end
            end
            return false
        end

        local function smart_select(prompt_bufnr)
            if tab_contains_named_buffer() then
                actions.select_tab(prompt_bufnr)
            else
                actions.select_default(prompt_bufnr)
            end
        end

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<CR>"] = smart_select,
                    },
                    n = {
                        ["<CR>"] = smart_select,
                    },
                },
            },
        })

        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<leader>ps', builtin.live_grep, {})
        vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end,
}
