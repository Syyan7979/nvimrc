local api = vim.api

-- Highlight text on yank for quick visual feedback
api.nvim_create_autocmd('TextYankPost', {
    group = api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        pcall(vim.highlight.on_yank, { higroup = 'IncSearch', timeout = 200 })
    end,
})

-- Restore last cursor position when reopening a file
api.nvim_create_autocmd('BufReadPost', {
    callback = function()
        local mark = api.nvim_buf_get_mark(0, '"')
        local lcount = api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- When opening Neovim with a directory (e.g. `nvim .`), switch to that cwd
-- but keep a clean empty buffer instead of showing the directory listing.
api.nvim_create_autocmd('VimEnter', {
    callback = function(event)
        local arg = event.file
        if arg == '' or vim.fn.isdirectory(arg) ~= 1 then
            return
        end
        vim.cmd.cd(arg)
        vim.cmd.enew()
        pcall(vim.cmd.bwipeout, event.buf)
    end,
})
