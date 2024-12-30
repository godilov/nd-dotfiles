local lazyrepo = "https://github.com/folke/lazy.nvim.git"
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.diagnostic.config({
    signs = true,
    float = true,
    underline = true,
    severity_sort = true,
    update_in_insert = true,
    virtual_text = false,
})

local opt = vim.opt

opt.mouse = "a"
opt.encoding = "utf-8"
opt.spelllang = { "en" }
opt.virtualedit = "block"
-- opt.foldmethod = "expr"
-- opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

opt.autowrite = true
opt.autowriteall = true
opt.autoindent = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.splitright = true
opt.splitbelow = true
opt.smartcase = true
opt.smartindent = true
opt.termguicolors = true
opt.smoothscroll = false
opt.confirm = true
opt.list = true
opt.gdefault = true
opt.undofile = true
opt.undolevels = 10000

opt.signcolumn = "yes"
opt.showmode = false
opt.ruler = false

opt.laststatus = 3
opt.tabstop = 4
opt.softtabstop = 4
opt.expandtab = true
opt.shiftwidth = 4
opt.shiftround = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.winminwidth = 8
opt.pumheight = 16
opt.timeoutlen = 250
opt.updatetime = 200

opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

local lsp_autoformat = true

vim.api.nvim_create_augroup("LSP", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    group = "LSP",
    callback = function()
        if lsp_autoformat then
            vim.lsp.buf.format({ async = false })
        end
    end,
})

local lsp_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    local sev = severity and vim.diagnostic.severity[severity] or nil

    return function()
        go({ severity = sev })
    end
end

