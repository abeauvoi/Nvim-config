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

local function is_in_project_path(file_path, project_paths)
  for _, project_path in ipairs(project_paths) do
    if file_path:find(project_path, 1, true) then
      return true
    end
  end
  return false
end

local project_paths = helpers.split(
  vim.fn.glob('~/work/{phenix,clientsportal,bernollin}*'),
  '\n'
)

local tabstop_group = augroup('Tabstop', { clear = true })
autocmd({ 'BufEnter', 'BufRead', 'BufNewFile' }, {
  group = tabstop_group,
  pattern = '*',
  callback = function ()
    vim.schedule(function ()
      local buf_path = vim.fn.expand('%:p'):gsub('/', '\\')
      if (buf_path[0] == 'c') then
        buf_path[0] = 'C';
      end

      if is_in_project_path(buf_path, project_paths) then
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2;
      end
    end)
  end
})

local cleanup_group = augroup('Cleanup', { clear = true })
autocmd({ 'BufWritePre'}, {
  group = cleanup_group,
  pattern = '*',
  callback = function ()
    local function strip_trailing_whitespaces()
      local current_view = vim.fn.winsaveview()
      vim.cmd([[keeppatterns %s/\s\+$//e]])
      vim.fn.winrestview(current_view)
    end

    vim.schedule(strip_trailing_whitespaces)
  end
})

--local copilot_group = augroup('Copilot', { clear = true })
--autocmd({ 'BufRead', 'BufNewFile'}, {
--  group = copilot_group,
--  pattern = '*',
--  callback = function ()
--    vim.schedule(function ()
--      local buf_path = vim.fn.expand('%:p'):gsub('/', '\\')
--      if (buf_path[0] == 'c') then
--        buf_path[0] = 'C';
--      end
--
--      if is_in_project_path(buf_path, project_paths) then
--        vim.o.copilot_enabled = false;
--      end
--    end)
--  end
--})

local colorcolumn_group = augroup('Colorcolumn', { clear = true })
autocmd({ 'BufRead', 'BufNewFile', 'TextChanged', 'TextChangedI'}, {
  group = colorcolumn_group,
  pattern = '*',
  callback = function ()
    vim.fn.clearmatches()

    vim.fn.matchadd('ExtraLongLines', '\\%>80v.\\+')
  end
})

local function disableSyntaxTreesitter()
  local ts_disable_features = {
    "autotag",
    "highlight",
    "incremental_selection",
    "indent",
    "playground",
    "query_linter",
    "rainbow",
    "refactor.highlight_definitions",
    "refactor.navigation",
    "refactor.smart_rename",
    "refactor.highlight_current_scope",
    "textobjects.swap",
    "textobjects.move",
    "textobjects.lsp_interop",
    "textobjects.select",
  }

  -- Check if the TSBufDisable command exists
  if vim.fn.exists(':TSBufDisable') ~= 0 then
    for _, feature in ipairs(ts_disable_features) do
      vim.cmd(string.format("TSBufDisable %s", feature))
    end
  end

  vim.opt.foldmethod = "manual"
  vim.cmd("syntax clear")
  vim.cmd("syntax off")
  vim.cmd("filetype off")
  vim.opt.undofile = false
  vim.opt.swapfile = false
  vim.opt.loadplugins = false
end

local big_file_disable_group = augroup('BigFileDisable', { clear = true })
autocmd({"BufWinEnter", "BufReadPre", "FileReadPre"}, {
  group = "BigFileDisable",
  pattern = "*",
  callback = function()
    local fileSize = vim.fn.getfsize(vim.fn.expand("%"))
    if fileSize > 512 * 1024 then
      disableSyntaxTreesitter()
    end
  end,
})
