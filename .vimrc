" Divy's vimrc
call plug#begin()

Plug 'github/copilot.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'zivyangll/git-blame.vim'

" I have 4 moods:
"   1. idgaf mood: syntax off & colorscheme default
"   2. too lazy to read: syntax on & colorscheme accent
"   3. vibing: syntax on & colorscheme gruvbox
"   4. presenting: syntax on & colorscheme ghdark
Plug 'alligator/accent.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'wojciechkepka/vim-github-dark'

" Academic writing
Plug 'lervag/vimtex'
let g:vimtex_compiler_latexmk = {
      \ 'out_dir' : 'latexbuild',
      \ 'options' : [
      \   '-shell-escape',
      \   '-lualatex',
      \   '-verbose',
      \   '-file-line-error',
      \   '-synctex=1',
      \   '-interaction=nonstopmode',
      \  ],
      \}

" Org mode
Plug 'tpope/vim-speeddating'
Plug 'mattn/calendar-vim'
Plug 'jceb/vim-orgmode'

" LSP
" :CocInstall coc-json coc-deno coc-rust-analyzer
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

syntax on
set background=dark
let g:accent_darken = 1
let g:accent_invert_status = 1
let g:accent_no_bg = 1
let g:accent_colour = 'orange'
colorscheme gruvbox

let g:vimtex_view_method = 'zathura'
" Use skim on macOS
if has('mac')
  let g:vimtex_view_method = 'skim'
endif

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

nnoremap + <C-a>
nnoremap - <C-x>

" Window
nmap ss :split<Return><C-w>w
nmap sv :vsplit<Return><C-w>w
nmap <Space> <C-w>w

let g:copilot_enabled = 1
let g:fzf_vim = {}

nmap ;f :Files<CR>
nmap ;r :Rg<CR>
nmap \\ :Buffers<CR>
nmap \r :Jump<CR>

nnoremap ;g :<C-u>call gitblame#echo()<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
