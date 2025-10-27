" Divy's vimrc

let plug_path = '~/.vim/autoload/plug.vim'
if empty(glob(plug_path))
  silent execute '!curl -fLo '.plug_path.' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'github/copilot.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'zivyangll/git-blame.vim'
Plug 'tpope/vim-fugitive'

Plug 'justinmk/vim-sneak'

" :CocInstall coc-json coc-deno coc-rust-analyzer
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

let g:sneak#label = 1
let g:sneak#s_next = 1

map f <Plug>Sneak_s
map F <Plug>Sneak_S

se ttimeout
se timeoutlen=1000 ttimeoutlen=0

se clipboard^=unnamed
se clipboard^=unnamedplus

syn on
colorscheme habamax

hi! Normal ctermbg=NONE guibg=NONE
hi! NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

se relativenumber

" stop CoC by default (but Coc is enabled)
" let g:coc_start_at_startup=0

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

au BufRead,BufNewFile *.text set filetype=markdown
let g:markdown_fenced_languages = ['html', 'js=javascript', 'ruby']

set mouse=a
set backspace=indent,eol,start

compiler cargo
nnoremap ;b :make build -p deno --bin deno<CR>

nnoremap + <C-a>
nnoremap - <C-x>

set tabstop=2 softtabstop=2 shiftwidth=2
set autoindent smartindent

" Window

nmap sv :vsplit<Return><C-w>w
nmap <Space> <C-w>w

let g:copilot_enabled = 1
let g:fzf_vim = {}

nmap ;f :Files<CR>
nmap ;r :Rg<CR>
nmap \\ :Buffers<CR>
nmap \r :Jump<CR>

nnoremap ;g :<C-u>call gitblame#echo()<CR>

command! Retag !ctags -R --languages=Rust,JavaScript,TypeScript --exclude=target --exclude=node_modules --exclude=dist --exclude=build -f ./tags  $(git diff --name-only HEAD && git diff --name-only --cached)

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Fix fzf hang when Esc
tnoremap <nowait> <Esc> <Esc>

" Disable arrow keys
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
nnoremap <PageUp> <NOP>
nnoremap <PageDown> <NOP>
