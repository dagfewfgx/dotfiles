-- ~/.config/nvim/init.lua

-- ============================================================================
-- 自动安装 lazy.nvim（插件管理器）
-- ============================================================================
-- init.lua

local signs = {
    { name = "DiagnosticSignError", text = "❌", color = "#ff0000" },
    { name = "DiagnosticSignWarn", text = "⚠", color = "#ffcc00" },
    { name = "DiagnosticSignInfo", text = "ℹ", color = "#00ff00" },
    { name = "DiagnosticSignHint", text = "💡", color = "#00ffff" },
}

-- 批量定义符号和高亮
for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { text = sign.text, texthl = sign.name })
    vim.api.nvim_set_hl(0, sign.name, { fg = sign.color })
end


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ============================================================================
-- 在这里配置插件
-- ============================================================================

require("lazy").setup({
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
    -- 其他插件...
})

-- 配置文件
-- ============================================================================
-- 基础外观
-- ============================================================================

-- 显示行号
vim.opt.number = true

-- 显示相对行号（当前行是绝对行号，其他行是相对行号，方便跳转）
vim.opt.relativenumber = true

-- 语法高亮
vim.cmd('syntax on')

-- 主题配色（使用默认，以后可以换）
-- 可选: 'elflord', 'ron', 'desert', 'evening' 等
vim.cmd('colorscheme desert')

-- ============================================================================
-- 编辑行为
-- ============================================================================

-- 设置系统剪贴板为默认复制目标
vim.opt.clipboard = 'unnamedplus'

-- Tab 键宽度设为 4 个空格
vim.opt.tabstop = 4

-- 自动缩进宽度也是 4
vim.opt.shiftwidth = 4

-- 按 Tab 时插入空格（而不是制表符）
vim.opt.expandtab = true

-- 自动缩进
vim.opt.autoindent = true
vim.opt.smartindent = true

-- 显示当前光标所在行
vim.opt.cursorline = true

-- 鼠标可以点击和选择
vim.opt.mouse = 'a'

-- 允许退格键删除缩进、换行、插入的内容
vim.opt.backspace = 'indent,eol,start'

-- ============================================================================
-- 搜索设置
-- ============================================================================

-- 高亮搜索结果
vim.opt.hlsearch = true

-- 边输入边搜索
vim.opt.incsearch = true

-- 搜索忽略大小写（但如果有大写字母就区分）
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ============================================================================
-- 界面行为
-- ============================================================================

-- 始终显示标签栏（底部状态栏）
vim.opt.showmode = true      -- 显示当前模式（INSERT, NORMAL 等）
vim.opt.ruler = true          -- 显示光标位置

-- 显示命令（输入命令时显示在右下角）
vim.opt.showcmd = true

-- 启用文件类型检测，并自动加载相关插件和缩进规则
vim.cmd('filetype plugin indent on')

-- ============================================================================
