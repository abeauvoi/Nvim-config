-- [[ Basic Keymaps ]]
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap esc in insert mode
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true })
vim.keymap.set('i', '<ESC>', '<NOP>', { noremap = true })

-- Remap arrow keys for switching buffers
vim.keymap.set('n', '<Left>', '<C-w><Left>', { noremap = true })
vim.keymap.set('n', '<Right>', '<C-w><Right>', { noremap = true })
vim.keymap.set('n', '<Up>', '<C-w><Up>', { noremap = true })
vim.keymap.set('n', '<Down>', '<C-w><Down>', { noremap = true })

-- Disable them in insert mode
vim.keymap.set('i', '<Left>', '<NOP>')
vim.keymap.set('i', '<Right>', '<NOP>')
vim.keymap.set('i', '<Up>', '<NOP>')
vim.keymap.set('i', '<Down>', '<NOP>')

-- Quit all buffers and save
vim.keymap.set('n', '<C-q>', ':wqall<CR>')

-- Search & replace over entire buffer
vim.keymap.set('n', ';;', ':%s:::g<Left><Left><Left>')

-- Uppercase word in insert & normal modes
vim.keymap.set('i', '<C-u>', '<ESC>viwUi')
vim.keymap.set('n', '<C-u>', 'viwU')

-- Revert all changes done to buffer
vim.keymap.set('n', '<leader>rv', ':u0<CR>')

-- Fast switching between buffers
local save_and_bprev = function ()
  if vim.bo.modifiable and not vim.bo.readonly and vim.bo.modified then
    vim.cmd('write')
  end
  vim.cmd('bprevious')
end
vim.keymap.set(
  'n',
  '<s-tab>',
  save_and_bprev,
  { noremap = true, silent = true }
)
vim.keymap.set(
  'i',
  '<s-tab>',
  save_and_bprev,
  { noremap = true, silent = true }
)

-- [[ Neotree ]]

-- Open & Focus on Neotree split
vim.keymap.set(
  'n',
  '<leader>nt',
  '<cmd>Neotree|<C-w><Left><CR>',
  { desc = 'Open & Focus on Neotree split' }
)

-- Editing config files
vim.keymap.set(
  'n',
  '<leader>vrc',
  '<cmd>e $MYVIMRC<CR>',
  { desc = 'Edit main config' }
)
vim.keymap.set(
  'n',
  '<leader>knf',
  '<cmd>e ~/AppData/Local/nvim/lua/config/<CR>',
  { desc = 'Open config directory' }
)

-- Clearing all buffers but one
vim.keymap.set(
  'n',
  '<leader>bx',
  '<cmd>BufOnly<CR>'
)

