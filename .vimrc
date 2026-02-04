set encoding=utf-8
set fileencoding=utf-8
call plug#begin()

" Rails開発の必須プラグイン
Plug 'tpope/vim-rails'      " ビューとコントローラの高速移動
Plug 'tpope/vim-endwise'    " endの自動補完
Plug 'tpope/vim-surround'   " 文字を囲む機能

" 補完エンジン
Plug 'neoclide/coc.nvim', {'branch': 'release'} " 24時間働く最強の補完
Plug 'ervandew/supertab'    " Tabで補完を回す

call plug#end()

" Tabキーの設定
let g:SuperTabDefaultCompletionType = "<c-n>"
" プラグインが未インストールの場合は自動でインストール
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif
set number
