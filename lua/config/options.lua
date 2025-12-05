-- activated via init.lua `require("config.options")`
local opt = vim.opt

-- indent config
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.wrap = true
opt.breakindent = true
opt.showbreak = '...'

opt.list = true
opt.listchars = {
  tab = '>>',
  trail = '·',
  --  eol = '↲',
  extends = '▶',
  precedes = '◀',
}
