vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.scrolloff = 8
vim.opt.termguicolors = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"

-- auto-detect pdc theme from ghostty config
local function detect_terminal_theme()
    local cfg = vim.fn.expand("~/.config/ghostty/config")
    local f = io.open(cfg, "r")
    if f then
        local content = f:read("*a")
        f:close()
        if content:match("theme = pdc%-light") then
            return "pdc-light"
        end
    end
    return "pdc-dark"
end

vim.cmd("colorscheme " .. detect_terminal_theme())
