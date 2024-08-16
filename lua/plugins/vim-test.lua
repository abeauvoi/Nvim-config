-- lua/plugins/vim-test.lua
return {
    'vim-test/vim-test',
    config = function()
        -- Define key mappings for vim-test
        vim.api.nvim_set_keymap(
            'n',
            '<leader>tn',
            ':TestNearest<CR>',
            { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap('n',
            '<leader>tf',
            ':TestFile<CR>',
            { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
            'n',
            '<leader>ts',
            ':TestSuite<CR>',
            { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
            'n',
            '<leader>tl',
            ':TestLast<CR>',
            { noremap = true, silent = true }
        )
        vim.api.nvim_set_keymap(
            'n',
            '<leader>tv',
            ':TestVisit<CR>',
            { noremap = true, silent = true }
        )

        -- Customize vim-test settings if needed
        vim.g['test#strategy'] = 'neovim'  -- Run tests in a floating window or split

        vim.g['test#php#phpunit#executable'] = 'php artisan test' -- Use Laravel test runner
    end
}
