let g:Gtags_OpenQuickfixWindow = 1
"let g:Gtags_VerticalWindow = 1

"nnoremap <silent> <C-f> :Gtags -f %<CR>
"カーソル下の単語が含まれるタグの表示
nnoremap <silent> <Space>j :GtagsCursor<CR>
"カーソル下の単語の定義元を表示
nnoremap <silent> <Space>k :<C-u>exe('Gtags '.expand('<cword>'))<CR>
"カーソル下の単語の参照先を表示
nnoremap <silent> <Space>r :<C-u>exe('Gtags -r '.expand('<cword>'))<CR>
" 検索結果Windowを閉じる
nnoremap <silent> <Space>q <C-w><C-w><C-w>q
" ソースコードのgrep
nnoremap <silent> <C-g> :Gtags -g
" ファイルの関数一覧
nnoremap <silent> F :Gtags -f %<CR>
" 次の検索結果へジャンプ
nnoremap <silent> <C-j><C-j> :cn<CR>
" の検索結果へジャンプ
nnoremap <silent> <C-k><C-k> :cp<CR>

