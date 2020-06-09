if &compatible
  set nocompatible  
endif

set clipboard&
set clipboard+=unnamedplus
set rtp+=~/.fzf

let $PATH = "~/.pyenv/versions:".$PATH
let $PATH = "~/.pyenv/shims:".$PATH

let s:dein_path = expand('~/.cache/dein')
let s:dein_repo_path = s:dein_path . '/repos/github.com/Shougo/dein.vim'
" dein.vim がなければ github からclone
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_path)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_path
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_path, ':p')
endif

let g:config_dir  = expand('~/.cache/dein/userconfig')
let s:toml        = g:config_dir . '/plugins.toml'
let s:lazy_toml   = g:config_dir . '/plugins_lazy.toml'

if dein#load_state(s:dein_path)
  call dein#begin(s:dein_path)

  " TOML 読み込み
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#add('slim-template/vim-slim')
  call dein#recache_runtimepath()
  call dein#remote_plugins()
  call dein#end()
  call dein#save_state()
endif

" インストールされていないプラグインがあればインストールする
" If you want to install not installed plugins on startup.
"End dein Scripts-------------------------
if has('vim_starting') && dein#check_install()
  call dein#install()
endif

" Required:
filetype plugin on
filetype plugin indent on
syntax enable

" neocoplete--
"let g:neocomplete#enable_smart_case = 1
"let g:neocomplete#enable_at_startup = 1

"---python--
autocmd FileType python setlocal completeopt-=preview
let g:SuperTabContextDefaultCompletionType = "context"
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:python3_host_prog =  '/home/ken/.pyenv/shims/python3'

"---jscomplete-vim---
setl omnifunc=jscomplete#CompleteJS

"---slim---
autocmd BufNewFile,BufRead *.slim setlocal filetype=slim


"--winresizer--
let g:winresizer_vert_resize = 1
let g:winresizer_horiz_resize = 1

" Input --------------------
set backspace=start,eol,indent 
"enable to delete special character using backspace key
set whichwrap=b,s,[,],<,>,~
" set wrapping of cursor set mouse=a
" enable to use mouse in all mode

" Output --------------------
set t_Co=256

colorscheme iceberg             " set color scheme

" Change popup menu color for non selected items
autocmd Colorscheme * highlight NormalFloat ctermfg=white ctermbg=0 guibg=gray
autocmd Colorscheme * highlight Pmenu ctermfg=lightgrey ctermbg=black
 " Change popup menu color for selected item
autocmd Colorscheme * highlight PmenuSel ctermfg=white ctermbg=gray
autocmd Colorscheme * highlight VertSplit  ctermfg=darkgray
augroup TransparentBG
  	autocmd!
	autocmd Colorscheme * highlight Normal ctermbg=none
	autocmd Colorscheme * highlight NonText ctermbg=none
	autocmd Colorscheme * highlight LineNr ctermbg=none
	autocmd Colorscheme * highlight Folded ctermbg=none
	autocmd Colorscheme * highlight EndOfBuffer ctermbg=none
augroup END

syntax on                       " syntax highlight
autocmd BufEnter * :syntax sync fromstart
set number                      " show row numbers
set nowrap                      " lines don't wrap
set showmatch                   " hilight corresponding bracket
set showmode                    " display current mode

" Search --------------------
set incsearch                   " incremental search
set hlsearch                    " highlighting search matches
nnoremap <Esc><Esc> :nohlsearch<CR><Esc>
set wrapscan                    " searches wrap around the end of the file

" Indent --------------------
set tabstop=4                   " nunber of spaces that a <TAB> counts for
set expandtab                   " replace <TAB> to spaces
set shiftwidth=2                " shiftwidth in (auto)indent
autocmd FileType go set shiftwidth=4
set softtabstop=2               " number of spaces that a <TAB> counts for while editing
autocmd FileType go set softtabstop=4
set autoindent                  " copy indent form current line when starting a new line
set smartindent                 " smart autoindenting when starting a new line
set list
set listchars+=tab:>･,space:･

autocmd FileType * setlocal formatoptions-=ro " prevent auto-comment

" nerdtree--
map <C-d> :NERDTreeToggle<CR>
map <C-l> :NERDTreeFind<CR>

" -- emmet--
let g:user_emmet_leader_key='<C-y>'

" vimdiff--
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

" table mode--
let g:table_mode_corner_corner='|'

" cheat sheet--
let g:cheatsheet#cheat_file = '~/.cheatsheet.md'

" vim-devicon--
set encoding=utf8
set guifont=DroidSansMono\ Nerd\ Font\ 11

"-- terminal--
noremap <silent> <C-[> <C-\><C-n>

"---json--
set conceallevel=0
let g:vim_json_syntax_conceal = 0

" ---US-JS key customise
inoremap <C-]> <Esc>
inoremap <C-l> <Right>
inoremap ; :
inoremap : ;
inoremap _ =
inoremap = _

nnoremap ; :
nnoremap ' :

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" 前のバッファに戻る
nnoremap <silent> gp :bprevious<CR>
nnoremap <silent> gn :bnext<CR>

" 指定のデータをレジスタに登録する
function! s:Clip(data)
  let @*=a:data
  echo "clipped: " . a:data
endfunction

" 現在開いているファイルのパスをレジスタへ
command! -nargs=0 ClipPath call s:Clip(expand('%:p'))
" 現在開いているファイルのファイル名をレジスタへ
command! -nargs=0 ClipFile call s:Clip(expand('%:t'))
" 現在開いているファイルのディレクトリパスをレジスタへ
command! -nargs=0 ClipDir  call s:Clip(expand('%:p:h'))


