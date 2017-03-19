autocmd BufWritePost $MYVIMRC source $MYVIMRC  " 让配置变更立即生效
autocmd BufReadPost *.vue set syntax=html
autocmd CursorHold,CursorHoldI * update

inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <M-b> <C-o>b
inoremap <M-f> <C-o>w

set guifont=Monano:h14
set helplang=cn
set incsearch " 开启实时搜索功能
set ignorecase " 搜索时大小写不敏感
set wildmenu  " vim 自身命令行模式智能补全
set ruler
set number
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set list " set hls
set wildignore+=*/node_modules/*,*.so,*.swp,*.zip,*/DS_Store/*,*/static/*,*/dist/* 
set backspace=2
set so=10
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase " Ignore case when searching

set smartcase " When searching try to be smart about cases 

syntax on


set foldmethod=indent
au BufWinLeave * silent mkview  " 保存文件的折叠状态
au BufRead * silent loadview    " 恢复文件的折叠状态
nnoremap <space> za             " 用空格来切换折叠状态
set foldlevelstart=99       " 打开文件是默认不折叠代码

set clipboard=unnamed

sign define dummy
execute 'sign place 9999 line=1 name=dummy buffer=' . bufnr('')


""""""""""""""""""""""""""""""""""" Vundle """"""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'kien/ctrlp.vim'
" let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

Plugin 'pangloss/vim-javascript'
let javascript_enable_domhtmlcss = 1
" set foldmethod=syntax

Plugin 'mxw/vim-jsx'
let g:jsx_ext_required = 0

Plugin 'JamshedVesuna/vim-markdown-preview'

Plugin 'tpope/vim-markdown'

Plugin 'eslint/eslint'

Plugin 'yannickcr/eslint-plugin-react'

Plugin 'Valloric/YouCompleteMe'
let g:ycm_key_list_select_completion = ['<TAB>']
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_complete_in_comments = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_autoclose_preview_window_after_completion = 1
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
set statusline=[%n]\ %t
" for Syntastic messages:
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%{SyntasticLoclist.current()}
set statusline+=%*
" show line#:column# on the right hand side
set statusline+=%=%l:%c
" let g:syntastic_debug = 3
let g:syntastic_loc_list_height = 0
let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = './node_modules/.bin/eslint'
let g:syntastic_error_symbol = "✗"

" Plugin '907th/vim-auto-save'
" let g:auto_save = 1  " enable AutoSave on Vim startup
" let g:auto_save_silent = 1 

" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-airline/vim-airline-themes'
" if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
" endif
" let g:airline_theme="base16"
" let g:airline_left_sep = '▶'
" let g:airline_left_alt_sep = '❯'
" let g:airline_right_sep = '◀'
" let g:airline_right_alt_sep = '❮'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline#extensions#tabline#enabled = 1 " 打开tabline
"

Plugin 'airblade/vim-gitgutter'
Plugin 'scrooloose/nerdtree'
" autocmd vimenter * NERDTree
map :silent! NERDTreeToggle
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen = 1

Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'
" let g:ag_prg='ag --vimgrep --smart-case'
let g:ag_prg='ag -S --nocolor --nogroup --column --ignore node_modules --ignore "./dist/*" --ignore "./static/*"'

Plugin 'tpope/vim-commentary'

Plugin 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
" Default mapping
let g:multi_cursor_next_key='<C-d>'
let g:multi_cursor_prev_key='<C-u>'
let g:multi_cursor_skip_key='<C-k>'
let g:multi_cursor_quit_key='<Esc>'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'

" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
colorscheme monokai