require("lazy").setup({
    defaults = {
        lazy = true,
    },
    spec = {
        { "nvim-tree/nvim-web-devicons" },
        { "nvim-lua/plenary.nvim" },
        { "MunifTanjim/nui.nvim" },
        { "nvim-neotest/nvim-nio" },
        { "rcarriga/nvim-notify" },
        {
            "EdenEast/nightfox.nvim",
            lazy = false,
            priority = 1000,
            build = ":NightfoxCompile",
            opts = {
                palettes = {
                    nightfox = {
                        black = { base = "#262626", bright = "#333333", dim = "#1A1A1A" },
                        white = { base = "#D9D9D9", bright = "#E6E6E6", dim = "#CCCCCC" },
                        red = { base = "#F98686", bright = "#FFB3B3", dim = "#ED5E5E" },
                        orange = { base = "#F9AC86", bright = "#FFCCB3", dim = "#ED8E5E" },
                        yellow = { base = "#F9D385", bright = "#FFE5B3", dim = "#EDBE5E" },
                        green = { base = "#F9F985", bright = "#FFFFB3", dim = "#EDED5E" },
                        cyan = { base = "#86F9F9", bright = "#B3FFFF", dim = "#5EEDED" },
                        blue = { base = "#86D2F9", bright = "#B3E5FF", dim = "#5EBEED" },
                        magenta = { base = "#F985D3", bright = "#FFB3E5", dim = "#ED5EBE" },
                        pink = { base = "#F986AC", bright = "#FFB3CC", dim = "#ED5E8E" },
                        bg0 = "#000000",
                        bg1 = "#0D0D0D",
                        bg2 = "#1A1A1A",
                        bg3 = "#262626",
                        bg4 = "#333333",
                        fg0 = "#FFFFFF",
                        fg1 = "#F2F2F2",
                        fg2 = "#E6E6E6",
                        fg3 = "#D9D9D9",
                    },
                },
            },
        },
        {
            "nvim-neo-tree/neo-tree.nvim",
            cmd = "Neotree",
            dependencies = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
                "MunifTanjim/nui.nvim",
            },
            keys = {
                {
                    "<leader>fe",
                    function()
                        require("neo-tree.command").execute({ toggle = true })
                    end,
                    desc = "Explorer NeoTree",
                },
                {
                    "<leader>ge",
                    function()
                        require("neo-tree.command").execute({ source = "git_status", toggle = true })
                    end,
                    desc = "Git Explorer",
                },
                {
                    "<leader>be",
                    function()
                        require("neo-tree.command").execute({ source = "buffers", toggle = true })
                    end,
                    desc = "Buffer Explorer",
                },
            },
        },
        {
            "ibhagwan/fzf-lua",
            cmd = "FzfLua",
            dependencies = {
                "nvim-tree/nvim-web-devicons"
            },
            keys = {
                { "<leader><space>", "<CMD>FzfLua files<CR>",           desc = "Find Files" },
                { "<leader>/",       "<CMD>FzfLua live_grep<CR>",       desc = "Find Live" },
                { "<leader>.",       "<CMD>FzfLua grep<CR>",            desc = "Find Grep" },
                { "<leader>,",       "<CMD>FzfLua buffers<CR>",         desc = "Find Buffer" },
                { "<leader>:",       "<CMD>FzfLua command_history<CR>", desc = "Command History" },

                { "<leader>ff",      "<CMD>FzfLua files<CR>",           desc = "Find Files" },
                { "<leader>fr",      "<CMD>FzfLua oldfiles<CR>",        desc = "Find Recent" },
                { "<leader>fl",      "<CMD>FzfLua live_grep<CR>",       desc = "Find Live" },
                { "<leader>fg",      "<CMD>FzfLua grep<CR>",            desc = "Find Grep" },
                { "<leader>fb",      "<CMD>FzfLua buffers<CR>",         desc = "Find Buffer" },

                { "<leader>sa",      "<CMD>FzfLua autocmds<CR>",        desc = "Autocommands" },
                { "<leader>sc",      "<CMD>FzfLua commands<CR>",        desc = "Commands" },
                { "<leader>sq",      "<CMD>FzfLua quickfix<CR>",        desc = "Quickfix" },
                { "<leader>sC",      "<CMD>FzfLua command_history<CR>", desc = "Command History" },
                { "<leader>sQ",      "<CMD>FzfLua quickfix_stack<CR>",  desc = "Quickfix Stack" },
                { "<leader>sh",      "<CMD>FzfLua helptags<CR>",        desc = "Help Pages" },
                { "<leader>sM",      "<CMD>FzfLua manpages<CR>",        desc = "Man Pages" },
                { "<leader>sm",      "<CMD>FzfLua marks<CR>",           desc = "Marks" },
                { "<leader>sj",      "<CMD>FzfLua jumps<CR>",           desc = "Jumps" },
                { "<leader>sr",      "<CMD>FzfLua registers<CR>",       desc = "Registers" },
                { "<leader>sH",      "<CMD>FzfLua highlights<CR>",      desc = "Highlights" },
                { "<leader>ss",      "<CMD>FzfLua colorschemes<CR>",    desc = "Colorschemes" },
                { "<leader>sk",      "<CMD>FzfLua keymaps<CR>",         desc = "Keymaps" },
                { "<leader>sf",      "<CMD>FzfLua filetypes<CR>",       desc = "Filetypes" },

                { "<leader>gf",      "<CMD>FzfLua git_files<CR>",       desc = "Git Files" },
                { "<leader>gc",      "<CMD>FzfLua git_commits<CR>",     desc = "Git Commits (Global)" },
                { "<leader>gC",      "<CMD>FzfLua git_bcommits<CR>",    desc = "Git Commits (Local)" },
                { "<leader>gb",      "<CMD>FzfLua git_branches<CR>",    desc = "Git Branches" },
                { "<leader>gs",      "<CMD>FzfLua git_status<CR>",      desc = "Git Status" },
            },
        },
        {
            "nvim-lualine/lualine.nvim",
            event = { "VeryLazy" },
            opts = {
                options = {
                    theme = "auto",
                    globalstatus = vim.o.laststatus == 3,
                    disabled_filetypes = {
                        statusline = {
                            "dashboard",
                            "alpha",
                            "ministarter",
                            "snacks_dashboard",
                        },
                    },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = {
                        { "filesize" },
                        { "filename", path = 4 },
                    },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                extensions = { "neo-tree", "lazy" },
            },
        },
        {
            "akinsho/bufferline.nvim",
            event = { "VeryLazy" },
            opts = {
                options = {
                    diagnostics = "nvim_lsp",
                    always_show_bufferline = false,
                },
            },
            keys = {
                { "[b",         "<CMD>BufferLineCyclePrev<CR>",            desc = "Prev Buffer" },
                { "]b",         "<CMD>BufferLineCycleNext<CR>",            desc = "Next Buffer" },
                { "[B",         "<CMD>BufferLineMovePrev<CR>",             desc = "Move buffer prev" },
                { "]B",         "<CMD>BufferLineMoveNext<CR>",             desc = "Move buffer next" },

                { "<A-h>",      "<CMD>BufferLineCyclePrev<CR>",            desc = "Prev Buffer" },
                { "<A-l>",      "<CMD>BufferLineCycleNext<CR>",            desc = "Next Buffer" },

                { "<leader>br", "<CMD>BufferLineCloseRight<CR>",           desc = "Delete Buffers to the Right" },
                { "<leader>bl", "<CMD>BufferLineCloseLeft<CR>",            desc = "Delete Buffers to the Left" },
                { "<leader>bp", "<CMD>BufferLineTogglePin<CR>",            desc = "Toggle Pin" },
                { "<leader>bP", "<CMD>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
            },
        },
        {
            "folke/which-key.nvim",
            cmd = "WhichKey",
            event = { "VeryLazy" },
            keys = {
                {
                    "<leader>?",
                    function()
                        require("which-key").show({ global = false })
                    end,
                    desc = "Keymaps Local",
                },

                { "j",          "v:count == 0 ? 'gj' : 'j'",   desc = "Down",                  mode = { "n", "x" },     expr = true, silent = true, },
                { "k",          "v:count == 0 ? 'gk' : 'k'",   desc = "Up",                    mode = { "n", "x" },     expr = true, silent = true, },
                { "<Down>",     "v:count == 0 ? 'gj' : 'j'",   desc = "Down",                  mode = { "n", "x" },     expr = true, silent = true, },
                { "<Up>",       "v:count == 0 ? 'gk' : 'k'",   desc = "Up",                    mode = { "n", "x" },     expr = true, silent = true, },

                { "[t",         "<CMD>tabprevious<CR>",        desc = "Prev Tab" },
                { "]t",         "<CMD>tabnext<CR>",            desc = "Next Tab" },
                { "[q",         vim.cmd.cprev,                 desc = "Prev Error" },
                { "]q",         vim.cmd.cnext,                 desc = "Next Error" },

                { "<C-h>",      "<C-w>h",                      desc = "Go to Left Window",     remap = true },
                { "<C-j>",      "<C-w>j",                      desc = "Go to Lower Window",    remap = true },
                { "<C-k>",      "<C-w>k",                      desc = "Go to Upper Window",    remap = true },
                { "<C-l>",      "<C-w>l",                      desc = "Go to Right Window",    remap = true },

                -- { "<A-j>", "<CMD>execute 'move .+' . v:count1<CR>==", desc = "Move Down" },
                -- { "<A-k>", "<CMD>execute 'move .-' . (v:count1 + 1)<CR>==", desc = "Move Up" },
                -- { mode = { "i" }, "<A-j>", "<ESC><CMD>m .+1<CR>==gi", desc = "Move Down" },
                -- { mode = { "i" }, "<A-k>", "<ESC><CMD>m .-2<CR>==gi", desc = "Move Up" },
                -- { mode = { "v" }, "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", desc = "Move Down" },
                -- { mode = { "v" }, "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv", desc = "Move Up" },

                { "<",          "<gv",                         mode = { "v" }, },
                { ">",          ">gv",                         mode = { "v" }, },
                { "<ESC>",      "<CMD>noh<CR><ESC>",           mode = { "n", "i", "v" },       desc = "Clear hlsearch", },

                { "<C-Up>",     "<CMD>resize +2<CR>",          desc = "Increase Window Height" },
                { "<C-Down>",   "<CMD>resize -2<CR>",          desc = "Decrease Window Height" },
                { "<C-Left>",   "<CMD>vertical resize -2<CR>", desc = "Decrease Window Width" },
                { "<C-Right>",  "<CMD>vertical resize +2<CR>", desc = "Increase Window Width" },

                { "<A-h>",      "<CMD>bprev<CR>",              desc = "Prev Buffer" },
                { "<A-j>",      "<CMD>bdelete<CR>",            desc = "Delete Buffer" },
                { "<A-k>",      "<CMD>enew<CR>",               desc = "Create Buffer" },
                { "<A-l>",      "<CMD>bnext<CR>",              desc = "Next Buffer" },

                { "<C-A-h>",    "<CMD>tabprevious<CR>",        desc = "Prev Tab" },
                { "<C-A-j>",    "<CMD>tabclose<CR>",           desc = "Delete Tab" },
                { "<C-A-k>",    "<CMD>tabnew<CR>",             desc = "Create Tab" },
                { "<C-A-l>",    "<CMD>tabnext<CR>",            desc = "Next Tab" },

                { "<leader>bc", "<CMD>enew<CR>",               desc = "Create Buffer" },
                { "<leader>bd", "<CMD>bdelete<CR>",            desc = "Delete Buffer" },

                { "<leader>tc", "<CMD>tabnew<CR>",             desc = "Create Tab" },
                { "<leader>td", "<CMD>tabclose<CR>",           desc = "Delete Tab" },

                { "<leader>ul", "<CMD>Lazy<CR>",               desc = "Lazy" },
                { "<leader>ui", "<CMD>Inspect<CR>",            desc = "Inspect Position" },
                { "<leader>uI", "<CMD>InspectTree<CR>",        desc = "Inspect Tree" },
            },
            opts = {
                spec = {
                    { "[",         group = "Prev" },
                    { "]",         group = "Next" },
                    { "g",         group = "Goto" },
                    { "<leader>",  group = "Commands" },
                    { "<leader>b", group = "Buffers" },
                    { "<leader>t", group = "Tabs" },
                    { "<leader>f", group = "Files" },
                    { "<leader>s", group = "Search" },
                    { "<leader>g", group = "Git" },
                    { "<leader>c", group = "Code/LSP" },
                    { "<leader>d", group = "Debug" },
                    { "<leader>u", group = "UI" },
                    { "<leader>n", group = "Notifications" },
                    { "<leader>q", group = "Session" },
                },
            },
        },
        {
            "folke/noice.nvim",
            lazy = false,
            dependencies = {
                "MunifTanjim/nui.nvim",
                "rcarriga/nvim-notify",
                "nvim-treesitter/nvim-treesitter",
            },
            opts = {},
            keys = {
                { "<leader>nh", "<CMD>Noice<CR>",         desc = "History" },
                { "<leader>nd", "<CMD>Noice dismiss<CR>", desc = "Dismiss" },
                { "<leader>ne", "<CMD>Noice errors<CR>",  desc = "Errors" },
            },
        },
        {
            "folke/snacks.nvim",
            lazy = false,
            keys = {
                {
                    "<C-/>",
                    function()
                        require("snacks").terminal()
                    end,
                    desc = "Terminal Open",
                },
                { "<C-/>", "<CMD>close<CR>", desc = "Terminal Close", mode = { "t" }, },
            },
        },
        {
            "folke/persistence.nvim",
            event = { "BufReadPre" },
            keys = {
                {
                    "<leader>ql",
                    function()
                        require("persistence").load()
                    end,
                    desc = "Session Load",
                },
                {
                    "<leader>qs",
                    function()
                        require("persistence").select()
                    end,
                    desc = "Session Select",
                },
                {
                    "<leader>qd",
                    function()
                        require("persistence").stop()
                    end,
                    desc = "Session Stop",
                },
            },
        },
        {
            "folke/trouble.nvim",
            cmd = "Trouble",
            dependencies = {
                "neovim/nvim-lspconfig",
            },
        },
        {
            "echasnovski/mini.nvim",
            event = { "VeryLazy" },
        },
        {
            "lewis6991/gitsigns.nvim",
            event = { "VeryLazy" },
        },
        {
            "neovim/nvim-lspconfig",
            event = { "VeryLazy" },
            dependencies = {
                "folke/snacks.nvim",
                "williamboman/mason.nvim",
                "williamboman/mason-lspconfig.nvim",
            },
            keys = {
                { "[d", lsp_goto(false),          desc = "Prev Diagnostic" },
                { "]d", lsp_goto(true),           desc = "Next Diagnostic" },
                { "[h", lsp_goto(false, "HINT"),  desc = "Prev Hint" },
                { "]h", lsp_goto(true, "HINT"),   desc = "Next Hint" },
                { "[i", lsp_goto(false, "INFO"),  desc = "Prev Info" },
                { "]i", lsp_goto(true, "INFO"),   desc = "Next Info" },
                { "[w", lsp_goto(false, "WARN"),  desc = "Prev Warning" },
                { "]w", lsp_goto(true, "WARN"),   desc = "Next Warning" },
                { "[e", lsp_goto(false, "ERROR"), desc = "Prev Error" },
                { "]e", lsp_goto(true, "ERROR"),  desc = "Next Error" },
                {
                    "]]",
                    function()
                        require("snacks").words.jump(vim.v.count1)
                    end,
                    desc = "Next Reference",
                },
                {
                    "[[",
                    function()
                        require("snacks").words.jump(-vim.v.count1)
                    end,
                    desc = "Prev Reference",
                },

                { "gd",         "<CMD>FzfLua lsp_definitions<CR>",                  desc = "Goto Definition" },
                { "gr",         "<CMD>FzfLua lsp_references<CR>",                   desc = "Goto References" },
                { "gI",         "<CMD>FzfLua lsp_implementations<CR>",              desc = "Goto Implementation" },
                { "gy",         "<CMD>FzfLua lsp_typedefs<CR>",                     desc = "Goto T[y]pe Definition" },
                { "gD",         "<CMD>FzfLua lsp_declarations<CR>",                 desc = "Goto Declaration" },
                { "<C-\\>",     vim.lsp.buf.hover,                                  desc = "Hover",                 mode = { "n", "i", "v" }, },
                { "<A-\\>",     vim.lsp.buf.signature_help,                         desc = "Signature",             mode = { "n", "i", "v" }, },

                { "<leader>cm", "<CMD>Mason<CR>",                                   desc = "Mason" },
                { "<leader>cL", "<CMD>LspInfo<CR>",                                 desc = "Lsp Info" },
                { "<leader>cs", "<CMD>FzfLua lsp_workspace_symbols<CR>",            desc = "Symbols (Global)" },
                { "<leader>cS", "<CMD>FzfLua lsp_document_symbols<CR>",             desc = "Symbols (Local)" },
                { "<leader>cd", "<CMD>FzfLua lsp_workspace_diagnostics<CR>",        desc = "Diagnostics (Local)" },
                { "<leader>cD", "<CMD>FzfLua lsp_document_diagnostics<CR>",         desc = "Diagnostics (Global)" },
                { "<leader>cQ", "<CMD>Trouble diagnostics toggle<CR>",              desc = "Diagnostics (Global)" },
                { "<leader>cq", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Diagnostics (Local)" },
                { "<leader>ca", "<CMD>FzfLua lsp_code_actions<CR>",                 desc = "Code Action" },
                { "<leader>ci", "<CMD>FzfLua lsp_incoming_calls<CR>",               desc = "Incoming Calls" },
                { "<leader>co", "<CMD>FzfLua lsp_outgoing_calls<CR>",               desc = "Outcoming Calls" },
                { "<leader>cx", vim.diagnostic.open_float,                          desc = "Line Diagnostics" },
                { "<leader>cr", vim.lsp.buf.rename,                                 desc = "Rename" },
                {
                    "<leader>cf",
                    function()
                        vim.lsp.buf.format({ async = true })
                    end,
                    desc = "Format",
                },
                {
                    "<leader>cR",
                    function()
                        require("snacks").rename.rename_file()
                    end,
                    desc = "Rename File",
                },

                {
                    "<leader>ctf",
                    function()
                        lsp_autoformat = not lsp_autoformat
                    end,
                    desc = "Toggle Autoformat",
                },
                {
                    "<leader>cth",
                    function()
                        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                    end,
                    desc = "Toggle Inlay Hints",
                },
                {
                    "<leader>ctd",
                    function()
                        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
                    end,
                    desc = "Toggle Diagnsotic",
                },
            },
        },
        {
            "williamboman/mason.nvim",
            cmd = "Mason",
            dependencies = {
                "saghen/blink.cmp",
                "jay-babu/mason-nvim-dap.nvim",
                "williamboman/mason-lspconfig.nvim",
            },
            opts = {
                lsp = {
                    handlers = {
                        function(server)
                            require("lspconfig")[server].setup({
                                capabilities = require("blink.cmp").get_lsp_capabilities(),
                            })
                        end,
                    },
                    ensure_installed = {
                        "rust_analyzer",
                        "glsl_analyzer",
                        "gopls",
                        "solang",
                        "clangd",
                        "neocmake",
                        "sqls",
                        "hls",

                        "lua_ls",
                        "bashls",
                        "ts_ls",
                        "html",
                        "htmx",
                        "cssls",

                        "jsonls",
                        "taplo",
                        "yamlls",

                        "dockerls",
                        "docker_compose_language_service",
                        "marksman",
                        "texlab",
                    },
                },
                dap = {
                    ensure_installed = {
                        "codelldb",
                        "delve",
                    },
                },
            },
            config = function(_, opts)
                require("mason").setup()
                require("mason-lspconfig").setup(opts.lsp)
                require("mason-nvim-dap").setup(opts.dap)
            end
        },
        {
            "williamboman/mason-lspconfig.nvim",
            config = function() end,
        },
        {
            "jay-babu/mason-nvim-dap.nvim",
            config = function() end,
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            cmd = { "TSUpdate", "TSInstall" },
            event = { "VeryLazy" },
            opts = {
                ensure_installed = {
                    "lua",
                    "bash",
                    "query",
                    "bibtex",
                    "latex",
                    "cmake",
                    "ninja",
                    "asm",
                    "c",
                    "cpp",
                    "go",
                    "rust",
                    "haskell",
                    "dockerfile",
                    "cuda",
                    "glsl",
                    "proto",
                    "sql",
                    "html",
                    "css",
                    "scss",
                    "regex",
                    "javascript",
                    "typescript",
                    "json",
                    "yaml",
                    "toml",
                    "tmux",
                    "diff",
                    "git_config",
                    "git_rebase",
                    "gitattributes",
                    "gitcommit",
                    "gitignore",
                },
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-Space>",
                        node_incremental = "<C-Space>",
                        scope_incremental = "<A-Space>",
                        node_decremental = "<BR>",
                    },
                },
                textobjects = {
                    move = {
                        enable = true,
                        goto_next_start = {
                            ["]f"] = "@function.outer",
                            ["]c"] = "@class.outer",
                            ["]a"] = "@parameter.inner",
                        },
                        goto_next_end = {
                            ["]F"] = "@function.outer",
                            ["]C"] = "@class.outer",
                            ["]A"] = "@parameter.inner",
                        },
                        goto_previous_start = {
                            ["[f"] = "@function.outer",
                            ["[c"] = "@class.outer",
                            ["[a"] = "@parameter.inner",
                        },
                        goto_previous_end = {
                            ["[F"] = "@function.outer",
                            ["[C"] = "@class.outer",
                            ["[A"] = "@parameter.inner",
                        },
                    },
                },
            },
            keys = {
                { "[f", desc = "Prev Function Start" },
                { "[c", desc = "Prev Class Start" },
                { "[a", desc = "Prev Paramater Start" },
                { "[F", desc = "Prev Function End" },
                { "[C", desc = "Prev Class End" },
                { "[A", desc = "Prev Paramater End" },

                { "]f", desc = "Next Function Start" },
                { "]c", desc = "Next Class Start" },
                { "]a", desc = "Next Paramater Start" },
                { "]F", desc = "Next Function End" },
                { "]C", desc = "Next Class End" },
                { "]A", desc = "Next Paramater End" },
            },
        },
        {
            "rcarriga/nvim-dap-ui",
            dependencies = {
                "mfussenegger/nvim-dap",
                "nvim-neotest/nvim-nio",
            },
        },
        {
            "mfussenegger/nvim-dap",
        },
        {
            "mfussenegger/nvim-lint",
        },
        {
            "stevearc/overseer.nvim"
        },
        {
            "Saecki/crates.nvim",
            event = { "BufRead Cargo.toml" },
        },
        -- {
        --     "mrcjkb/rustaceanvim",
        --     lazy = false,
        -- },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    {
                        path = "${3rd}/luv/library",
                        words = { "vim%.uv" },
                    },
                },
            },
        },
        {
            "MeanderingProgrammer/render-markdown.nvim",
            dependencies = {
                "nvim-treesitter/nvim-treesitter",
                "nvim-tree/nvim-web-devicons",
            },
            opts = {},
        },
        {
            "saghen/blink.cmp",
            build = "cargo build --release",
            event = "InsertEnter",
            opts_extend = { "sources.default" },
            opts = {
                sources = {
                    default = { "lsp", "path", "buffer", "markdown", "lazydev" },
                    providers = {
                        lazydev = {
                            name = "LazyDev",
                            module = "lazydev.integrations.blink",
                            score_offset = 100,
                        },
                        markdown = {
                            name = "RenderMarkdown",
                            module = "render-markdown.integ.blink",
                            fallbacks = { 'lsp' },
                        },
                    },
                },
            },
        },
    },
    checker = { enabled = true },
})

vim.cmd("colorscheme nightfox")
