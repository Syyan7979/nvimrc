return {
    {
        "Exafunction/codeium.vim",
        lazy = false, -- load at startup to ensure functions and agent are ready
        init = function()
            vim.g.codeium_disable_bindings = 1
        end,
        keys = {
            { "<leader>ct", ":Codeium Toggle<CR>", mode = "n", desc = "Codeium Toggle" },
            -- Avoid conflict with LSP code action (<leader>ca); use <leader>cA for Auth
            { "<leader>cA", ":Codeium Auth<CR>", mode = "n", desc = "Codeium Auth" },
            { "<C-g>", function() return vim.fn["codeium#Accept"]() end, mode = "i", expr = true, silent = true, desc = "Codeium Accept" },
            -- Use Meta (Alt) for cycling; more reliable across terminals than Ctrl+punctuation
            { "<M-]>", function() return vim.fn["codeium#CycleCompletions"](1) end, mode = "i", expr = true, silent = true, desc = "Codeium Next" },
            { "<M-[>", function() return vim.fn["codeium#CycleCompletions"](-1) end, mode = "i", expr = true, silent = true, desc = "Codeium Prev" },
            -- Clear suggestion; avoid overriding Insert-mode Ctrl-X completion menu
            { "<C-]>", function() return vim.fn["codeium#Clear"]() end, mode = "i", expr = true, silent = true, desc = "Codeium Clear" },
        },
    },
}
