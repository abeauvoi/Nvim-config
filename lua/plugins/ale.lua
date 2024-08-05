return {
	'dense-analysis/ale';
    config = function ()
        vim.g.ale_enabled = 1
        vim.g.ale_linters = {
            json = {'jsonlint', 'jq'}
        }
        vim.g.ale_lint_on_enter = 1
        vim.g.ale_lint_on_save = 1
    end,
}
