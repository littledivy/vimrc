" Divy's vimrc
call plug#begin()

Plug 'github/copilot.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" I have 4 moods:
"   1. idgaf mood: syntax off & colorscheme default
"   2. too lazy to read: syntax on & colorscheme accent
"   3. vibing: syntax on & colorscheme gruvbox
"   4. presenting: syntax on & colorscheme ghdark
Plug 'alligator/accent.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'wojciechkepka/vim-github-dark'

call plug#end()

syntax off
set background=dark
let g:accent_darken = 1
let g:accent_invert_status = 1
let g:accent_no_bg = 1
let g:accent_colour = 'orange'
 
set mouse=a

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

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
