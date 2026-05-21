return {
        -- ALE 插件配置
    {
        'dense-analysis/ale',
        config = function()
            vim.g.ale_sign_column_always = 1
            vim.g.ale_linters = {
                sh = { 'shellcheck' },
            }
            vim.g.ale_fixers = {
                sh = { 'shfmt' },
            }
        end,
    },
}
