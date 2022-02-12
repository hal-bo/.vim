"
" エディターの設定
"

" 永続的なundoを可能にする
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile                                                                                                                                   
endif

" 行番号を表示する
set number
" 新しいウィンドウを右に開く
set splitright
