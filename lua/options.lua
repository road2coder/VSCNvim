local op = vim.opt
local b = vim.b
local g = vim.g

op.hlsearch = true -- 高亮搜索
op.ignorecase = true -- 忽略大小写
op.smartcase = true -- 智能大小写(有大写就不忽略)
op.clipboard='unnamedplus'
op.whichwrap:append('<')
op.whichwrap:append('>')
op.whichwrap:append('[')
op.whichwrap:append(']')
op.whichwrap:append('h')
op.whichwrap:append('l')

-- Global Settings --
g.mapleader = " "
