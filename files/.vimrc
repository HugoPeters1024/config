set nocp
" :set shellcmdflag=-icexecute pathogen#infect()
execute pathogen#infect()
filetype plugin indent on
syntax on
colorscheme desert
set shiftwidth=2
set tabstop=2
set softtabstop=2
set number
set showcmd
set expandtab
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.jinja set filetype=html
au BufNewFile,BufRead *.jinja2 set filetype=html
au BufNewFile,BufRead *.j2 set filetype=html

" Allow more history
set history=700

" When scrolling, show the next 6 lines
set scrolloff=6

set showcmd

set ttyfast

" Be silent
set visualbell

" Smarter search settings
set incsearch
set ignorecase
set smartcase

set splitbelow
set splitright

set autoindent

" No arrow keys!
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Easy buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-h> <C-w>h
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l


" Clang Language server

" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")

if executable('cquery')
   au User lsp_setup call lsp#register_server({
      \ 'name': 'cquery',
      \ 'cmd': {server_info->['cquery']},
      \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
      \ 'initialization_options': { 'cacheDirectory': '/tmp/cquery/cache' },
      \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
      \ })
endif


:command Dev !dev
