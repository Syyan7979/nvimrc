return {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
        local pre = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook()
        local comment = require('Comment')
        comment.setup({
            pre_hook = pre,
        })
        local api = require('Comment.api')
        vim.keymap.set('n', '<C-/>', function()
            api.toggle.linewise.current()
        end, { silent = true, desc = 'Toggle comment' })
        local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)
        vim.keymap.set('v', '<C-/>', function()
            vim.api.nvim_feedkeys(esc, 'nx', false)
            api.toggle.linewise(vim.fn.visualmode())
        end, { silent = true, desc = 'Toggle comment' })
    end,
}
