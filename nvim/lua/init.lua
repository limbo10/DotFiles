-- ====================================================================================
--                  Defining Locals
-- ====================================================================================
local cmd    = vim.cmd
local g      = vim.g
local o      = vim.o
local fn     = vim.fn
local opt    = vim.opt
local keymap = vim.keymap
local loop   = vim.loop
local api    = vim.api
local bo     = vim.bo

g.mapleader = " "

-- ====================================================================================
--                  Lazy Vim Setup
--              https://github.com/folke/lazy.nvim
-- ====================================================================================
local lazypath = fn.stdpath("data") .. "/lazy/lazy.nvim"
if not loop.fs_stat(lazypath) then
  fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
opt.rtp:prepend(lazypath)


-- ====================================================================================
--                  Plugin Setup
-- ====================================================================================
require("lazy").setup({
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 100,
        branch = "main",
        config = function()
            require('tokyonight').setup({
                style = "night",
                styles = {functions = 'bold', keywords = 'italic'},
                dim_inactive = true,
                sidebars = { "qf", "help", "terminal", "packer"},
            })
            -- cmd.colorscheme("tokyonight")
        end,
    },
    {
        "ellisonleao/gruvbox.nvim",
        config = function()
            require("gruvbox").setup({ })
            -- cmd("colorscheme gruvbox")
        end
    },
    {
        "tanvirtin/monokai.nvim",
        config = function()
            require('monokai').setup({ palette = require('monokai').pro })
            cmd.colorscheme("monokai_pro")
        end,
    },
    {
        "folke/which-key.nvim",
        config = function()
            o.timeout = true
            o.timeoutlen = 500
            require('which-key').setup({
                window = {
                    border = "single",
                    padding = { 2, 4, 2, 4 },
                    margin = { 0, 0, 0, 0 },
                }
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter"
    },
    {
        "neoclide/coc.nvim",
        branch = "release",
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        keys = {"<leader>t"},
    },
    {
        "https://github.com/da-moon/telescope-toggleterm.nvim",
        requires = {
            "akinsho/nvim-toggleterm.lua",
            "nvim-telescope/telescope.nvim",
            "nvim-lua/popup.nvim",
            "nvim-lua/plenary.nvim",
        },
        config = function()
            require("telescope").load_extension("toggleterm")
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        keys = {"<leader>t"},
        tag = '0.1.1',
        dependencies = {
            "nvim-lua/plenary.nvim",
            "debugloop/telescope-undo.nvim",
            "paopaol/telescope-git-diffs.nvim",
            "LinArcX/telescope-command-palette.nvim",
            "BurntSushi/ripgrep",
            "AckslD/nvim-neoclip.lua",
            "ghassan0/telescope-glyph.nvim",
            "xiyaowong/telescope-emoji.nvim",
            "TC72/telescope-tele-tabby.nvim",
            "HUAHUAI23/telescope-session.nvim",
            "nvim-telescope/telescope-project.nvim",
        },
        config = function()
            require("telescope").setup({
                defaults = {
                    file_ignore_patterns = {
                        "node_modules",
                        ".git"
                    }
                },
                extensions = {
                    undo = {
                        side_by_side = true,
                        layout_strategy = "vertical",
                        layout_config = {
                            preview_height = 0.8,
                        }
                    },
                    git_diffs = {},
                    command_palette = {
                        {"File",
                            { "entire selection (C-a)", ':call feedkeys("GVgg")' },
                            { "save current file (C-s)", ':w' },
                            { "save all files (C-A-s)", ':wa' },
                            { "quit (C-q)", ':qa' },
                            { "file browser (C-i)", ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
                            { "search word (A-w)", ":lua require('telescope.builtin').live_grep()", 1 },
                            { "git files (A-f)", ":lua require('telescope.builtin').git_files()", 1 },
                            { "files (C-f)",     ":lua require('telescope.builtin').find_files()", 1 },
                        },
                        {"Help",
                            { "tips", ":help tips" },
                            { "cheatsheet", ":help index" },
                            { "tutorial", ":help tutor" },
                            { "summary", ":help summary" },
                            { "quick reference", ":help quickref" },
                            { "search help(F1)", ":lua require('telescope.builtin').help_tags()", 1 },
                        },
                        {"Vim",
                            { "reload vimrc", ":source $MYVIMRC" },
                            { 'check health', ":checkhealth" },
                            { "jumps (Alt-j)", ":lua require('telescope.builtin').jumplist()" },
                            { "commands", ":lua require('telescope.builtin').commands()" },
                            { "command history", ":lua require('telescope.builtin').command_history()" },
                            { "registers (A-e)", ":lua require('telescope.builtin').registers()" },
                            { "colorshceme", ":lua require('telescope.builtin').colorscheme()", 1 },
                            { "vim options", ":lua require('telescope.builtin').vim_options()" },
                            { "keymaps", ":lua require('telescope.builtin').keymaps()" },
                            { "buffers", ":Telescope buffers" },
                            { "search history (C-h)", ":lua require('telescope.builtin').search_history()" },
                            { "paste mode", ':set paste!' },
                            { 'cursor line', ':set cursorline!' },
                            { 'cursor column', ':set cursorcolumn!' },
                            { "spell checker", ':set spell!' },
                            { "relative number", ':set relativenumber!' },
                            { "search highlighting (F12)", ':set hlsearch!' },
                        }
                    },
                    neoclip = { },
                    glyph = {
                        action = function(glyph)
                            api.nvim_put({ glyph.value }, 'c', false, true)
                        end,
                    },
                    emoji = {
                        action = function(emoji)
                            api.nvim_put({ emoji.value }, 'c', false, true)
                        end
                    },
                    tele_tabby = {
                        use_highlighter = true,
                    },
                    xray23 = {
                        sessionDir = "~/.config/nvim/.session"
                    },
                    project = {
                        hidden_files = true,
                        theme = "dropdown",
                        order_by = "asc",
                        search_by = "title",
                        sync_with_nvim_tree = true,
                    }
                },
            })
            require("telescope").load_extension("undo")
            require("telescope").load_extension("git_diffs")
            require("telescope").load_extension("command_palette")
            require("telescope").load_extension("neoclip")
            require("telescope").load_extension("glyph")
            require("telescope").load_extension("emoji")
            require("telescope").load_extension("tele_tabby")
            require("telescope").load_extension("xray23")
            require("telescope").load_extension("project")
            require("telescope").load_extension("file_browser")
        end
    },
    {
        "windwp/nvim-autopairs",
        config = function ()
            local Rule = require('nvim-autopairs.rule')
            local npairs = require("nvim-autopairs")
            npairs.setup({
                enable_check_bracket_line = false,
                fast_wrap = {
                    map = '<M-e>',
                    chars = { '{', '[', '(', '"', "'" },
                    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
                    end_key = '$',
                    keys = 'qwertyuiopzxcvbnmasdfghjkl',
                    check_comma = true,
                    highlight = 'Search',
                    highlight_grey='Comment'
                },
            })
        end
    },
    {
        "numToStr/Comment.nvim",
        config = function()
            require('Comment').setup({
                ignore = '^$', -- ignores empty lines
            })
        end
    },
    {
        --TODO: much more extensible
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        -- TODO: use this to show terminal number in lualine
        -- https://github.com/akinsho/toggleterm.nvim
        -- let statusline .= '%{&ft == "toggleterm" ? "terminal (".b:toggle_number.")" : ""}'
        config = function ()
            require('lualine').setup({
                options = {
                    theme = 'tokyonight',
                    section_separators = { left = '', right = '' },
                    component_separators = { left = '', right = '' }
                }
            })
        end
    },
    {
        -- TODO: Highly Extensible
        "akinsho/bufferline.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function ()
            require("bufferline").setup{}
        end
    },
    {
        -- TODO: nothing is working 😢
        "rcarriga/nvim-dap-ui",
        lazy = true,
        dependencies = {
            "mfussenegger/nvim-dap"
        },
        config = function ()
            require("dapui").setup({})
            local dap = require("dap")
            dap.adapters.cppdbg = {
                id = "cppdbg",
                type = "executable",
                command = "/home/dmfk1/.local/share/nvim/lazy/nvim-dap/Debug-Adapters/extension/debugAdapters/bin"
            }
            dap.configurations.cpp = {
                {
                    name = "Launch file",
                    type = "cppdbg",
                    request = "launch",
                    program = function()
                        return fn.input('Path to executable: ', fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopAtEntry = true,
                },
                {
                    name = 'Attach to gdbserver :1234',
                    type = 'cppdbg',
                    request = 'launch',
                    MIMode = 'gdb',
                    miDebuggerServerAddress = 'localhost:1234',
                    miDebuggerPath = '/usr/bin/gdb',
                    cwd = '${workspaceFolder}',
                    program = function()
                        return fn.input('Path to executable: ', fn.getcwd() .. '/', 'file')
                    end,
                },
            }
            dap.adapters.python = {
                type = 'executable';
                command = 'path/to/virtualenvs/debugpy/bin/python';
                args = { '-m', 'debugpy.adapter' };
            }
            dap.configurations.python = {
                -- The first three options are required by nvim-dap
                type = 'python'; -- the type here established the link to the adapter definition: `dap.adapters.python`
                request = 'launch';
                name = "Launch file";

                -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

                program = "${file}"; -- This configuration will launch the current file if used.
                pythonPath = function()
                    -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
                    -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
                    -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
                    local cwd = fn.getcwd()
                    if fn.executable(cwd .. '/venv/bin/python') == 1 then
                        return cwd .. '/venv/bin/python'
                    elseif fn.executable(cwd .. '/.venv/bin/python') == 1 then
                        return cwd .. '/.venv/bin/python'
                    else
                        return '/usr/bin/python'
                    end
                end
            }
        end
    },
    {
        "goolord/alpha-nvim",
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function ()
            require'alpha'.setup(require'alpha.themes.startify'.config)
        end
    },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup({ })

            function _G.set_terminal_keymaps()
                local opts = {buffer = 0}
                keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
                keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

                keymap.set('n', '<silent>tx', "<cmd>exec v:count1 . 'ToggleTerm'<cr>", {silent=true})
            end

            cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
            -- TODO: Changes this to use lua keymap instead
            cmd([[
                nnoremap <leader>ttb <Cmd>ToggleTerm<CR>
                nnoremap <leader>ttr <Cmd>ToggleTerm size=25 direction=vertical<CR>
                nnoremap <leader>ttf <Cmd>ToggleTerm direction=float<CR>
                nnoremap <leader>ttt <Cmd>ToggleTerm direction=tab<CR>

                nnoremap <silent>ttb <Cmd>exe v:count1 . "ToggleTerm"<CR>
                nnoremap <silent>ttr <Cmd>exe v:count1 . "ToggleTerm size=25 direction=vertical"<CR>
                nnoremap <silent>ttf <Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>
                nnoremap <silent>ttt <Cmd>exe v:count1 . "ToggleTerm direction=tab"<CR>
            ]])

            local Terminal  = require('toggleterm.terminal').Terminal
            local lazygit = Terminal:new({
                cmd = "lazygit",
                dir = "git_dir",
                direction = "float",
                    float_opts = {
                        border = "double",
                    },
            })

            function _G._lazygit_toggle()
                lazygit:toggle()
            end
            api.nvim_set_keymap("n", "<leader>ttg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            opt.list = true
            opt.termguicolors = true
            -- opt.listchars:append "eol:↴"
            -- opt.listchars:append "space:⋅"

            g.vim_json_conceal = 0
            g.markdown_syntax_conceal = 0

            g.indentLine_char = '⋅'
            -- g.indentLine_char_list = { '|', '¦', '┆', '┊', '⋅'}

            -- cmd [[highlight IndentBlanklineIndent1  guifg=#6a4c93 gui=nocombine]]
            -- cmd [[highlight IndentBlanklineIndent2  guifg=#565aa0 gui=nocombine]]
            -- cmd [[highlight IndentBlanklineIndent3  guifg=#4267ac gui=nocombine]]
            -- cmd [[highlight IndentBlanklineIndent4  guifg=#1982c4 gui=nocombine]]
            -- cmd [[highlight IndentBlanklineIndent5  guifg=#36949d gui=nocombine]]
            -- cmd [[highlight IndentBlanklineIndent6  guifg=#8ac926 gui=nocombine]]
            -- cmd [[highlight IndentBlanklineIndent7  guifg=#c5ca30 gui=nocombine]]
            -- cmd [[highlight IndentBlanklineIndent8  guifg=#ffca3a gui=nocombine]]
            -- cmd [[highlight IndentBlanklineIndent9  guifg=#ff924c gui=nocombine]]
            -- cmd [[highlight IndentBlanklineIndent10 guifg=#ff595e gui=nocombine]]

            require("indent_blankline").setup {
                space_char_blankline = " ",
                show_current_context_start = true,
                char_highlight_list = {
                    -- "IndentBlanklineIndent1",
                    -- "IndentBlanklineIndent2",
                    -- "IndentBlanklineIndent3",
                    -- "IndentBlanklineIndent4",
                    -- "IndentBlanklineIndent5",
                    -- "IndentBlanklineIndent6",
                    -- "IndentBlanklineIndent7",
                    -- "IndentBlanklineIndent8",
                    -- "IndentBlanklineIndent9",
                    -- "IndentBlanklineIndent10",
                },
            }
        end
    },
    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup({
                window = {
                    width = .90 -- width will be 85% of the editor width
                }
            })
            keymap.set("n", "<leader>f", ":<C-u>ZenMode<cr>")
        end
    },
    {
        "ludovicchabant/vim-gutentags",
        lazy = true
    },
    {
        -- use coc-vimtex with it
        "xuhdev/vim-latex-live-preview",
        lazy = true,
        config = function ()
            g.livepreview_previewer = "zathura"
            g.livepreview_cursorhold_recompile = 0
        end
    },
    {
        "mattn/emmet-vim",
        ft = {"html", "js", "ts"},
        config = function ()
            g.user_emmet_mode = 'a'
            g.user_emmet_leader_key = '<C-y>'
        end
    },
    {
        "tpope/vim-repeat",
        lazy = true
    },
    {
        "easymotion/vim-easymotion",
        config = function()
            keymap.set("n", "<leader><leader>f", "<Plug>(easymotion-bd-f)")
            keymap.set("n", "<leader><leader>f", "<Plug>(easymotion-overwin-f)")

            keymap.set("n", "<leader><leader>s", "<Plug>(easymotion-bd-f2)")
            keymap.set("n", "<leader><leader>s", "<Plug>(easymotion-overwin-f2)")

            keymap.set("n", "<leader><leader>l", "<Plug>(easymotion-bd-jk)")
            keymap.set("n", "<leader><leader>l", "<Plug>(easymotion-overwin-line)")

            keymap.set("n", "<leader><leader>w", "<Plug>(easymotion-bd-w)")
            keymap.set("n", "<leader><leader>w", "<Plug>(easymotion-overwin-w)")
        end
    },
    {
        "sindrets/winshift.nvim",
        config = function()
            require("winshift").setup({
                highlight_moving_win = true,  -- Highlight the window being moved
                focused_hl_group = "Visual",  -- The highlight group used for the moving window
                moving_win_options = {
                -- These are local options applied to the moving window while it's
                -- being moved. They are unset when you leave Win-Move mode.
                wrap = false,
                cursorline = false,
                cursorcolumn = false,
                colorcolumn = "",
                },
                keymaps = {
                    disable_defaults = false, -- Disable the default keymaps
                    win_move_mode = {
                        ["h"] = "left",
                        ["j"] = "down",
                        ["k"] = "up",
                        ["l"] = "right",
                        ["H"] = "far_left",
                        ["J"] = "far_down",
                        ["K"] = "far_up",
                        ["L"] = "far_right",
                        ["<left>"] = "left",
                        ["<down>"] = "down",
                        ["<up>"] = "up",
                        ["<right>"] = "right",
                        ["<S-left>"] = "far_left",
                        ["<S-down>"] = "far_down",
                        ["<S-up>"] = "far_up",
                        ["<S-right>"] = "far_right",
                    },
                },
                window_picker = function()
                    return require("winshift.lib").pick_window({
                        picker_chars = "ASDFJKLGH",
                        filter_rules = {
                            cur_win = true, -- Filter out the current window
                            floats = true,  -- Filter out floating windows
                            filetype = {},  -- List of ignored file types
                            buftype = {},   -- List of ignored buftypes
                            bufname = {},   -- List of vim regex patterns matching ignored buffer names },
                            filter_func = nil,
                        }
                    })
                end,
            })
        end,
        keymap.set("n", "<leader>wm", "<cmd>WinShift<cr>", {noremap = true}),
        keymap.set("n", "<leader>ws", "<cmd>WinShift swap<cr>", {noremap = true})
    },
    {
        "szw/vim-maximizer",
        keys = { "<leader>mt" },
        keymap.set("n", "<leader>mt", "<cmd>MaximizerToggle<cr>", {noremap = true})
    },
    {
        "ntpeters/vim-better-whitespace",
        config = function ()
            g.strip_whitelines_at_eof = 0
            g.strip_whitespace_on_save = 1
            g.strip_whitespace_confirm = 0
            g.show_spaces_that_precede_tabs = 1
            g.current_line_whitespace_disabled_soft = 1
            -- TODO: Set Colors
            -- g.better_whitespace_ctermcolor='#e63946'
            -- g.better_whitespace_guicolor='#e63946'
        end
    },
    {
        -- TODO: Read help
        'mg979/vim-visual-multi',
        branch = 'master',
    },
    {
        "wellle/targets.vim",
    },
    {
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({})
        end
    },
    {
        "tpope/vim-fugitive",
        lazy = true
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require('gitsigns').setup()
        end
    },
    {
        "MunifTanjim/nui.nvim",
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        keys = {"<leader>nl", "<leader>nf"},
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function ()
            cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

            -- If you want icons for diagnostic errors, you'll need to define them somewhere:
            fn.sign_define("DiagnosticSignError",
                {text = " ", texthl = "DiagnosticSignError"})
            fn.sign_define("DiagnosticSignWarn",
                {text = " ", texthl = "DiagnosticSignWarn"})
            fn.sign_define("DiagnosticSignInfo",
                {text = " ", texthl = "DiagnosticSignInfo"})
            fn.sign_define("DiagnosticSignHint",
                {text = "", texthl = "DiagnosticSignHint"})

            require("neo-tree").setup({
                close_if_last_window = true,
                -- popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                sort_case_insensitive = false,
                sort_function = nil,
                default_component_configs = {
                  container = {
                    enable_character_fade = true
                  },
                  indent = {
                    indent_size = 2,
                    padding = 1,
                    -- indent guides
                    with_markers = true,
                    indent_marker = "│",
                    last_indent_marker = "└",
                    highlight = "NeoTreeIndentMarker",
                    -- expander config, needed for nesting files
                    with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
                    expander_collapsed = "▶️",
                    expander_expanded = "",
                    expander_highlight = "NeoTreeExpander",
                  },
                  icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "ﰊ",
                    -- The next two settings are only a fallback, if you use nweb-devicons and configure default icons there
                    -- then these will never be used.
                    default = "*",
                    highlight = "NeoTreeFileIcon"
                  },
                  modified = {
                    symbol = "[+]",
                    highlight = "NeoTreeModified",
                  },
                  name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = "NeoTreeFileName",
                  },
                  git_status = {
                    symbols = {
                      -- Change type
                      added     = "✚",
                      modified  = "",
                      deleted   = "✖",
                      renamed   = "",
                      -- Status type
                      untracked = "❓",
                      ignored   = "",
                      unstaged  = "",
                      staged    = "",
                      conflict  = "",
                    }
                  },
                },
                window = {
                  position = "left",
                  width = 40,
                  mapping_options = {
                    noremap = true,
                    nowait = true,
                  },
                  mappings = {
                    ["<space>"] = {
                        "toggle_node",
                        nowait = false,
                    },
                    ["<cr>"] = "open",
                    ["<esc>"] = "revert_preview",
                    -- ["<2-LeftMouse>"] = "open",
                    -- ["P"] = { "toggle_preview", config = { use_float = true } },
                    -- ["l"] = "focus_preview",
                    ["S"] = "open_split",
                    ["s"] = "open_vsplit",
                    -- ["S"] = "split_with_window_picker",
                    -- ["s"] = "vsplit_with_window_picker",
                    ["t"] = "open_tabnew",
                    -- ["<cr>"] = "open_drop",
                    -- ["t"] = "open_tab_drop",
                    ["w"] = "open_with_window_picker",
                    ["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
                    ["C"] = "close_node",
                    ["z"] = "close_all_nodes",
                    --["Z"] = "expand_all_nodes",
                    ["a"] = {
                      "add",
                      config = {
                        show_path = "none" -- "none", "relative", "absolute"
                      }
                    },
                    ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
                    ["d"] = "delete",
                    ["r"] = "rename",
                    ["y"] = "copy_to_clipboard",
                    ["x"] = "cut_to_clipboard",
                    ["p"] = "paste_from_clipboard",
                    ["c"] = "copy",
                    -- ["c"] = {
                    --  "copy",
                    --  config = {
                    --    show_path = "none" -- "none", "relative", "absolute"
                    --  }
                    --}
                    ["m"] = "move",
                    ["q"] = "close_window",
                    ["R"] = "refresh",
                    ["?"] = "show_help",
                    ["<"] = "prev_source",
                    [">"] = "next_source",
                  }
                },
                nesting_rules = {},
                filesystem = {
                  filtered_items = {
                    visible = false,
                    hide_dotfiles = true,
                    hide_gitignored = true,
                    hide_hidden = true,
                    hide_by_name = {
                      "node_modules"
                    },
                    hide_by_pattern = { -- uses glob style patterns
                      --"*.meta",
                      --"*/src/*/tsconfig.json",
                    },
                    always_show = { -- remains visible even if other settings would normally hide it
                      ".gitignored",
                    },
                    never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                      --".DS_Store",
                      --"thumbs.db"
                    },
                    never_show_by_pattern = { -- uses glob style patterns
                      --".null-ls_*",
                    },
                  },
                  follow_current_file = false, -- This will find and focus the file in the active buffer every
                                               -- time the current file is changed while the tree is open.
                  group_empty_dirs = true, -- when true, empty folders will be grouped together
                  hijack_netrw_behavior = "open_default", -- netrw disabled, opening a directory opens neo-tree
                                                          -- in whatever position is specified in window.position
                                        -- "open_current",  -- netrw disabled, opening a directory opens within the
                                                          -- window like netrw would, regardless of window.position
                                        -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
                  use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
                                                  -- instead of relying on nautocmd events.
                  window = {
                    mappings = {
                      ["<bs>"] = "navigate_up",
                      ["."] = "set_root",
                      ["H"] = "toggle_hidden",
                      ["/"] = "fuzzy_finder",
                      ["D"] = "fuzzy_finder_directory",
                      ["f"] = "filter_on_submit",
                      ["<c-x>"] = "clear_filter",
                      ["[g"] = "prev_git_modified",
                      ["]g"] = "next_git_modified",
                    }
                  }
                },
                buffers = {
                  follow_current_file = true, -- This will find and focus the file in the active buffer every
                                               -- time the current file is changed while the tree is open.
                  group_empty_dirs = true, -- when true, empty folders will be grouped together
                  show_unloaded = true,
                  window = {
                    mappings = {
                      ["bd"] = "buffer_delete",
                      ["<bs>"] = "navigate_up",
                      ["."] = "set_root",
                    }
                  },
                },
                git_status = {
                  window = {
                    position = "float",
                    mappings = {
                      ["gA"]  = "git_add_all",
                      ["gu"] = "git_unstage_file",
                      ["ga"] = "git_add_file",
                      ["gr"] = "git_revert_file",
                      ["gc"] = "git_commit",
                      ["gp"] = "git_push",
                      ["gg"] = "git_commit_and_push",
                    }
                  }
            }
            })
            keymap.set('n', '<leader>nl', '<cmd>NeoTreeRevealToggle<cr>', {})
            keymap.set('n', '<leader>nf', '<cmd>NeoTreeFloatToggle<cr>', {})
        end
    },
    {
        "folke/todo-comments.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = true
    },
})



-- ====================================================================================
--                  Vim Options
-- ====================================================================================
opt.hidden = true
opt.mouse = 'a'
opt.number = true

opt.equalalways = true
opt.virtualedit = "all"
opt.encoding='UTF-8'
opt.clipboard="unnamedplus"

opt.signcolumn = "yes"
opt.relativenumber = true

opt.syntax = 'on'
opt.filetype = "plugin"

opt.foldmethod = "indent"
opt.foldenable = false

opt.wrap = true
opt.linebreak = true

opt.shiftwidth = 4
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4

opt.cursorline = true

opt.ignorecase = true
opt.smartcase = true

opt.splitright = true
opt.splitbelow = true

opt.incsearch = true
opt.hlsearch = false

opt.undofile = true
opt.undodir = ".undo"


keymap.set('n', '"+p', '<C-p>', {})
keymap.set('n', '"+P', '<C-p>', {})
keymap.set('v', '"+p', '<C-p>', {})
keymap.set('v', '"+P', '<C-p>', {})

-- Insert Mode Navigation
keymap.set('i', '<A-[>', '<Esc>^i')
keymap.set('i', '<A-]>', '<End>')
keymap.set('i', '<A-h>', '<Left>')
keymap.set('i', '<A-j>', '<Down>')
keymap.set('i', '<A-k>', '<Up>')
keymap.set('i', '<A-l>', '<Right>')
keymap.set('i', '<A-Backspace>', '<Del>')

-- Split Navigation
keymap.set('n', '<C-h>', '<C-w><C-H>', {noremap = true})
keymap.set('n', '<C-j>', '<C-w><C-J>', {noremap = true})
keymap.set('n', '<C-k>', '<C-w><C-K>', {noremap = true})
keymap.set('n', '<C-l>', '<C-w><C-L>', {noremap = true})

-- Autocommands
local yankHighlight = api.nvim_create_augroup("yankHighlight", {clear = true})
api.nvim_create_autocmd(
    { "TextYankPost" },
    {
        pattern = "*",
        command = ":lua vim.highlight.on_yank()",
        group = yankHighlight,
        desc = "Highlight the Yanked Text"
    }
)

local cppTemplate = api.nvim_create_augroup("cppTemplate", {clear = true})
api.nvim_create_autocmd(
    { "BufNewFile" },
    {
        pattern = "*.cpp",
        command = ":0r ~/.config/nvim/templates/competetive.cpp",
        group = cppTemplate,
        desc = "Template to be used for every cpp files"
    }
)

local webDevTemplateSetting = function ()
    opt.shiftwidth = 2
    opt.tabstop = 2
    opt.wrap = false
end

local webDevTemplate = api.nvim_create_augroup("webDevTemplate", {clear = true})
api.nvim_create_autocmd(
    { "BufNewFile", "BufRead", "BufEnter", "BufWritePre" },
    {
        pattern = { "*.js", "*.json", "*.ts", "*html", "*css"},
        callback = webDevTemplateSetting,
        group = webDevTemplate,
        desc = "Tab and Wrap Setting for Web Development"
    }
)

-- TODO: Sort CSS Properties Alphabetically
-- api.nvim_create_user_command("SortCSSRulesAlphabetially", { "g#({\n)@<=#.,/}/sort" }, )
-- api.nvim_create_user_command("JumpBack", { "exe 'normal!' <c-o>" }, true)
-- api.nvim_create_user_command("SortCSSRulesAlphabetially", "g#({\n)@<=#.,/}/sort", {bang = true} )
-- api.nvim_create_user_command("CSS", "exe 'normal <C-o>'", { bang = true })
-- local cssPropertySorting = api.nvim_create_augroup("cssPropertySorting", {clear = true})
-- api.nvim_create_autocmd(
--     { "BufWritePre" },
--     {
--         pattern = { "*.css"},
--         command = "CSS",
--         group = cssPropertySorting,
--         desc = "Sorting of CSS Properties"
--     }
-- )



-- ====================================================================================
--                                      Toggle Term
-- ====================================================================================


-- ====================================================================================
--                                      Which Key
-- ====================================================================================
local wk = require("which-key")
wk.register({
  ["<space>"] = {
      name = " Jump",
      f = " Jump by searching single character",
      l = " Jump to start of a Line",
      s = " Jump by searching two characters",
      w = " Jump to start of a Word",
      t = " Toggle Maximizer"
  },
  f = " Focus Mode Toggle",
  l = {
    name = " CoC",
    a = {
        name = " Coc CodeAction",
        b = " CoC CodeAction Current Buffer",
        c = " CoC CodeAction Cursor Position",
        f = " CoC CodeAction Fix Current",
        l = " Coc CodeLens Action",
        r = {
            name = " Code CodeAction Refactor",
            s = " Coc CodeAction Refactor Selected"
        },
        s = " CoC CodeAction Source",

        n = " Coc Take Action for next",
        p = " Coc Take Action for prev",
    },
    k = " Coc Show Docs",
    l = {
        name = " Coc List",
        a = " Coc List Command",
        o = " Outline",
        e = " Coc Extension List",
        r = " Coc Resume Last List",

    },
    d = {
        name = " CoC Diagnostics",
        p = " CoC Jump to Prev diagnostic",
        n = " CoC Jump to Next diagnostic",
        l = " CoC List All Diagnostics"
    },
    f = { name = " Coc Format Selected", s = " Coc Format Selected"},
    g = {
        name = " CoC GOTO",
        d = " CoC goto Definition",
        t = " CoC goto Type Definition",
        i = " CoC goto implementation",
        r = " CoC List all References"
    },
    s = {
        name = " CoC Symbol",
        a = " Coc List occurence of Symbol",
        p = " CoC Jump to Prev Symbol",
        n = " CoC Jump to Next Symbol",
    },
    r = " Coc Rename",
  },
  n = {
    name = " Neo Tree",
    l = " Neo Tree Left Side Toggle",
    f = " Neo Tree Float Toggle"
  },
  m = {
    name = " Maximizer",
    t = " Toggle Maximizer"
  },
  s = " Remove White Space",
  t = {
    name = " Telescope | ToggleTerminal",
    c = { name = " Telescope Command Palette", },
    f = " Telescope File Browser",
    g = {
        name = " Telescope Git",
        d = " Show Diff in Commits"
    },
    l = {
        name = " Telescope Search",
        f = " Find Files",
        g = " Live Grep Strings",
        b = " Search Opened Buffers",
        h = " Search Help Tags"
    },
    p = {
        name = " Telescope Project Management",
        l = " Telescope List Projects"
    },
    s = {
        name = " Telescope Session Management",
        l = " Telescope List Session",
        s = " Telescope Save Session"
    },
    t = {
        name = " Toggle Terminal Plugin",
        b = " Open Terminal at Bottom",
        r = " Open Terminal to the right",
        f = " Open Floating Terminal",
        t = " Open Terminal as a new Tab",
        g = " Lazy Git in New Terminal",

    },
    u = { name = " Telescope Undo", },
    m = { name = " Telescope Gliph"},
    n = { name = " Telescope Emoji"}
  },
  w = {
    name = " Window Shifting",
    m = " Window Shifting Mode",
    s = " Window Swape Mode"
  },
  z = " Fold and Alignment"
}, { prefix = "<leader>" })



-- ====================================================================================
--                                      Telescope
-- ====================================================================================
local builtin = require('telescope.builtin')
keymap.set('n', '<leader>tlf', builtin.find_files, {})
keymap.set('n', '<leader>tlg', builtin.live_grep, {})
keymap.set('n', '<leader>tlb', builtin.buffers, {})
keymap.set('n', '<leader>tlh', builtin.help_tags, {})



-- ====================================================================================
--                  Telescope Extensions
-- ====================================================================================
-- https://github.com/debugloop/telescope-undo.nvim
keymap.set("n", "<leader>tu", "<cmd>Telescope undo<cr>")

-- https://github.com/paopaol/telescope-git-diffs.nvim
keymap.set("n", "<leader>tgd", "<cmd>Telescope git_diffs diff_commits<cr>")

-- https://github.com/LinArcX/telescope-command-palette.nvim
keymap.set("n", "<leader>tc", "<cmd>Telescope command_palette<cr>")

-- https://github.com/AckslD/nvim-neoclip.lua
-- TODO: Configure it

-- https://github.com/ghassan0/telescope-glyph.nvim
keymap.set("n", "<leader>tm", "<cmd>Telescope glyph<cr>")

-- https://github.com/xiyaowong/telescope-emoji.nvim
keymap.set("n", "<leader>tn", "<cmd>Telescope emoji<cr>")

-- https://github.com/TC72/telescope-tele-tabby.nvim
-- local tele_tabby_opts = themes.get_dropdown {
--     winblend = 10,
--     border = true,
--     previewer = false,
--     shorten_path = false,
--     heigth=20,
--     width= 120
--   }
--   TODO: make a keyboard shortcut
-- keymap.set("n", "<leader>ttab", "<cmd>Telescope tele_tabby list()<cr>")

-- https://github.com/HUAHUAI23/telescope-session.nvim
keymap.set("n", "<leader>tsl", "<cmd>Telescope xray23 list<cr>")
keymap.set("n", "<leader>tss", "<cmd>Telescope xray23 save<cr>")

-- https://github.com/nvim-telescope/telescope-project.nvim
keymap.set("n", "<leader>tpl", "<cmd>Telescope project project<cr>")

-- https://github.com/nvim-telescope/telescope-file-browser.nvim
api.nvim_set_keymap("n", "<leader>tf", "<cmd>Telescope file_browser<cr>", { noremap = true })

-- ====================================================================================
--                  CoC
-- ====================================================================================
-- Some servers have issues with backup files, see #649
opt.backup = false
opt.writebackup = false

-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
-- delays and poor user experience
opt.updatetime = 300

-- Always show the signcolumn, otherwise it would shift the text each time
-- diagnostics appeared/became resolved
opt.signcolumn = "yes"

-- Autocomplete
function _G.check_back_space()
    local col = fn.col('.') - 1
    return col == 0 or fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use Tab for trigger completion with characters ahead and navigate
-- NOTE: There's always a completion item selected by default, you may want to enable
-- no select by setting `"suggest.noselect": true` in your configuration file
-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
-- other plugins before putting this into your config
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keymap.set("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- Make <CR> to accept selected completion item or notify coc.nvim to format
-- <C-g>u breaks current undo, please make your own choice
keymap.set("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keymap.set("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")

-- Use <c-space> to trigger completion
-- TODO:: Not Happening
keymap.set("i", "<c-<space>>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keymap.set("n", "<leader>ldp", "<Plug>(coc-diagnostic-prev)", {silent = true})
keymap.set("n", "<leader>ldn", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keymap.set("n", "<leader>lgd", "<Plug>(coc-definition)", {silent = true})
keymap.set("n", "<leader>lgt", "<Plug>(coc-type-definition)", {silent = true})
keymap.set("n", "<leader>lgi", "<Plug>(coc-implementation)", {silent = true})
keymap.set("n", "<leader>lgr", "<Plug>(coc-references)", {silent = true})

-- Use K to show documentation in preview window
function _G.show_docs()
    local cw = fn.expand('<cword>')
    if fn.index({'vim', 'help'}, bo.filetype) >= 0 then
        api.nvim_command('h ' .. cw)
    elseif api.nvim_eval('coc#rpc#ready()') then
        fn.CocActionAsync('doHover')
    else
        api.nvim_command('!' .. o.keywordprg .. ' ' .. cw)
    end
end
keymap.set("n", "<leader>lk", '<CMD>lua _G.show_docs()<CR>', {silent = true})

--  =============================================================================
-- TODO: make it alternative to Illuminate Plugin

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
api.nvim_create_augroup("CocGroup", {})
api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})
keymap.set("n", "<leader>lsp", ':CocCommand document.jumpToPrevSymbol<CR>', {silent = true})
keymap.set("n", "<leader>lsn", ':CocCommand document.jumpToNextSymbol<CR>', {silent = true})


--  ======================== uptill here in ToDo ================================
-- Symbol renaming
keymap.set("n", "<leader>lr", "<Plug>(coc-rename)", {silent = true})


-- Formatting selected code
keymap.set("x", "<leader>lfs", "<Plug>(coc-format-selected)", {silent = true})
keymap.set("n", "<leader>lfs", "<Plug>(coc-format-selected)", {silent = true})


-- Setup formatexpr specified filetype(s)
api.nvim_create_autocmd("FileType", {
    group = "CocGroup",
    pattern = "typescript,json",
    command = "setl formatexpr=CocAction('formatSelected')",
    desc = "Setup formatexpr specified filetype(s)."
})

-- Update signature help on jump placeholder
api.nvim_create_autocmd("User", {
    group = "CocGroup",
    pattern = "CocJumpPlaceholder",
    command = "call CocActionAsync('showSignatureHelp')",
    desc = "Update signature help on jump placeholder"
})

-- Apply codeAction to the selected region
-- Example: `<leader>aap` for current paragraph
local opts2 = {silent = true, nowait = true}
keymap.set("x", "<leader>las", "<Plug>(coc-codeaction-selected)", opts2)
keymap.set("n", "<leader>las", "<Plug>(coc-codeaction-selected)", opts2)

-- Remap keys for apply code actions at the cursor position.
keymap.set("n", "<leader>lac", "<Plug>(coc-codeaction-cursor)", opts2)
-- Remap keys for apply code actions affect whole buffer.
keymap.set("n", "<leader>las", "<Plug>(coc-codeaction-source)", opts2)
-- Remap keys for applying codeActions to the current buffer
keymap.set("n", "<leader>lab", "<Plug>(coc-codeaction)", opts2)
-- Apply the most preferred quickfix action on the current line.
keymap.set("n", "<leader>laf", "<Plug>(coc-fix-current)", opts2)

-- Remap keys for apply refactor code actions.
keymap.set("n", "<leader>lar", "<Plug>(coc-codeaction-refactor)", { silent = true })
keymap.set("x", "<leader>lars", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keymap.set("n", "<leader>lars", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keymap.set("n", "<leader>ll", "<Plug>(coc-codelens-action)", opts2)


-- Map function and class text objects
-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
keymap.set("x", "if", "<Plug>(coc-funcobj-i)", opts2)
keymap.set("o", "if", "<Plug>(coc-funcobj-i)", opts2)
keymap.set("x", "af", "<Plug>(coc-funcobj-a)", opts2)
keymap.set("o", "af", "<Plug>(coc-funcobj-a)", opts2)
keymap.set("x", "ic", "<Plug>(coc-classobj-i)", opts2)
keymap.set("o", "ic", "<Plug>(coc-classobj-i)", opts2)
keymap.set("x", "ac", "<Plug>(coc-classobj-a)", opts2)
keymap.set("o", "ac", "<Plug>(coc-classobj-a)", opts2)


-- Remap <C-f> and <C-b> to scroll float windows/popups
---@diagnostic disable-next-line: redefined-local
local opts3 = {silent = true, nowait = true, expr = true}
keymap.set("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts3)
keymap.set("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts3)
keymap.set("i", "<C-f>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts3)
keymap.set("i", "<C-b>",
       'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts3)
keymap.set("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts3)
keymap.set("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts3)


-- Use CTRL-S for selections ranges
-- Requires 'textDocument/selectionRange' support of language server
keymap.set("n", "<C-s>", "<Plug>(coc-range-select)", {silent = true})
keymap.set("x", "<C-s>", "<Plug>(coc-range-select)", {silent = true})


-- Add `:Format` command to format current buffer
api.nvim_create_user_command("Format", "call CocAction('format')", {})

-- " Add `:Fold` command to fold current buffer
api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", {nargs = '?'})

-- Add `:OR` command for organize imports of the current buffer
api.nvim_create_user_command("OI", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts4 = {silent = true, nowait = true}
-- Show all diagnostics
keymap.set("n", "<leader>ldl", ":<C-u>CocList diagnostics<cr>", opts4)
-- Manage extensions
keymap.set("n", "<leader>lle", ":<C-u>CocList extensions<cr>", opts4)
-- Show commands
keymap.set("n", "<leader>lla", ":<C-u>CocList commands<cr>", opts4)
-- Find symbol of current document
keymap.set("n", "<leader>llo", ":<C-u>CocList outline<cr>", opts4)
-- Search workspace symbols
keymap.set("n", "<leader>lsa", ":<C-u>CocList -I symbols<cr>", opts4)
-- Do default action for next item
keymap.set("n", "<leader>lan", ":<C-u>CocNext<cr>", opts4)
-- Do default action for previous item
keymap.set("n", "<leader>lap", ":<C-u>CocPrev<cr>", opts4)
-- Resume latest coc list
keymap.set("n", "<leader>llr", ":<C-u>CocListResume<cr>", opts4)
