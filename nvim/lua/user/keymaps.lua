local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
KEYMAP = vim.api.nvim_set_keymap

--Remap space as leader key
-- KEYMAP("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
KEYMAP("n", "<C-h>", "<C-w>h", opts)
KEYMAP("n", "<C-j>", "<C-w>j", opts)
KEYMAP("n", "<C-k>", "<C-w>k", opts)
KEYMAP("n", "<C-l>", "<C-w>l", opts)

-- Resize with arrows
KEYMAP("n", "<C-Up>", ":resize +2<CR>", opts)
KEYMAP("n", "<C-Down>", ":resize -2<CR>", opts)
KEYMAP("n", "<C-Left>", ":vertical resize -2<CR>", opts)
KEYMAP("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
KEYMAP("n", "<S-l>", ":bnext<CR>", opts)
KEYMAP("n", "<S-h>", ":bprevious<CR>", opts)

-- Keymap("n", "<C-S-p>", "<cmd>", opts) doesn't work yet

-- Move text up and down
KEYMAP("n", "<A-j>", ":m .+1<CR>==", opts)
KEYMAP("n", "<A-k>", ":m .-2<CR>==", opts)

-- Insert --
-- Press jk fast to enter
KEYMAP("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
KEYMAP("v", "<", "<gv", opts)
KEYMAP("v", ">", ">gv", opts)

-- Move text up and down
KEYMAP("v", "<A-j>", ":m .+1<CR>==", opts)
KEYMAP("v", "<A-k>", ":m .-2<CR>==", opts)
KEYMAP("v", "p", '"_dP', opts) -- disable on paste copying what was underneath it
KEYMAP("v", "<S-p>", 'p', opts) -- enable shift p to copy paste like the default vim behavior

-- Visual Block --
-- Move text up and down
KEYMAP("x", "J", ":move '>+1<CR>gv-gv", opts)
KEYMAP("x", "K", ":move '<-2<CR>gv-gv", opts)
KEYMAP("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
KEYMAP("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- Keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- Keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- Keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- Keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
