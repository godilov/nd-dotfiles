local lsp_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	local sev = severity and vim.diagnostic.severity[severity] or nil

	return function()
		go({ severity = sev })
	end
end

local lsp_servers = {
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
}

local lsp_daps = {
	"codelldb",
	"delve",
}

return {
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = true },
	{
		"rcarriga/nvim-notify",
		lazy = true,
		event = { "VeryLazy" },
		config = function()
			vim.notify = require("notify")
		end,
	},
	{
		"EdenEast/nightfox.nvim",
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
					bg0 = "#0D0D0D",
					bg1 = "#1A1A1A",
					bg2 = "#262626",
					bg3 = "#333333",
					bg4 = "#404040",
					fg0 = "#F2F2F2",
					fg1 = "#E6E6E6",
					fg2 = "#D9D9D9",
					fg3 = "#CCCCCC",
				},
			},
		},
		config = function()
			vim.cmd("colorscheme nightfox")
		end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		lazy = true,
		cmd = "Neotree",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		lazy = true,
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"folke/which-key.nvim",
		lazy = true,
		cmd = "WhichKey",
		event = { "VeryLazy" },
		dependencies = {
			"nvim-neo-tree/neo-tree.nvim",
			"nvim-telescope/telescope.nvim",
			"folke/snacks.nvim",
			"folke/persistence.nvim",
			"akinsho/bufferline.nvim",
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Keymaps Local",
			},

			{
				mode = { "n", "x" },
				expr = true,
				silent = true,
				{ "j", "v:count == 0 ? 'gj' : 'j'", desc = "Down" },
				{ "k", "v:count == 0 ? 'gk' : 'k'", desc = "Up" },
				{ "<Down>", "v:count == 0 ? 'gj' : 'j'", desc = "Down" },
				{ "<Up>", "v:count == 0 ? 'gk' : 'k'", desc = "Up" },
			},

			{ "[", group = "Prev" },
			{ "]", group = "Next" },
			{ "[t", "<CMD>tabprevious<cr>", desc = "Prev Tab" },
			{ "]t", "<CMD>tabnext<cr>", desc = "Next Tab" },
			{ "[b", "<CMD>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
			{ "]b", "<CMD>BufferLineCycleNext<CR>", desc = "Next Buffer" },
			{ "[B", "<CMD>BufferLineMovePrev<CR>", desc = "Move buffer prev" },
			{ "]B", "<CMD>BufferLineMoveNext<CR>", desc = "Move buffer next" },
			{ "[d", lsp_goto(false), desc = "Prev Diagnostic" },
			{ "]d", lsp_goto(true), desc = "Next Diagnostic" },
			{ "[h", lsp_goto(false, "HINT"), desc = "Prev Hint" },
			{ "]h", lsp_goto(true, "HINT"), desc = "Next Hint" },
			{ "[i", lsp_goto(false, "INFO"), desc = "Prev Info" },
			{ "]i", lsp_goto(true, "INFO"), desc = "Next Info" },
			{ "[w", lsp_goto(false, "WARN"), desc = "Prev Warning" },
			{ "]w", lsp_goto(true, "WARN"), desc = "Next Warning" },
			{ "[e", lsp_goto(false, "ERROR"), desc = "Prev Error" },
			{ "]e", lsp_goto(true, "ERROR"), desc = "Next Error" },
			{ "[q", vim.cmd.cprev, desc = "Prev Error" },
			{ "]q", vim.cmd.cnext, desc = "Next Error" },
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

			{ "<C-h>", "<C-w>h", desc = "Go to Left Window", remap = true },
			{ "<C-j>", "<C-w>j", desc = "Go to Lower Window", remap = true },
			{ "<C-k>", "<C-w>k", desc = "Go to Upper Window", remap = true },
			{ "<C-l>", "<C-w>l", desc = "Go to Right Window", remap = true },

			{ "<A-j>", "<CMD>execute 'move .+' . v:count1<CR>==", desc = "Move Down" },
			{ "<A-k>", "<CMD>execute 'move .-' . (v:count1 + 1)<CR>==", desc = "Move Up" },
			{ mode = { "i" }, "<A-j>", "<ESC><CMD>m .+1<CR>==gi", desc = "Move Down" },
			{ mode = { "i" }, "<A-k>", "<ESC><CMD>m .-2<CR>==gi", desc = "Move Up" },
			{ mode = { "v" }, "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<CR>gv=gv", desc = "Move Down" },
			{ mode = { "v" }, "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<CR>gv=gv", desc = "Move Up" },

			{ mode = { "v" }, "<", "<gv" },
			{ mode = { "v" }, ">", ">gv" },
			{ mode = { "n", "i", "v" }, "<ESC>", "<CMD>noh<CR><ESC>", desc = "Clear hlsearch" },

			{ "<C-Up>", "<CMD>resize +2<CR>", desc = "Increase Window Height" },
			{ "<C-Down>", "<CMD>resize -2<CR>", desc = "Decrease Window Height" },
			{ "<C-Left>", "<CMD>vertical resize -2<CR>", desc = "Decrease Window Width" },
			{ "<C-Right>", "<CMD>vertical resize +2<CR>", desc = "Increase Window Width" },

			{
				"<C-/>",
				function()
					require("snacks").terminal()
				end,
				desc = "Terminal Open",
			},
			{ mode = { "t" }, "<C-/>", "<CMD>close<CR>", desc = "Terminal Close" },

			{ "<A-h>", "<CMD>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
			{ "<A-j>", "<CMD>bdelete<cr>", desc = "Delete Buffer" },
			{ "<A-k>", "<CMD>enew<cr>", desc = "Create Buffer" },
			{ "<A-l>", "<CMD>BufferLineCycleNext<CR>", desc = "Next Buffer" },
			{ "<C-A-h>", "<CMD>tabprevious<cr>", desc = "Prev Tab" },
			{ "<C-A-j>", "<CMD>tabclose<cr>", desc = "Delete Tab" },
			{ "<C-A-k>", "<CMD>tabnew<cr>", desc = "Create Tab" },
			{ "<C-A-l>", "<CMD>tabnext<cr>", desc = "Next Tab" },

			{ "<leader>b", group = "Buffers" },
			{ "<leader>bc", "<CMD>enew<cr>", desc = "Create Buffer" },
			{ "<leader>bd", "<CMD>bdelete<cr>", desc = "Delete Buffer" },
			{ "<leader>br", "<CMD>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
			{ "<leader>bl", "<CMD>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
			{ "<leader>bp", "<CMD>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
			{ "<leader>bP", "<CMD>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },

			{ "<leader>t", group = "Tabs" },
			{ "<leader>tc", "<CMD>tabnew<cr>", desc = "Create Tab" },
			{ "<leader>td", "<CMD>tabclose<cr>", desc = "Delete Tab" },

			{ "<leader>", group = "Commands" },
			{ "<leader><space>", "<CMD>Telescope find_files<CR>", desc = "Find Files" },
			{ "<leader>/", "<CMD>Telescope live_grep<CR>", desc = "Find Live" },
			{ "<leader>.", "<CMD>Telescope grep_string<CR>", desc = "Find Grep" },
			{ "<leader>,", "<CMD>Telescope buffers<CR>", desc = "Find Buffer" },
			{ "<leader>:", "<CMD>Telescope command_history<CR>", desc = "Command History" },

			{ "<leader>f", group = "Files" },
			{ "<leader>ff", "<CMD>Telescope find_files<CR>", desc = "Find Files" },
			{ "<leader>fr", "<CMD>Telescope oldfiles<CR>", desc = "Find Recent" },
			{ "<leader>fl", "<CMD>Telescope live_grep<CR>", desc = "Find Live" },
			{ "<leader>fg", "<CMD>Telescope grep_string<CR>", desc = "Find Grep" },
			{ "<leader>fb", "<CMD>Telescope buffers<CR>", desc = "Find Buffer" },

			{ "<leader>s", group = "Search" },
			{ "<leader>sa", "<CMD>Telescope autocommands<CR>", desc = "Autocommands" },
			{ "<leader>sc", "<CMD>Telescope commands<CR>", desc = "Commands" },
			{ "<leader>sq", "<CMD>Telescope quickfix<CR>", desc = "Quickfix" },
			{ "<leader>sC", "<CMD>Telescope command_history<CR>", desc = "Command History" },
			{ "<leader>sQ", "<CMD>Telescope quickfixhistory<CR>", desc = "Quickfix History" },
			{ "<leader>sh", "<CMD>Telescope help_tags<CR>", desc = "Help Pages" },
			{ "<leader>sM", "<CMD>Telescope man_pages<CR>", desc = "Man Pages" },
			{ "<leader>sm", "<CMD>Telescope marks<CR>", desc = "Marks" },
			{ "<leader>sH", "<CMD>Telescope highlights<CR>", desc = "Highlights" },
			{ "<leader>ss", "<CMD>Telescope colorscheme<CR>", desc = "Colorschemes" },
			{ "<leader>sj", "<CMD>Telescope jumplist<CR>", desc = "Jumplist" },
			{ "<leader>sr", "<CMD>Telescope registers<CR>", desc = "Registers" },
			{ "<leader>so", "<CMD>Telescope vim_options<CR>", desc = "Options" },
			{ "<leader>sk", "<CMD>Telescope keymaps<CR>", desc = "Keymaps" },
			{ "<leader>sf", "<CMD>Telescope filetypes<CR>", desc = "Filetypes" },

			{ "<leader>g", group = "Git" },
			{ "<leader>gf", "<CMD>Telescope git_files<CR>", desc = "Git Files" },
			{ "<leader>gc", "<CMD>Telescope git_commits<CR>", desc = "Git Commits" },
			{ "<leader>gb", "<CMD>Telescope git_branches<CR>", desc = "Git Branches" },
			{ "<leader>gs", "<CMD>Telescope git_status<CR>", desc = "Git Status" },

			{ "g", group = "Goto" },
			{ "gd", "<CMD>Telescope lsp_definitions<CR>", desc = "Goto Definition" },
			{ "gr", "<CMD>Telescope lsp_references<CR>", desc = "Goto References" },
			{ "gI", "<CMD>Telescope lsp_implementations<CR>", desc = "Goto Implementation" },
			{ "gy", "<CMD>Telescope lsp_type_definitions<CR>", desc = "Goto T[y]pe Definition" },
			{ "gD", "<CMD>Telescope lsp_definitions<CR>", desc = "Goto Declaration" },
			{ mode = { "n", "i", "v" }, "<C-k>", vim.lsp.buf.hover, desc = "Hover" },
			{ mode = { "n", "i", "v" }, "<A-k>", vim.lsp.buf.signature_help, desc = "Signature" },

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

			{ "<leader>c", group = "Code" },
			{ "<leader>cm", "<CMD>Mason<CR>", desc = "Mason" },
			{ "<leader>cl", "<CMD>LspInfo<CR>", desc = "Lsp Info" },
			{ "<leader>cs", "<CMD>Telescope lsp_workspace_symbols<CR>", desc = "Symbols" },
			{ "<leader>cS", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", desc = "Symbols (Dynamic)" },
			{ "<leader>cD", "<CMD>Telescope diagnostics<CR>", desc = "Diagnostics (Global)" },
			{ "<leader>cd", "<CMD>Telescope diagnostics bufnr=0<CR>", desc = "Diagnostics (Local)" },
			{ "<leader>cx", vim.diagnostic.open_float, desc = "Line Diagnostics" },
			{ "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
			{ "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
			{
				"<leader>cf",
				function()
					vim.lsp.buf.format({ async = true })
				end,
				desc = "Rename",
			},
			{
				"<leader>cR",
				function()
					require("snacks").rename.rename_file()
				end,
				desc = "Rename File",
			},

			{ "<leader>ct", group = "Code Toggle" },
			{
				"<leader>cth",
				function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end,
				desc = "Toggle Inlay hints",
			},
			{
				"<leader>ctd",
				function()
					vim.diagnostic.enable(not vim.diagnostic.is_enabled())
				end,
				desc = "Toggle Diagnsotic",
			},

			{ "<leader>d", group = "Debug" },

			{ "<leader>i", group = "Interface" },
			{ "<leader>ii", "<CMD>Inspect<CR>", desc = "Inspect Position" },
			{ "<leader>iI", "<CMD>InspectTree<CR>", desc = "Inspect Tree" },

			{ "<leader>q", group = "Session" },
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
		opts = {
			spec = {},
		},
	},
	{
		"folke/noice.nvim",
		lazy = true,
		event = { "VeryLazy" },
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"folke/snacks.nvim",
		lazy = true,
		event = { "VeryLazy" },
	},
	{
		"folke/persistence.nvim",
		lazy = true,
		event = { "BufReadPre" },
	},
	{ "echasnovski/mini.nvim" },
	{ "lewis6991/gitsigns.nvim" },
	{
		"nvim-lualine/lualine.nvim",
		lazy = true,
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
		lazy = true,
		event = { "VeryLazy" },
		opts = {
			options = {
				diagnostics = "nvim_lsp",
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = true,
		event = { "LazyFile" },
		dependencies = {
			"saghen/blink.cmp",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = function()
			local cmp = require("blink.cmp")

			return {
				diagnostics = {
					severity_sort = true,
				},
				inlay_hints = {
					enabled = true,
				},
				codelens = {
					enabled = true,
				},
				document_highlight = {
					enabled = true,
				},
				capabilities = cmp.get_lsp_capabilities({
					workspace = {
						fileOperations = {
							didRename = true,
							willRename = true,
						},
					},
				}),
			}
		end,
		config = function()
			local lspconfig = require("lspconfig")

			for _, server in ipairs(lsp_servers) do
				lspconfig[server].setup()
			end
		end,
	},
	{
		"williamboman/mason.nvim",
		lazy = true,
		build = ":MasonUpdate",
		cmd = "Mason",
		event = { "VeryLazy" },
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = true,
		event = { "VeryLazy" },
		opts = {
			ensure_installed = vim.tbl_extend("force", lsp_servers, lsp_daps),
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = true,
		build = ":TSUpdate",
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
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
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = "<A-space>",
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
	},
	{ "folke/trouble.nvim" },
	{ "rcarriga/nvim-dap-ui" },
	{ "mfussenegger/nvim-dap" },
	{ "mfussenegger/nvim-lint" },
	{ "stevearc/overseer.nvim" },
	{ "Saecki/crates.nvim" },
	{ "mrcjkb/rustaceanvim/" },
	{
		"saghen/blink.cmp",
		lazy = true,
		build = "cargo build --release",
		event = "InsertEnter",

		opts_extend = { "sources.default" },
		opts = {
			sources = {
				default = { "lsp", "path", "buffer" },
			},
		},
	},
}
