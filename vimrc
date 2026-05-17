" Comments in Vimscript start with a `"`.

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
set showcmd
filetype plugin indent on
autocmd FileType python setlocal tabstop=4 shiftwidth=4 expandtab

" .vimrc 配置

" ALE 会自动检测 ShellCheck
let g:ale_linters = {
\   'sh': ['shellcheck'],
\}

" 设置检查时机
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 1

" 显示错误符号
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'

" 状态栏显示
let g:ale_statusline_format = ['✗ %d', '⚠ %d', '✓ ok']

" 快捷键
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" ========== coc.nvim 配置 ==========

" 使用你的路径加载 coc.nvim
set runtimepath^=~/.vim/pack/vendors/start/coc.nvim

" 或者使用 packadd（推荐）
" packadd! coc.nvim

" ========== 补全快捷键 ==========

" 使用 Tab 键触发补全
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#confirm() :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1] =~# '\s'
endfunction

" 使用 Enter 确认补全
inoremap <silent><expr> <CR>
      \ coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" ========== 导航快捷键 ==========

" 跳转到定义
nmap <silent> gd <Plug>(coc-definition)
" 查找引用
nmap <silent> gr <Plug>(coc-references)
" 查看文档
nmap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" 重命名
nmap <leader>rn <Plug>(coc-rename)

" 格式化
nmap <leader>f <Plug>(coc-format-selected)

" 错误导航
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" ~/.vimrc

" 补全菜单颜色 - 黑色背景优化
" 普通菜单项：深灰背景 + 亮白文字
hi Pmenu        ctermbg=235    guibg=#262626    ctermfg=255    guifg=#eeeeee

" 选中项：亮蓝色背景 + 白色文字（高对比）
hi PmenuSel     ctermbg=33     guibg=#0087ff    ctermfg=231    guifg=#ffffff

" 图标类型：亮黄色
hi PmenuKind    ctermfg=226    guifg=#ffff00

" 选中项的图标：白色
hi PmenuKindSel ctermfg=231    guifg=#ffffff

" 额外信息：灰色
hi PmenuExtra   ctermfg=245    guifg=#8a8a8a

" 滚动条：亮灰色
hi PmenuThumb   ctermbg=248    guibg=#a8a8a8

" 滚动条：深色背景
hi PmenuSbar    ctermbg=236    guibg=#303030
