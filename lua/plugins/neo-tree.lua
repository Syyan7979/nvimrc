return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        vim.g.neo_tree_remove_legacy_commands = 1

        local desired_tree_open = false
        local pending_focus = false

        local function find_neo_tree_window()
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].filetype == "neo-tree" then
                    return win
                end
            end
        end

        local function focus_tree_if_pending()
            if not pending_focus then
                return
            end
            local tree_win = find_neo_tree_window()
            if tree_win and vim.api.nvim_win_is_valid(tree_win) then
                vim.api.nvim_set_current_win(tree_win)
                pending_focus = false
            end
        end

        local function ensure_tree_state(opts)
            opts = opts or {}
            local focus_tree = opts.focus_tree
            local tree_win = find_neo_tree_window()

            if desired_tree_open and not tree_win then
                local previous = vim.api.nvim_get_current_win()
                require("neo-tree.command").execute({
                    action = "show",
                    source = "filesystem",
                    position = "left",
                    reveal = true,
                })
                if focus_tree then
                    pending_focus = true
                    vim.defer_fn(focus_tree_if_pending, 10)
                else
                    vim.schedule(function()
                        if vim.api.nvim_win_is_valid(previous) and vim.bo[vim.api.nvim_win_get_buf(previous)].filetype ~= "neo-tree" then
                            vim.api.nvim_set_current_win(previous)
                        end
                    end)
                end
            elseif desired_tree_open and tree_win and focus_tree then
                pending_focus = false
                vim.api.nvim_set_current_win(tree_win)
            elseif not desired_tree_open and tree_win then
                require("neo-tree.command").execute({ action = "close" })
            end
        end

        vim.api.nvim_create_user_command("NeoTreeGlobalToggle", function()
            desired_tree_open = not desired_tree_open
            ensure_tree_state({ focus_tree = desired_tree_open })
        end, {})

        local focus_group = vim.api.nvim_create_augroup("NeoTreeFocusSync", { clear = true })
        vim.api.nvim_create_autocmd("BufWinEnter", {
            group = focus_group,
            callback = function(args)
                if vim.bo[args.buf].filetype == "neo-tree" then
                    focus_tree_if_pending()
                end
            end,
        })

        local tab_sync_group = vim.api.nvim_create_augroup("NeoTreeTabSync", { clear = true })
        vim.api.nvim_create_autocmd({ "TabEnter", "TabNewEntered" }, {
            group = tab_sync_group,
            callback = ensure_tree_state,
        })

        local function tab_contains_named_buffer()
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].buftype == "" and vim.api.nvim_buf_get_name(buf) ~= "" then
                    return true
                end
            end
            return false
        end

        local function smart_open(state)
            local commands = require("neo-tree.sources.filesystem.commands")
            if tab_contains_named_buffer() then
                commands.open_tabnew(state)
            else
                commands.open(state)
            end
        end

        local function open_created_file_in_tab(path)
            if not path or path == "" then
                return
            end
            if vim.fn.isdirectory(path) == 1 then
                return
            end
            vim.cmd("tabnew " .. vim.fn.fnameescape(path))
        end

        require("neo-tree").setup({
            close_if_last_window = true,
            enable_git_status = true,
            enable_diagnostics = true,
            default_component_configs = {
                git_status = {
                    symbols = {
                        added = "+",
                        modified = "~",
                        deleted = "✗",
                        renamed = "→",
                        untracked = "?",
                        ignored = "◌",
                        unstaged = "!",
                        staged = "✓",
                        conflict = "×",
                    },
                },
            },
            filesystem = {
                bind_to_cwd = false,
                follow_current_file = { enabled = true, leave_dirs_open = true },
                -- don't auto-open neo-tree when `nvim .` hijacks netrw
                hijack_netrw_behavior = "disabled",
                use_libuv_file_watcher = true,
            },
            window = {
                position = "left",
                mappings = {
                    [" "] = "noop",
                    ["<space>"] = "noop",
                    ["<cr>"] = smart_open,
                    o = smart_open,
                    d = "add_directory",
                    D = "delete",
                    r = "rename",
                },
            },
            event_handlers = {
                {
                    event = "file_added",
                    handler = function(args)
                        local path = args and (args.path or (args.data and args.data.path))
                        open_created_file_in_tab(path)
                    end,
                },
            },
        })
    end,
}
