return {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    config = function()
        local conform = require("conform")

        -- Toggle for format-on-save
        vim.g.format_on_save_enabled = true
        vim.api.nvim_create_user_command("FormatOnSaveToggle", function()
            vim.g.format_on_save_enabled = not vim.g.format_on_save_enabled
            local state = vim.g.format_on_save_enabled and "enabled" or "disabled"
            vim.notify("Format on save " .. state)
        end, {})

        local prettier_config = vim.fn.expand("~/.config/nvim/.prettierrc.json")
        local stylua_config = vim.fn.expand("~/.config/nvim/stylua.toml")

        conform.setup({
            notify_on_error = false,
            formatters = {
                prettierd = {
                    env = {
                        PRETTIERD_DEFAULT_CONFIG = prettier_config,
                    },
                },
                prettier = {
                    prepend_args = { "--config", prettier_config },
                },
                stylua = {
                    prepend_args = { "--config-path", stylua_config },
                },
            },
            formatters_by_ft = {
                javascript = { "prettierd", "prettier" },
                typescript = { "prettierd", "prettier" },
                javascriptreact = { "prettierd", "prettier" },
                typescriptreact = { "prettierd", "prettier" },
                json = { "prettierd", "prettier" },
                jsonc = { "prettierd", "prettier" },
                yaml = { "prettierd", "prettier" },
                html = { "prettierd", "prettier" },
                css = { "prettierd", "prettier" },
                scss = { "prettierd", "prettier" },
                lua = { "stylua" },
                go = { "gofumpt", "goimports" },
                rust = { "rustfmt" },
                python = { "isort", "black" },
                php = { "php-cs-fixer", "phpcbf" },
            },
            format_on_save = function(bufnr)
                if not vim.g.format_on_save_enabled then return end
                return { lsp_fallback = true, timeout_ms = 5000 }
            end,
        })

        -- Manual format keymap
        vim.keymap.set({ "n", "v" }, "<leader>cf", function()
            require("conform").format({ async = true, lsp_fallback = true })
        end, { desc = "Format file" })
    end,
}
