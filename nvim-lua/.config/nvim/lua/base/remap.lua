vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Pane navigation
vim.keymap.set("", "<C-J>", "<C-W>j")
vim.keymap.set("", "<C-K>", "<C-W>k")
vim.keymap.set("", "<C-H>", "<C-W>h")
vim.keymap.set("", "<C-L>", "<C-W>l")

-- [e]dit/[v]iew/[s]plit at current directory
vim.keymap.set("", "<leader>e", ":edit <C-R>=expand('%:h').'/'<cr>")
vim.keymap.set("", "<leader>s", ":sp <C-R>=expand('%:h').'/'<cr>")
vim.keymap.set("", "<leader>v", ":view <C-R>=expand('%:h').'/'<cr>")

-- Move Text in visual mode

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- cursor management
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


