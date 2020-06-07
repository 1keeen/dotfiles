let g:ale_lint_on_text_changed = 0
"ale 表示に関する設定
let g:ale_sign_error = '❎'
let g:ale_sign_warning = '⚠️'
let g:airline#extensions#ale#open_lnum_symbol = '('
let g:airline#extensions#ale#close_lnum_symbol = ')'
let g:ale_echo_msg_format = '[%linter%]%code: %%s'
let g:airline#extensions#tabline#fnamecollapse = 0

highlight link ALEErrorSign Tag
highlight link ALEWarningSign StorageClass
"let" Ctrl + kで次の指摘へ、Ctrl + jで前の指摘へ移動
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_linters = {
    \ 'python': ['flake8'],
    \ 'javascript': ['eslint'],
    \ 'go': ['gometalinter'],
    \ 'vue': ['eslint'],
    \ 'html': ['htmlhint','tidy','eslint'],
    \ }

let g:ale_fixers = {
      \ 'javascript': ['prettier'],
      \ 'vue': ['eslint'],
      \ 'python': ['autopep8','black', 'isort'],
      \ 'markdown': [
      \   {buffer, lines -> {'command': 'textlint -c ~/.config/textlintrc -o /dev/null --fix --no-color --quiet %t', 'read_temporary_file': 1}}
      \   ],
      \ }

let g:ale_python_flake8_args='"--ignore="E731","E501","E722"'
let g:syntastic_python_flake8_args = '--ignore="E501","E722"'
let g:python_autopep8_options = '--ignore "E731"'


let g:ale_linter_aliases = {'vue': 'css'}

let g:ale_fix_on_save = 1
let g:ale_lint_on_enter = 0

"let g:ale_go_gometalinter_options = '--fast --enable=staticcheck --enable=gosimple --enable=unused'
let g:ale_go_gometalinter_options = '--fast --enable=staticcheck --enable=gosimple --enable=unused'
