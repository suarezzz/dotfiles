call plug#begin('~/.vim/plugged')

Plug 'ybian/smartim'

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_define_advanced_commands = 1
" let g:gutentags_trace = 1
let g:gutentags_modules = []
if executable('ctags')
	let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
  let g:gutentags_modules += ['gtags_cscope']
elseif executable('cscope') && executable('ctags')
	let g:gutentags_modules += ['cscope']
endif
let g:gutentags_cache_dir = expand('~/.cache/tags')
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extras=+q']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags'] " 如果使用 universal ctags 需要增加下面一行
let g:gutentags_auto_add_gtags_cscope = 0 " 禁用 gutentags 自动加载 gtags 数据库的行为


Plug 'skywind3000/gutentags_plus'
let g:gutentags_plus_switch = 1
let g:gutentags_plus_nomap = 1


Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_StlColorscheme = 'default'
let g:Lf_WindowHeight = 0.28
let g:Lf_ReverseOrder = 1
autocmd! FileType leaderf
autocmd  FileType leaderf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler


Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
set completeopt-=preview
let g:ycm_semantic_triggers = {
\  'javascript,go': ['.'],
\  'css': [ 're!^\s{2,}', 're!:\s+'],
\}
let g:ycm_filetype_blacklist = {
      \  'leaderf': 1,
      \  'qf' : 1,
      \  'notes' : 1,
      \  'text' : 1,
      \  'vimwiki' : 1,
      \  'pandoc' : 1,
      \  'infolog' : 1,
      \  'mail' : 1
\}

" Gblame
" GV
" Extradite
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'
Plug 'int3/vim-extradite'
let g:extradite_showhash = 1
let g:extradite_diff_split = 'belowright vertical split'


" Acks!
Plug 'wincent/ferret'


" Tabularize
Plug 'godlygeek/tabular' " http://vimcasts.org/episodes/aligning-text-with-tabular-vim/


" JsDoc
Plug 'heavenshell/vim-jsdoc'
let g:jsdoc_enable_es6 = 1
let g:jsdoc_allow_input_prompt = 1


" ALEFix
Plug 'w0rp/ale'
let g:ale_linters = {
\  'go': ['golint', 'go vet'],
\  'javascript': ['eslint', 'prettier'],
\  'typescript': ['tslint'],
\  'shell': ['shell'],
\}
let g:ale_fixers = {
\  'javascript': ['eslint', 'prettier'],
\  'go': ['go fmt', 'go imports', 'go vet'],
\  'css': ['prettier'],
\  'md': ['prettier'],
\  'typescript': ['eslint', 'prettier'],
\}
let g:ale_javascript_eslint_options = '--cache'
let g:ale_sign_error = "✗"


" javascript plugins start
Plug 'pangloss/vim-javascript', {'for': ['javascript']}
Plug 'mxw/vim-jsx', {'for': ['javascript']}
let g:jsx_ext_required = 0
Plug 'marijnh/tern_for_vim', { 'do': 'npm install && npm install -g tern' }

" go plugins start
Plug 'fatih/vim-go'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

Plug 'leafgarland/typescript-vim', {'for': ['typescript']}
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''

Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_level = 2

call plug#end()

" style
set number
set relativenumber
set cursorline
set showmode
set showcmd
set ruler
set signcolumn=yes " git status
set list listchars=tab:→\ ,nbsp:≀,extends:›,precedes:‹,trail:·
set foldmethod=indent
set foldlevelstart=99       " 打开文件是默认不折叠代码
set scrolloff=7

" insert or command
set expandtab
set tabstop=2
set shiftwidth=2 " cindent
set autoindent
set incsearch
set hlsearch
set ignorecase
set smartcase

" save options
set autowrite
set backup
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

set wildmenu
set wildmode=full
set clipboard=unnamed
set shell=$SHELL
set wildignore+=*/node_modules/*,*.so,*.swp,*.zip,*/DS_Store/*,*/static/*,*/dist/*
set noesckeys
set timeoutlen=300 ttimeoutlen=0
set lisp

" netrw
let g:netrw_banner = 0
let g:netrw_browse_split = 0 " 2
let g:netrw_altv = 1
let g:netrw_liststyle = 3
let g:netrw_winsize = 20
autocmd FileType netrw set nolist
map <C-n> :Lexplore<CR>
autocmd FileType netrw setl bufhidden=delete " https://github.com/tpope/vim-vinegar/issues/13
autocmd bufenter * if (winnr('$') == 1 && getbufvar(winbufnr(winnr()), '&filetype') == 'netrw') | q | endif

set cscopetag
set cscopeprg='gtags-cscope' 
set tags=./.tags,~/.cache/.tags;

syntax on

" http://vim.wikia.com/wiki/Auto_save_files_when_focus_is_lost
function! RunCmd(...)
  let args = []
  for arg in a:000
    call add(args, expand(arg))
  endfor
  new
  setlocal buftype=nofile bufhidden=hide noswapfile
  execute 'r !'.join(args, ' ')
endfunction

command! -nargs=* -complete=shellcmd R call RunCmd(<f-args>)

function! ALEStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  return l:counts.total == 0 ? '' : printf(' ಠ_ಠ %d ', l:counts.total)
endfunction

autocmd Filetype * if getfsize(@%) > 1000000 | setlocal syntax=OFF | endif
autocmd BufReadPost *.vue set syntax=html
autocmd BufReadPost *.mina set syntax=html

let mapleader = ";"
if exists(":Tabularize")
  nmap <Leader>= :Tabularize /=<CR>
  vmap <Leader>= :Tabularize /=<CR>
  nmap <Leader>: :Tabularize /:\zs<CR>
  vmap <Leader>: :Tabularize /:\zs<CR>
endif
nnoremap <leader>t :tabnew 
nnoremap <leader>i gg=G:%s/\s\+$//e<cr>
nnoremap <leader>r :Acks 
nnoremap <leader>f :ALEFix<cr>
nnoremap <leader>E :ALEPrevious<cr>
nnoremap <leader>e :ALENext<cr>
nnoremap <leader>b :Gblame<cr>
nnoremap <leader>l :Extradite<cr>
nnoremap <leader>c :let @+ = expand("%:p")<cr>
nnoremap <leader>w <C-W>w
nnoremap <leader>p :bp<CR>
nnoremap <leader>n :bn<CR>
nnoremap <silent> <C-l> :nohl<cr>
nnoremap wq :wq<cr>
nnoremap q :q<cr>
noremap H ^
noremap L $
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <Home>
noremap <C-e> <End>
inoremap <BS> <Nop>
inoremap <Del> <Nop>
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gt <Plug>(go-test)
au FileType go nmap <Leader>d <Plug>(go-def)

set laststatus=2 " always display statusline
set statusline=%m\ %#warningmsg#%{ALEStatus()}%*\ %t\ %=[%n]\ \ %l:%c

colorscheme monokai
hi SpecialKey ctermfg=0
