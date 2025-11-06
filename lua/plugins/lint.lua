return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local lint = require("lint")

        -- Prefer eslint_d when available
        local eslint = (vim.fn.executable("eslint_d") == 1) and "eslint_d" or "eslint"
        local phpcs = (vim.fn.executable("phpcs") == 1) and "phpcs" or nil
        local ruff = (vim.fn.executable("ruff") == 1) and "ruff" or nil
        local golangci = (vim.fn.executable("golangci-lint") == 1) and "golangcilint" or nil

        lint.linters_by_ft = {
            javascript = { eslint },
            typescript = { eslint },
            javascriptreact = { eslint },
            typescriptreact = { eslint },
            python = ruff and { ruff } or nil,
            php = phpcs and { phpcs } or nil,
            go = golangci and { golangci } or nil,
            -- Rust typically relies on rust-analyzer diagnostics; skip external linter by default
        }

        local aug = vim.api.nvim_create_augroup("LintOnEvents", { clear = true })
        vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "TextChanged" }, {
            group = aug,
            callback = function()
                -- Try to lint the current buffer; silent if no linter configured
                pcall(lint.try_lint)
            end,
        })

        -- Manual lint keymaps
        vim.keymap.set("n", "<leader>cl", function()
            pcall(require("lint").try_lint)
        end, { desc = "Run linter" })
    end,
}

