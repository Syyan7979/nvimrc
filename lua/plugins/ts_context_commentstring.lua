return {
  'JoosepAlviste/nvim-ts-context-commentstring',
  lazy = false,
  opts = {
    enable_autocmd = false,
  },
  config = function(_, opts)
    -- Skip loading the old Treesitter module for faster startup
    vim.g.skip_ts_context_commentstring_module = true
    require('ts_context_commentstring').setup(opts)
  end,
}

