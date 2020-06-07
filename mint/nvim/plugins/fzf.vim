nnoremap [fzf] <Nop>
nmap <C-f> [fzf]
nnoremap <silent> [fzf]<C-f> :GFiles<CR>
nnoremap <silent> [fzf]<C-g> :GFiles?<CR>
nnoremap <silent> [fzf]<C-b> :Buffers<CR>
nnoremap <silent> [fzf]<C-l> :BLines<CR>
nnoremap <silent> [fzf]<C-h> :History<CR>
nnoremap <silent> [fzf]<C-m> :Mark<CR>
nnoremap <silent> [fzf]<C-a> :Ag<CR>

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-o': 'vsplit' }

let g:fzf_layout = { 'window': 'enew' }

command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '@'),
  \                 <bang>0)

command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#files(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '@'),
  \                 <bang>0)

command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '@'),
  \                 <bang>0)

