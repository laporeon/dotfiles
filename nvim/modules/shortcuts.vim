" Mapping keys
let mapleader = "\<space>"

" Move lines up and down like VSCode
nnoremap <silent> <A-j> <Cmd>:m .-2<CR>
nnoremap <silent> <A-k> <Cmd>:m .+1<CR>

nnoremap <C-l> :call CocActionAsync('jumpDefinition')<CR>
nmap <F8> :TagbarToggle<CR>
nmap <C-s> :w<CR>

" NvimTree
nmap <C-b> :NvimTreeToggle<CR>

" Prettier
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" ESLint
command! -nargs=0 ESLint :CocCommand eslint.executeAutofix

" Bar Bar Plugin
" Move to previous/next
nnoremap <silent> <A-,> <Cmd>BufferPrevious<CR>
nnoremap <silent> <A-.> <Cmd>BufferNext<CR>
:" Re-order to previous/next
nnoremap <silent> <A-<> <Cmd>BufferMovePrevious<CR>
nnoremap <silent> <A->> <Cmd>BufferMoveNext<CR>
" Goto buffer in position...
nnoremap <silent> <A-1> <Cmd>BufferGoto 1<CR>
nnoremap <silent> <A-2> <Cmd>BufferGoto 2<CR>
nnoremap <silent> <A-3> <Cmd>BufferGoto 3<CR>
nnoremap <silent> <A-4> <Cmd>BufferGoto 4<CR>
nnoremap <silent> <A-5> <Cmd>BufferGoto 5<CR>
nnoremap <silent> <A-6> <Cmd>BufferGoto 6<CR>
nnoremap <silent> <A-7> <Cmd>BufferGoto 7<CR>
nnoremap <silent> <A-8> <Cmd>BufferGoto 8<CR>
nnoremap <silent> <A-9> <Cmd>BufferGoto 9<CR>
nnoremap <silent> <A-0> <Cmd>BufferLast<CR>

" Telescope
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>


