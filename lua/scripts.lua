-- 高亮 yank
vim.api.nvim_exec([[
  autocmd TextYankPost * silent! lua vim.highlight.on_yank{timeout=200}
]], false)

-- 输入法状态 win32 win64 unix(macunix) https://neovim.io/doc/user/builtin.html
if vim.fn.has('win64') == 1 then
  vim.api.nvim_exec([[autocmd VimEnter * :silent !im-select 1033]], false)
  vim.api.nvim_exec([[autocmd InsertEnter * :silent :!im-select 2052]], false)
  vim.api.nvim_exec([[autocmd InsertLeave * :silent :!im-select 1033]], false)
  vim.api.nvim_exec([[autocmd VimLeave * :silent !im-select 2052]], false)
elseif vim.fn.has('linux') then
  vim.api.nvim_exec([[autocmd InsertEnter * :silent :!im-select 2052]], false)
  vim.api.nvim_exec([[autocmd InsertLeave * :silent :!fcitx5-remote -s keyboard-us]], false)
end
