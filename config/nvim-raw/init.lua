local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.mouse = "a"
opt.encoding = "utf-8"
opt.spelllang = { "en" }
opt.virtualedit = "block"
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

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

vim.api.nvim_create_augroup("LSP", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	group = "LSP",
	callback = function()
		vim.lsp.buf.hover()
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = "LSP",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})
