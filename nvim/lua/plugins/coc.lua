return { 
        {
        'neoclide/coc.nvim',
        build = 'npm install --frozen-lockfile',  -- 安装依赖
        config = function()
            -- coc.nvim 配置
            vim.g.coc_global_extensions = {
                'coc-json',
                'coc-tsserver',
                'coc-pyright',
                'coc-sh',           -- Shell 脚本支持
                'coc-marketplace',
             }
            
            -- 快捷键配置
            vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', {})
            vim.keymap.set('n', 'gr', '<Plug>(coc-references)', {})
            vim.keymap.set('n', 'K', '<Plug>(coc-doc)', {})
        end,
    },   
}
