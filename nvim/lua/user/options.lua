local options = {
	number = true, -- set numbered lines
	relativenumber = true, -- set relative numbered lines
	numberwidth = 4, -- set number column width to 2 {default 4}

	expandtab = false, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab

	autoindent = true,
	-- cmdheight = 1,                           -- more space in the neovim command line for displaying messages

	mouse = "a", -- allow the mouse to be used in neovim

	exrc = false,
	hidden = true,
	errorbells = false,
	wrap = false,

	swapfile = false,
	backup = false, -- creates a backup file
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

	undofile = true, -- enable persistent undo
	undodir = os.getenv("HOME") .. "/.config/nvim/undodir",
	incsearch = true,

	scrolloff = 8, -- is one of my fav
	sidescrolloff = 8,

	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 2, -- always show tabs
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
	updatetime = 300, -- faster completion (4000ms default)
	cursorline = true, -- highlight the current line

	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	guifont = "Fira Code", -- the font used in graphical neovim applications

	laststatus = 3
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
