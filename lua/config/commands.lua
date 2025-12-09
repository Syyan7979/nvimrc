local api = vim.api

-- Open the hotkeys cheat-sheet one level above the nvim config directory
api.nvim_create_user_command('Hotkeys', function()
  local path = vim.fn.stdpath('config') .. '/../hotkeys'
  vim.cmd.edit(vim.fn.fnameescape(path))
end, { desc = 'Open NVim hotkeys cheat-sheet' })

