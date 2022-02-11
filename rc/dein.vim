"
" dein 設定スクリプト
"

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイル（後述）を用意しておく
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

" プラグインの削除
function! s:dein_check_uninstall() abort
    let l:remove_plugins = dein#check_clean()
    if len(l:remove_plugins) > 0
        for l:remove_plugin in l:remove_plugins
            echo l:remove_plugin
        endfor
        echo 'Would you like to remove those plugins?'
        if input('[Y/n]') == 'Y'
            call map(l:remove_plugins, "delete(v:val, 'rf')")
            call dein#recache_runtimepath()
            echo 'Remove Plugins ...done!'
        else 
            echo 'Remove Plugins ...abort!'
        endif
    else
        echo 'None remove plugins!'
    endif
endfunction

command! DeinRemove call s:dein_check_uninstall()