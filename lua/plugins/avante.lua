local M = {
    'yetone/avante.nvim',
    event = 'VeryLazy',
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
        ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
        provider = 'claude', -- Recommend using Claude
        -- WARNING: Since auto-suggestions are a high-frequency operation and therefore expensive,
        -- currently designating it as `copilot` provider is dangerous because: https://github.com/yetone/avante.nvim/issues/1048
        -- Of course, you can reduce the request frequency by increasing `suggestion.debounce`.
        auto_suggestions_provider = 'claude',
        claude = {
            endpoint = 'https://api.anthropic.com',
            model = 'claude-3-5-sonnet-20241022',
            temperature = 0,
            max_tokens = 4096,
        },
        behaviour = {
            auto_suggestions = false, -- Experimental stage
            auto_set_highlight_group = true,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
            minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
        },
        mappings = {
            --- @class AvanteConflictMappings
            diff = {
                ours = 'do',
                theirs = 'dt',
                all_theirs = 'da',
                both = 'db',
                cursor = 'dc',
                next = ']x',
                prev = '[x',
            },
            suggestion = {
                accept = '<M-l>',
                next = '<M-]>',
                prev = '<M-[>',
                dismiss = '<C-]>',
            },
            jump = {
                next = ']]',
                prev = '[[',
            },
            submit = {
                normal = '<CR>',
                insert = '<C-s>',
            },
            sidebar = {
                apply_all = 'A',
                apply_cursor = 'a',
                switch_windows = '<Tab>',
                reverse_switch_windows = '<S-Tab>',
            },
        },
        hints = { enabled = false },
        windows = {
            ---@type "right" | "left" | "top" | "bottom"
            position = 'right', -- the position of the sidebar
            wrap = true, -- similar to vim.o.wrap
            width = 30, -- default % based on available width
            sidebar_header = {
                enabled = true, -- true, false to enable/disable the header
                align = 'center', -- left, center, right for title
                rounded = true,
            },
            input = {
                prefix = '> ',
                height = 8, -- Height of the input window in vertical layout
            },
            edit = {
                border = 'rounded',
                start_insert = true, -- Start insert mode when opening the edit window
            },
            ask = {
                floating = false, -- Open the 'AvanteAsk' prompt in a floating window
                start_insert = true, -- Start insert mode when opening the ask window
                border = 'rounded',
                ---@type "ours" | "theirs"
                focus_on_apply = 'ours', -- which diff to focus after applying
            },
        },
        highlights = {
            ---@type AvanteConflictHighlights
            diff = {
                current = 'DiffText',
                incoming = 'DiffAdd',
            },
        },
        --- @class AvanteConflictUserConfig
        diff = {
            autojump = true,
            ---@type string | fun(): any
            list_opener = 'copen',
            --- Override the 'timeoutlen' setting while hovering over a diff (see :help timeoutlen).
            --- Helps to avoid entering operator-pending mode with diff mappings starting with `c`.
            --- Disable by setting to -1.
            override_timeoutlen = 500,
        },
        suggestion = {
            debounce = 600,
            throttle = 600,
        },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = 'make',
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
        'stevearc/dressing.nvim',
        'nvim-lua/plenary.nvim',
        'MunifTanjim/nui.nvim',
        --- The below dependencies are optional,
        'nvim-tree/nvim-web-devicons', -- or echasnovski/mini.icons
        'zbirenbaum/copilot.lua', -- for providers='copilot'
        {
            -- support for image pasting
            'HakonHarnes/img-clip.nvim',
            event = 'VeryLazy',
            opts = {
                -- recommended settings
                default = {
                    embed_image_as_base64 = false,
                    prompt_for_file_name = false,
                    drag_and_drop = {
                        insert_mode = true,
                    },
                    -- required for Windows users
                    use_absolute_path = true,
                },
            },
        },
        {
            -- Make sure to set this up properly if you have lazy=true
            'MeanderingProgrammer/render-markdown.nvim',
            opts = {
                file_types = { 'Avante' },
            },
            ft = { 'Avante' },
        },
    },
}

return M
