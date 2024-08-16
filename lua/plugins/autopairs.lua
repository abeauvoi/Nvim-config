return {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {}
    config = function()
        -- Require nvim-autopairs (already loaded by opts above)
        local npairs = require('nvim-autopairs')

        -- Set up nvim-autopairs (if you want to pass additional options)
        npairs.setup{}

        -- nvim-cmp integration
        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on(
          'confirm_done',
          cmp_autopairs.on_confirm_done()
        )
    end,
}
