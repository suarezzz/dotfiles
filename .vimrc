set helplang=cn
set incsearch
set ignorecase
set wildmenu  " vim 自身命令行模式智能补全
set nu
set rnu
set cursorline
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
"set list " 显示符号(空格和tab)
set so=7
set hls
set lisp
set wildignore+=*/node_modules/*,*.so,*.swp,*.zip,*/DS_Store/*,*/static/*,*/dist/*
set backspace=2
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase
set smartcase
set mouse=a
set mouseshape=a:arrow
set showmode
set ruler
set showcmd
set clipboard=unnamed
set signcolumn=yes
set backup
set shell=$SHELL
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//
" set foldmethod=syntax
set foldlevelstart=99       " 打开文件是默认不折叠代码
set noesckeys
set timeoutlen=100 ttimeoutlen=0
syntax on

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



set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
call plug#begin('~/.vim/plugged')

set cscopetag
set cscopeprg='gtags-cscope' 
set tags=./.tags,~/.cache/.tags;

Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
" let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_define_advanced_commands = 1
" let g:gutentags_trace = 1

" 同时开启 ctags 和 gtags 支持：
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
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
let g:gutentags_auto_add_gtags_cscope = 0 " 禁用 gutentags 自动加载 gtags 数据库的行为

Plug 'skywind3000/gutentags_plus'
let g:gutentags_plus_switch = 1
let g:gutentags_plus_nomap = 1

Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
let g:Lf_ShortcutF = '<C-P>'
let g:Lf_StlColorscheme = 'default'
let g:Lf_WindowHeight = 0.4
let g:Lf_ReverseOrder = 1
" let g:Lf_CommandMap = { '<cr>': ['<C-T>'] }

autocmd! FileType leaderf
autocmd  FileType leaderf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

Plug 'majutsushi/tagbar'
" let g:tagbar_ctags_bin = 'jsctags'

Plug 'ybian/smartim'

Plug 'rking/ag.vim'
let g:ag_prg='ag -S --nocolor --nogroup --noheading --column --vimgrep'
ca Ag Ag!

"
" Plug 'kien/ctrlp.vim'

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/gv.vim'

Plug 'scrooloose/nerdtree'
map :silent! NERDTreeToggle
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1

" javascript plugins start
Plug 'pangloss/vim-javascript', {'for': ['javascript']}
Plug 'mxw/vim-jsx', {'for': ['javascript']}
let g:jsx_ext_required = 0
let g:xml_syntax_folding = 1

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

Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
set completeopt-=preview
let g:ycm_semantic_triggers = {
\  'javascript,go': ['.'],
\  'css': [ 're!^\s{2,}', 're!:\s+'],
\}
let g:ycm_filetype_blacklist = {
\  'tagbar' : 1,
\  'qf' : 1,
\  'notes' : 1,
\  'nerdtree' : 1,
\  'unite' : 1,
\  'text' : 1,
\  'vimwiki' : 1,
\  'pandoc' : 1,
\  'infolog' : 1,
\  'mail' : 1
\}

Plug 'marijnh/tern_for_vim', { 'do': 'npm install && npm install -g tern' }

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
\  'typescript': ['eslint', 'prettier'],
\}
let g:ale_javascript_eslint_options = '--cache'
let g:ale_sign_error = "✗"

Plug 'plasticboy/vim-markdown'
Plug 'heavenshell/vim-jsdoc'
let g:vim_markdown_folding_level = 2


call plug#end()

function! Save()
  if &modified
    silent! update
  endif
endfunction

function! Afind(...) abort
  let saved_shellpipe = &shellpipe
  let &shellpipe = '>'
  try
    execute 'Ag!' join(a:000, ' ')
  finally
    let &shellpipe = saved_shellpipe
  endtry
endfunction

function! ALEStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  return l:counts.total == 0 ? '' : printf(' ಠ_ಠ %d ',l:counts.total)
endfunction

" autocmd BufWritePost $MYVIMRC source $MYVIMRC  " 让配置变更立即生效
autocmd Filetype xml if getfsize(@%) > 1000000 | setlocal syntax=OFF | endif
autocmd BufReadPost *.vue set syntax=html
autocmd BufReadPost *.mina set syntax=html
autocmd CursorHold,CursorHoldI,FocusLost * call Save()

command! -nargs=* -complete=file Af call Afind(<q-args>)

let mapleader = ";"
nnoremap wq :wq<cr>
nnoremap q :q<cr>
nnoremap <leader>n :tabnew 
nnoremap <leader>i gg=G:%s/\s\+$//e<cr>``
nnoremap <leader>f :ALEFix<cr>
nnoremap <leader>c :let @+ = expand("%:p")<cr>
nnoremap <leader>g :Af 
nnoremap <leader>E :ALEPrevious<cr>
nnoremap <leader>e :ALENext<cr>
nnoremap <leader>w <C-W>w
nnoremap <leader>b :Gblame<cr>
nnoremap <leader>o :set fdm=syntax<cr>zM:set fdm=manual<cr>
nnoremap <leader><space> za   "折叠
nnoremap <silent> <C-l> :nohl<cr>
noremap H ^
noremap L $
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <BS> <Nop>
inoremap <Del> <Nop>
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>


" vim-go custom mappings
" au FileType go nmap <Leader>s <Plug>(go-implements)
" au FileType go nmap <Leader>i <Plug>(go-info)
" au FileType go nmap <Leader>gd <Plug>(go-doc)
" au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <leader>gr <Plug>(go-run)
au FileType go nmap <leader>gb <Plug>(go-build)
au FileType go nmap <leader>gt <Plug>(go-test)
" au FileType go nmap <leader>c <Plug>(go-coverage)
" au FileType go nmap <Leader>ds <Plug>(go-def-split)
" au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>d <Plug>(go-def)
" au FileType go nmap <Leader>e <Plug>(go-rename)

set laststatus=2 " always display statusline
set statusline=%m\ %#warningmsg#%{ALEStatus()}%*\ %t\ %=[%n]\ \ %l:%c


colorscheme monokai
