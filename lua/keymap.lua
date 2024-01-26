local vscode = require('vscode-neovim')
local options = { noremap = true, silent = true }

-- 映射普通的 vsc 命令
local function keymap(mode, keys, action, actionOpts, isMulti)
  vim.keymap.set(mode, keys, function()
    local times = isMulti and vim.v.count > 0 and vim.v.count or 1
    for i = 1, times do
      if type(action) == "table" then
        for _, ac in ipairs(action) do
          vscode.action(ac)
        end
      else
        vscode.action(action, actionOpts)
      end
    end
  end, options)
end
-- 映射鼠标的上和下，解决移动时自动展开的问题
local function mapMove(key, direction)
  local vscode = require('vscode-neovim')
  vim.keymap.set({ 'n', 'x' }, key, function()
    vscode.action('cursorMove', {
      args = {
        to = direction,
        by = 'wrappedLine',
        value = 1
      }
    })
  end, options)
end
-- 转换
local function toCase(mode)
  local vscode = require('vscode-neovim')
  local st = '${TM_SELECTED_TEXT/(.*)/${1:/' .. mode .. '}/}'
  vscode.action('editor.action.insertSnippet', {
    args = {
      snippet = st
    }
  })
end

-- region 通用的
keymap('', '<leader>ff', 'workbench.action.findInFiles')
mapMove('gk', 'up')
mapMove('gj', 'down')
keymap({ 'x', 'n' }, 'H', 'workbench.action.previousEditorInGroup', nil, true)
keymap({ 'x', 'n' }, 'L', 'workbench.action.nextEditorInGroup', nil, true)
keymap({ 'x', 'n' }, 'K', 'editor.action.moveLinesUpAction', nil, true)
keymap({ 'x', 'n' }, 'J', 'editor.action.moveLinesDownAction', nil, true)
-- endregion
-- region 普通模式 normal
keymap('n', 'za', 'editor.toggleFold') -- 使用 vsc 的代码折叠 (上下移动会自动展开，目前没找到解决办法)
-- keymap('n', 'u', 'undo')                                       -- 撤销
-- keymap('n', '<C-r>', 'redo')                                   -- 重做（取消撤消）
keymap('n', '\\f', 'editor.action.formatDocument')             -- 格式化全文
keymap('n', 'gc', 'workbench.action.editor.nextchange')        -- 跳转到上一个改变（change），vcs（如git)中有用
keymap('n', 'gC', 'workbench.action.eitor.previousChange')     -- 跳转到下一个改变
keymap('n', 'gp', 'go-to-next-error.next.error')               -- 跳转到下一个错误（problem），需装插件 "Go to Next Error"
keymap('n', 'gP', 'go-to-next-error.prev.error')               -- 跳转到上一个错误
keymap('n', 'g1', 'workbench.action.focusFirstEditorGroup')    -- 聚集到分离窗口1
keymap('n', 'g2', 'workbench.action.focusSecondEditorGroup')   -- 聚集到分离窗口2
keymap('n', 'g3', 'workbench.action.focusThirdEditorGroup')    -- 聚集到分离窗口3
keymap('n', 'g4', 'workbench.action.focusFourthEditorGroup')   -- 聚集到分离窗口4
keymap('n', 'gs', 'workbench.action.gotoSymbol', nil, true)    -- 跳转 symbol
keymap('n', '<leader>fl', 'revealFileInOS')                    -- 在系统资源管理器中定位文件
keymap('n', '<leader>fe', 'workbench.explorer.fileView.focus') -- 在 vscode 资源管理器中定位文件

vim.keymap.set('n', '<leader>n', ':noh<CR>', options)

-- 向左分屏(会关闭原editor)
keymap('n', '<leader>sh',
  { "workbench.action.splitEditorToLeftGroup",
    "workbench.action.focusRightGroup",
    "workbench.action.closeActiveEditor",
    "workbench.action.focusLeftGroup"
  }
)
-- 向下分屏
keymap('n', '<leader>sj',
  { "workbench.action.splitEditorToBelowGroup",
    "workbench.action.focusAboveGroup",
    "workbench.action.closeActiveEditor",
    "workbench.action.focusBelowGroup"
  }
)
-- 向上分屏
keymap('n', '<leader>sk',
  { "workbench.action.splitEditorToAboveGroup",
    "workbench.action.focusBelowGroup",
    "workbench.action.closeActiveEditor",
    "workbench.action.focusAboveGroup"
  }
)
-- 向右分屏
keymap('n', '<leader>sl',
  { "workbench.action.splitEditorToRightGroup",
    "workbench.action.focusLeftGroup",
    "workbench.action.closeActiveEditor",
    "workbench.action.focusRightGroup"
  }
)
-- endregion
-- region visual 模式
keymap('x', '\\1', 'editor.action.transformToKebabcase') -- 转短横线（kebab: abc-cba)
keymap('x', '\\2', 'editor.action.transformToCamelcase') -- 转驼峰 （abc-cba: abcCba  Abc-cba: AbcCba)
-- vim.keymap.set('x', '\\2', function()
--   local vscode = require('vscode-neovim')
--   toCase('camelcase')
--   local s = vscode.action('editor.action.insertSnippet', {
--     args = {
--       snippet = '${TM_SELECTED_TEXT/(.)/${1:/upcase}/}'
--     }
--  })
--   print(s)
-- end, options)
-- 转大驼峰
vim.keymap.set('x', '\\3', function()
  toCase('pascalcase')
end, options)
keymap('x', '\\4', 'editor.action.transformToSnakecase') -- 转蛇形（snake: abc_cba）
-- 转大写
vim.keymap.set('x', '\\u', function()
  toCase('upcase')
end, options)
-- 转小写
vim.keymap.set('x', '\\l', function()
  toCase('downcase')
end, options)
-- 首字母转大写（capitalize: abcDef → AbcDef）
vim.keymap.set('x', '\\c', function()
  toCase('capitalize')
end, options)
keymap('x', '\\s', 'editor.action.surroundWithSnippet') -- 用指定内容包裹选中
keymap('x', '\\f', 'editor.action.formatSelection')     -- 格式化选中

