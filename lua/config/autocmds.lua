local helpers = require 'config.helpers'

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


-- Set tabstop=2 on certain pro projects
local tabstop_group = augroup('Tabstop', { clear = true })
autocmd({ 'BufEnter', 'BufRead', 'BufNewFile' }, {
  group = tabstop_group,
  pattern = '*',
  callback = function ()

    local project_paths = helpers.split(
      vim.fn.glob('~/work/{phenix,clientsportal,bernollin}*'),
      '\n'
    )

    vim.schedule(function ()
      local git_root = vim.fn.system('git rev-parse --show-toplevel')
        -- remove trailing newline
        :gsub('\n', '')
        -- switch to dos-style path
        :gsub('/', '\\')
      for _, path in ipairs(project_paths) do
        if git_root == path then
          vim.opt_local.tabstop = 2
          vim.opt_local.shiftwidth = 2
          print('tabstop,shiftwidth=2')
        end
      end
    end)
  end
})
