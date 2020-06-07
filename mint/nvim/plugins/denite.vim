autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> o
  \ denite#do_map('do_action','split')
  nnoremap <silent><buffer><expr> v
  \ denite#do_map('do_action','vsplit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

let s:denite_win_width_percent = 0.85
let s:denite_win_height_percent = 0.7

" Change denite default options
call denite#custom#option('default', {
    \ 'split': 'floating',
    \ 'winwidth': float2nr(&columns * s:denite_win_width_percent),
    \ 'wincol': float2nr((&columns - (&columns * s:denite_win_width_percent)) / 2),
    \ 'winheight': float2nr(&lines * s:denite_win_height_percent),
    \ 'winrow': float2nr((&lines - (&lines * s:denite_win_height_percent)) / 2),
    \ })

nnoremap [denite] <Nop>
nmap s [denite]
"現在開いているファイルのディレクトリ下のファイル一覧。
nnoremap <silent> [denite]l :<C-u>DeniteBufferDir file file:new<CR>
"現在開いているディレクトリ下のファイル一覧。
nnoremap <silent> [denite]d :<C-u>Denite file file:new<CR>
"バッファ一覧
nnoremap <silent> [denite]b :<C-u>Denite buffer<CR>
"レジスタ一覧
nnoremap <silent> [denite]r :<C-u>Denite -default-action=replace -buffer-name=register
        \ register neoyank<CR>
"最近使用したファイル一覧
nnoremap <silent> [denite]m :<C-u>Denite file_mru file_mru:new<CR>
" カレントディレクトリのファイルの中身を検索
nnoremap <silent> [denite]s :<C-u>Denite -buffer-name=search -no-empty grep<CR>
" カレントバッファのファイルの中身を検索
nnoremap <silent> [denite]f :<C-u>DeniteBufferDir -buffer-name=search -no-empty grep<CR>
" ファイル内の検索
nnoremap <silent> [denite]/ :<C-u>Denite -highlight-matched-char=Search -buffer-name=search line <CR>
" ファイル内で同じ文字を全て検索
nnoremap <silent> * :<C-u>DeniteCursorWord -buffer-name=search -highlight-matched-char=Search line<CR>

nnoremap <silent> [denite]+ :<C-u>DeniteCursorWord -buffer-name=search -no-empty grep<CR>

nnoremap <silent> [denite]g :Denite -buffer-name=gtags_completion gtags_completion<cr>

