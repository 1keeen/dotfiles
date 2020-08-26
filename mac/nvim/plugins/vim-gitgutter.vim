set diffopt+=vertical
nnoremap [git] <Nop>
nmap <C-g> [git]

nnoremap <silent> [git]<C-b> :Gbrowse<CR>
vnoremap <silent> <C-b><C-b> :Gbrowse<CR>
nnoremap <silent> [git]<C-d> :Gdiffsplit<CR>
nnoremap <silent> [git]<C-h> :Gblame<CR>
nnoremap <silent> [git]<C-s> :Gstatus<CR>
