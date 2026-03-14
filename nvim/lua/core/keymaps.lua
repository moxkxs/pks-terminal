vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>td", function() vim.cmd("colorscheme pdc-dark") end, { desc = "Theme: pdc dark" })
vim.keymap.set("n", "<leader>tl", function() vim.cmd("colorscheme pdc-light") end, { desc = "Theme: pdc light" })
vim.keymap.set("n", "<leader>tc", function() vim.cmd("colorscheme cyberdream") end, { desc = "Theme: cyberdream" })
