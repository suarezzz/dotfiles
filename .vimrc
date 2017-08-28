" autocmd BufWritePost $MYVIMRC source $MYVIMRC  " 让配置变更立即生效
autocmd BufReadPost *.vue set syntax=html
autocmd CursorHold,CursorHoldI,FocusLost * call Save()

function! Save()
  if &modified
    silent! update
  endif
endfunction

inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-l> <Right>
inoremap <C-h> <Left>
" inoremap <M-b> <C-o>b

inoremap <C-t> <C-o>gt
" inoremap <M-t> <C-o>gTi

set helplang=cn
set incsearch " 开启实时搜索功能
set ignorecase " 搜索时大小写不敏感
set wildmenu  " vim 自身命令行模式智能补全
set ruler
set nu
set rnu
set expandtab
set tabstop=2
set shiftwidth=2
set smartindent
set list " 显示符号(空格和tab)

set so=7
set hls
nnoremap <silent> <C-l> :nohl<cr>

set wildignore+=*/node_modules/*,*.so,*.swp,*.zip,*/DS_Store/*,*/static/*,*/dist/* 
set backspace=2
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
set ignorecase " Ignore case when searching
set smartcase " When searching try to be smart about cases 
set mouse=a
set mouseshape=a:arrow

syntax on

" set foldmethod=indent
" set foldlevelstart=99       " 打开文件是默认不折叠代码
nnoremap <space> za             " 用空格来切换折叠状态

set clipboard=unnamed

" 使标示柱一直可见
sign define dummy
execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')

nmap cp :let @+ = expand("%:p")<cr>
""""""""""""""""""""""""""""""""""" Vundle """"""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

Plugin 'VundleVim/Vundle.vim'

Plugin 'kien/ctrlp.vim'
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<c-t>'],
    \ 'AcceptSelection("t")': ['<cr>', '<2-LeftMouse>'],
    \ }
let g:ctrlp_custom_ignore = 'dist\|static|\node_modules'


Plugin 'rking/ag.vim'
let g:ag_prg='ag -S --nocolor --nogroup --noheading --column --vimgrep'
" nmap <D-S-F> :Ag<space>
function! SearchInHere(string) abort
  let saved_shellpipe = &shellpipe
  let &shellpipe = '>'
  try
    execute 'Ag!' shellescape(a:string, 1)
  finally
    let &shellpipe = saved_shellpipe
  endtry
endfunction
inoremap <C-f> <C-o>:call SearchInHere("")<left><left>
nnoremap <S-f> :call SearchInHere("")<left><left>
ca Ag Ag!

Plugin 'airblade/vim-gitgutter'
Plugin 'tpope/vim-fugitive'
Plugin 'junegunn/gv.vim'

Plugin 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-u>'
let g:multi_cursor_skip_key='<C-k>'
let g:multi_cursor_quit_key='<Esc>'

Plugin 'chiel92/vim-autoformat'

Plugin 'scrooloose/nerdtree'
map :silent! NERDTreeToggle
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
" javascript start
Plugin 'pangloss/vim-javascript', {'for': ['javascript']}
" let javascript_enable_domhtmlcss = 1
" set foldmethod=syntax

Plugin 'mxw/vim-jsx', {'for': ['javascript']}
let g:jsx_ext_required = 0

Plugin 'Valloric/YouCompleteMe'
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_complete_in_comments = 1
set completeopt-=preview
let g:ycm_semantic_triggers = {
  \ 'javascript': ['.'],
  \ }
let g:ycm_filetype_blacklist = {
  \ 'tagbar' : 1,
  \ 'qf' : 1,
  \ 'notes' : 1,
  \ 'nerdtree' : 1,
  \ 'unite' : 1,
  \ 'text' : 1,
  \ 'vimwiki' : 1,
  \ 'pandoc' : 1,
  \ 'infolog' : 1,
  \ 'mail' : 1
  \}

Plugin 'marijnh/tern_for_vim'

Plugin 'scrooloose/syntastic'
set laststatus=2
" [buffer number] followed by filename:
set statusline=[%n]\ %m\ %t
" for Syntastic messages:
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%{SyntasticLoclist.current()}
set statusline+=%*
" show line#:column# on the right hand side
set statusline+=%=%l:%c
" let g:syntastic_debug = 3
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = './node_modules/.bin/eslint'
let g:syntastic_error_symbol = "✗"

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to
" auto-approve removal
colorscheme monokai

