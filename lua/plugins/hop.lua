return {
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      local hop = require('hop')
      -- you can configure Hop the way you like here; see :h hop-config
      hop.setup()
      local dList = require('hop.hint').HintDirection
      vim.keymap.set({'n', 'v'}, 'f', function()
        hop.hint_char1({ direction = dList.AFTER_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set({'n', 'v'}, 'F', function()
        hop.hint_char1({ direction = dList.BEFORE_CURSOR, current_line_only = true })
      end, { remap = true })
      vim.keymap.set({'n', 'v'}, 't', function()
        hop.hint_char1({ direction = dList.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
      end, { remap = true })
      vim.keymap.set({'n', 'v'}, 'T', function()
        hop.hint_char1({ direction = dList.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
      end, { remap = true })
      vim.keymap.set({'n', 'v'}, ',k', function()
        hop.hint_lines_skip_whitespace({ direction = dList.BEFORE_CURSOR })
      end)
      vim.keymap.set({'n', 'v'}, ',j', function()
        hop.hint_lines_skip_whitespace({ direction = dList.AFTER_CURSOR })
      end)
      vim.keymap.set({'n', 'v'}, ',w', function()
        hop.hint_words({ direction = dList.AFTER_CURSOR })
      end)
      vim.keymap.set({'n', 'v'}, ',b', function()
        hop.hint_words({ direction = dList.BEFORE_CURSOR })
      end)
      vim.keymap.set({'n', 'v'}, ',s', function()
        hop.hint_char1()
      end)
    end
  },
}
