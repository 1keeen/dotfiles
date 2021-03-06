let g:go_fmt_command = "goimports"
" LSPに任せる機能をOFFにする
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0

let g:go_fmt_autosave = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1

let g:syntastic_go_checkers = ['golint', 'govet', 'golangci-lint']

au FileType go nmap <silent> <F12> :GoDebugStart<CR>
au FileType go nmap <silent> <F12><F12> :GoDebugStop<CR>
au FileType go nmap <silent> <F9> :GoDebugBreakpoint<CR>
command! -nargs=0 CR :call CocAction('runCommand', 'editor.action.organaizeImport')
