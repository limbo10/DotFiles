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
        lazy = true,
        config = function()
            o.timeout = true
            o.timeoutlen = 1000
            require('which-key').setup({
                window = {
                    border = "single",
                    padding = { 1, 1, 1, 1 },
                    margin = { 1, 0, 1, 0 },
                }
            })
        end,
    },
    {
        "neoclide/coc.nvim",
        branch = "release",
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        lazy = true
    },
    {
        "nvim-telescope/telescope.nvim",
        lazy = true,
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
            "nvim-telescope/telescope-project.nvim"
        },
        config = function()
            require("telescope").setup({
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
            require("telescope").load_extension "file_browser"
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
        "https://github.com/numToStr/Comment.nvim",
        config = function()
            require('Comment').setup({
                ignore = '^$', -- ignores empty lines
            })
        end
    },
    {
        --TODO much more extensible
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
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
        -- TODO Highly Extensible
        "akinsho/bufferline.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
        config = function ()
            require("bufferline").setup{}
        end
    },
    {
        -- TODO nothing is working 😢
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
        lazy = true,
        config = function()
          require("toggleterm").setup({
            persist_size = false,
          })
            function _G.set_terminal_keymaps()
                local opts = {buffer = 0}
                keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
                keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            end
            -- cmd('autocmd! ToggleTerm term://* lua set_terminal_keymaps()')

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

            api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            opt.termguicolors = true
            cmd [[highlight IndentBlanklineIndent1  guifg=#6a4c93 gui=nocombine]]
            cmd [[highlight IndentBlanklineIndent2  guifg=#565aa0 gui=nocombine]]
            cmd [[highlight IndentBlanklineIndent3  guifg=#4267ac gui=nocombine]]
            cmd [[highlight IndentBlanklineIndent4  guifg=#1982c4 gui=nocombine]]
            cmd [[highlight IndentBlanklineIndent5  guifg=#36949d gui=nocombine]]
            cmd [[highlight IndentBlanklineIndent6  guifg=#8ac926 gui=nocombine]]
            cmd [[highlight IndentBlanklineIndent7  guifg=#c5ca30 gui=nocombine]]
            cmd [[highlight IndentBlanklineIndent8  guifg=#ffca3a gui=nocombine]]
            cmd [[highlight IndentBlanklineIndent9  guifg=#ff924c gui=nocombine]]
            cmd [[highlight IndentBlanklineIndent10 guifg=#ff595e gui=nocombine]]
            opt.list = true
            -- opt.listchars:append "space:⋅"
            -- opt.listchars:append "eol:↴"
            require("indent_blankline").setup {
                space_char_blankline = " ",
                show_current_context_start = true,
                char_highlight_list = {
                    "IndentBlanklineIndent1",
                    "IndentBlanklineIndent2",
                    "IndentBlanklineIndent3",
                    "IndentBlanklineIndent4",
                    "IndentBlanklineIndent5",
                    "IndentBlanklineIndent6",
                    "IndentBlanklineIndent7",
                    "IndentBlanklineIndent8",
                    "IndentBlanklineIndent9",
                    "IndentBlanklineIndent10",
                },
            }
        end
    },
    {
        "folke/zen-mode.nvim",
        lazy = true,
        config = function()
            require("zen-mode").setup({
                window = {
                    width = .90 -- width will be 85% of the editor width
                }
            })
            keymap.set("n", "<C-a>", ":<C-u>ZenMode<cr>")
        end
    },
    {
        "ludovicchabant/vim-gutentags",
        lazy = true
    },
    {
        -- use coc-vimtex with it
        "xuhdev/vim-latex-live-preview",
        lazy = true
    },
    {
        "mattn/emmet-vim",
        ft = {"html", "js", "ts"}
    },
    {
        "tpope/vim-repeat"
    },
    {
        "easymotion/vim-easymotion",
        lazy = true,
        config = function()
            keymap.set("n", "<leader><leader>f", "<Plug>(easymotion-bd-f)")
            keymap.set("n", "<leader><leader>f", "<Plug>(easymotion-overwin-f)")

            keymap.set("n", "<leader><leader>s", "<Plug>(easymotion-bd-f2)")
            keymap.set("n", "<leader><leader>s", "<Plug>(easymotion-overwin-f2)")

            keymap.set("n", "<leader><leader>L", "<Plug>(easymotion-bd-jk)")
            keymap.set("n", "<leader><leader>L", "<Plug>(easymotion-overwin-line)")

            keymap.set("n", "<leader><leader>w", "<Plug>(easymotion-bd-w)")
            keymap.set("n", "<leader><leader>w", "<Plug>(easymotion-overwin-w)")

        end
    },
    {
        "haya14busa/incsearch-easymotion.vim",
        config = function()
            --TODO make it work
            keymap.set("n", "<leader><leader>z/", "<Plug>(incsearch-easymotion-/)")
            keymap.set("n", "<leader><leader>z?", "<Plug>(incsearch-easymotion-?)")
            keymap.set("n", "<leader><leader>zg/", "<Plug>(incsearch-easymotion-stay)")
        end
    },
    {
        "unblevable/quick-scope",
        config = function ()
            --TODO not taking o.qs or opt.qs
            -- o.qs_highlight_on_keys = { "f", "F", "t", "T" }
            -- o.qs_buftype_blacklist = { "terminal", "nofile" }
            -- o.qs_buftype_blacklist = { "terminal", "nofile" }
        end
    },
    {
        "sindrets/winshift.nvim",
        lazy = true,
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
        keymap.set("n", "<C-w>m", "<cmd>WinShift<cr>", {noremap = true}),
        keymap.set("n", "<C-w>x", "<cmd>WinShift swap<cr>", {noremap = true})
    },
    {
        "szw/vim-maximizer",
        lazy = true,
        keymap.set("n", "<C-w>f", "<cmd>MaximizerToggle<cr>", {noremap = true})
    },
    {
        "ntpeters/vim-better-whitespace",
        config = function ()
            g.strip_whitespace_on_save = 1
            g.current_line_whitespace_disabled_soft = 1
            g.strip_whitespace_confirm = 0
            g.strip_whitelines_at_eof = 1
            g.show_spaces_that_precede_tabs = 1
        end
    },
    {
        --TODO Read help
        'mg979/vim-visual-multi',
        lazy = true,
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
    }
})



-- ====================================================================================
--                  Vim Options
-- ====================================================================================
opt.mouse = 'a'
opt.syntax = 'on'
opt.number = true
opt.encoding='UTF-8'
opt.signcolumn = "yes"
opt.equalalways = true
opt.virtualedit = "all"
opt.relativenumber = true

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

opt.undofile = true
opt.undodir = "~/.config/nvim/.undo"

g.mapleader = " "

-- cmd([[clipboard+=unnamedplus]])

keymap.set('n', '"+p', '<C-p>', {})
keymap.set('n', '"+P', '<C-p>', {})
keymap.set('v', '"+p', '<C-p>', {})
keymap.set('v', '"+P', '<C-p>', {})

-- ====================================================================================
--                  Toggle Term
-- ====================================================================================


-- ====================================================================================
--                  Which Key
-- ====================================================================================
local wk = require("which-key")
-- nesting is allowed
-- TODO
--  * for important plugin coc, telescope create mapping for each action
wk.register({
  f = {
    name = "file", -- optional group name
    f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
    -- r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File", noremap=false, buffer = 123 }, -- additional options for creating the keymap
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" }, -- additional options for creating the keymap
    n = { "New File" }, -- just a label. don't create any mapping
    e = "Edit File", -- same as above
    ["1"] = "which_key_ignore",  -- special label to hide it in the popup
    b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
  },
}, { prefix = "<leader>" })


-- ====================================================================================
--                  Telescope
-- ====================================================================================
local builtin = require('telescope.builtin')
keymap.set('n', '<leader>tff', builtin.find_files, {})
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
keymap.set("n", "<leader>tcp", "<cmd>Telescope command_palette<cr>")

-- https://github.com/AckslD/nvim-neoclip.lua
-- TODO Configure it

-- https://github.com/ghassan0/telescope-glyph.nvim
keymap.set("n", "<leader>tglyph", "<cmd>Telescope glyph<cr>")

-- https://github.com/xiyaowong/telescope-emoji.nvim
keymap.set("n", "<leader>temoji", "<cmd>Telescope emoji<cr>")

-- https://github.com/TC72/telescope-tele-tabby.nvim
-- local tele_tabby_opts = themes.get_dropdown {
--     winblend = 10,
--     border = true,
--     previewer = false,
--     shorten_path = false,
--     heigth=20,
--     width= 120
--   }
--   TODO make a keyboard shortcut
-- keymap.set("n", "<leader>ttab", "<cmd>Telescope tele_tabby list()<cr>")

-- https://github.com/HUAHUAI23/telescope-session.nvim
keymap.set("n", "<leader>tsl", "<cmd>Telescope xray23 list<cr>")
keymap.set("n", "<leader>tss", "<cmd>Telescope xray23 save<cr>")

-- https://github.com/nvim-telescope/telescope-project.nvim
keymap.set("n", "<leader>tpl", "<cmd>Telescope project project<cr>")

-- https://github.com/nvim-telescope/telescope-file-browser.nvim
api.nvim_set_keymap("n", "<space>fb", ":Telescope file_browser", { noremap = true })


-- ====================================================================================
--                  Lualine
-- ====================================================================================


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
keymap.set("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
keymap.set("n", "<leader>cdp", "<Plug>(coc-diagnostic-prev)", {silent = true})
keymap.set("n", "<leader>cdn", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation
keymap.set("n", "<leader>cgd", "<Plug>(coc-definition)", {silent = true})
keymap.set("n", "<leader>cgtd", "<Plug>(coc-type-definition)", {silent = true})
keymap.set("n", "<leader>cgi", "<Plug>(coc-implementation)", {silent = true})
keymap.set("n", "<leader>cgr", "<Plug>(coc-references)", {silent = true})

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
keymap.set("n", "<leader>csd", '<CMD>lua _G.show_docs()<CR>', {silent = true})

--  =============================================================================
-- TODO make it alternative to Illuminate Plugin

-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
api.nvim_create_augroup("CocGroup", {})
api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})
keymap.set("n", "<leader>cpo", ':CocCommand document.jumpToPrevSymbol<CR>', {silent = true})
keymap.set("n", "<leader>cno", ':CocCommand document.jumpToNextSymbol<CR>', {silent = true})


--  ======================== uptill here in ToDo ================================
-- Symbol renaming
keymap.set("n", "<leader>crn", "<Plug>(coc-rename)", {silent = true})


-- Formatting selected code
keymap.set("x", "<leader>cfs", "<Plug>(coc-format-selected)", {silent = true})
keymap.set("n", "<leader>cfs", "<Plug>(coc-format-selected)", {silent = true})


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
keymap.set("x", "<leader>ccs", "<Plug>(coc-codeaction-selected)", opts2)
keymap.set("n", "<leader>ccs", "<Plug>(coc-codeaction-selected)", opts2)

-- Remap keys for apply code actions at the cursor position.
keymap.set("n", "<leader>ccc", "<Plug>(coc-codeaction-cursor)", opts2)
-- Remap keys for apply code actions affect whole buffer.
keymap.set("n", "<leader>cas", "<Plug>(coc-codeaction-source)", opts2)
-- Remap keys for applying codeActions to the current buffer
keymap.set("n", "<leader>cab", "<Plug>(coc-codeaction)", opts2)
-- Apply the most preferred quickfix action on the current line.
keymap.set("n", "<leader>cqf", "<Plug>(coc-fix-current)", opts2)

-- Remap keys for apply refactor code actions.
keymap.set("n", "<leader>cre", "<Plug>(coc-codeaction-refactor)", { silent = true })
keymap.set("x", "<leader>cr", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
keymap.set("n", "<leader>cr", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

-- Run the Code Lens actions on the current line
keymap.set("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts2)


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
api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

-- Add (Neo)Vim's native statusline support
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline
opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts4 = {silent = true, nowait = true}
-- Show all diagnostics
keymap.set("n", "<leader>cld", ":<C-u>CocList diagnostics<cr>", opts4)
-- Manage extensions
keymap.set("n", "<leader>cle", ":<C-u>CocList extensions<cr>", opts4)
-- Show commands
keymap.set("n", "<leader>clc", ":<C-u>CocList commands<cr>", opts4)
-- Find symbol of current document
keymap.set("n", "<leader>clo", ":<C-u>CocList outline<cr>", opts4)
-- Search workspace symbols
keymap.set("n", "<leader>cls", ":<C-u>CocList -I symbols<cr>", opts4)
-- Do default action for next item
keymap.set("n", "<leader>cdan", ":<C-u>CocNext<cr>", opts4)
-- Do default action for previous item
keymap.set("n", "<leader>cdap", ":<C-u>CocPrev<cr>", opts4)
-- Resume latest coc list
keymap.set("n", "<leader>clr", ":<C-u>CocListResume<cr>", opts4)
