vim.g['test#ruby#spec#executable'] = "bundle exec rspec"
vim.g['test#strategy'] = "tslime"

vim.keymap.set("n", "<leader>d", ":TestNearest<CR>")
vim.keymap.set("n", "<leader>t", ":TestFile<CR>")
vim.keymap.set("n", "<leader>a", ":TestSuite<CR>")
vim.keymap.set("n", "<leader>l", ":TestLast<CR>")
vim.keymap.set("n", "<leader>g", ":TestVisit<CR>")
