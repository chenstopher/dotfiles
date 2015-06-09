" Neobundle
set nocompatible
set runtimepath+=~/.vim/bundle/neobundle.vim/

call neobundle#begin(expand('~/.vim/bundle'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'chriskempson/base16-vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-surround'
NeoBundle 'bcaccinolo/bclose'
NeoBundle 'nosami/Omnisharp'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/echodoc.vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'rking/ag.vim'
NeoBundle 'terryma/vim-smooth-scroll'
NeoBundle 'terryma/vim-expand-region'
NeoBundle 'bling/vim-airline'
NeoBundle 'bling/vim-bufferline'

NeoBundle 'plasticboy/vim-markdown'
NeoBundle 'othree/html5.vim'

"NeoBundle 'xolox/vim-easytags'
"NeoBundle 'xolox/vim-misc'
"NeoBundle 'craigemery/vim-autotag'
"NeoBundle 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"NeoBundle 'vim-scripts/YankRing.vim'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Valloric/YouCompleteMe'
call neobundle#end()
NeoBundleCheck

let g:airline_theme = 'powerlineish'
let g:airline_powerline_fonts = 1
let g:airline#extensions#bufferline#enabled = 1

" unicode symbols
set encoding=utf-8
let g:airline_symbols = {}
let g:airline_left_sep = "\u2b80" "use double quotes here
let g:airline_left_alt_sep = "\u2b81"
let g:airline_right_sep = "\u2b82"
let g:airline_right_alt_sep = "\u2b83"
let g:airline_symbols.branch = "\u2b60"
let g:airline_symbols.readonly = "\u2b64"
let g:airline_symbols.linenr = "\u2b61"

set directory=~/.vimswap
set backupdir=~/.vimswap

if has("win32")
	set guifont=Consolas_for_Powerline_FixedD:h11
elseif has("macunix")
	set guifont=Monospace\ 12
elseif has("unix")
	set guifont=Ubuntu\ Mono:h14
endif        

set guioptions+=ce
set guioptions-=m
set guioptions-=t
set guioptions-=l
set guioptions-=r
set guioptions-=b
set guioptions-=T
set guioptions-=L
set guioptions-=R
set guioptions-=B
set mouse=a
set backspace=indent,eol,start

let base16colorspace=256 
set vb
set t_vb=
set t_Co=256
set bg=dark
colorscheme base16-default
set columns=130
set lines=52

set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set smartindent
set ignorecase
set smartcase

syntax on
set hidden
set history=1000
set incsearch

set cursorline
set number
set ruler
set showcmd
set laststatus=2
set nowrap

set virtualedit=all
set scrolloff=5
set sidescroll=1
set sidescrolloff=5

" Auto change the directory to the current file I'm working on
"autocmd BufEnter * lcd %:p:h

" key mappings
let mapleader = "\<Space>"
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <leader>w :w<CR>
nnoremap <leader>o :CtrlP<CR>

vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P   
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" smooth scroll
nmap <silent> <c-u> :call smooth_scroll#up(&scroll, 0, 2)<CR>
nmap <silent> <c-d> :call smooth_scroll#down(&scroll, 0, 2)<CR>
nmap <silent> <PageUp> <c-u>
nmap <silent> <PageDown> <c-d>

" yank ring
nmap yr :YRShow<CR>

nmap <C-End> :Bclose<CR>
nmap <C-S-End> :Bclose!<CR>

" Buffer management
map <left> :bprev<CR>
map <right> :bnext<CR>
map <C-Tab> :bnext<CR>
map <C-S-Tab> :bnext<CR>
map gt :bnext<CR>
map gT :bprev<CR>

let NERDTreeChDirMode=2
map <F3> :NERDTreeToggle<ENTER>
map <S-F3> :NERDTreeToggle %:p:h<ENTER>

" Re-highlight selection after shifting
vnoremap > >gv
vnoremap < <gv

set textwidth=0

filetype indent plugin on

"turn on spell check for text files
autocmd BufEnter *.txt setlocal spell spelllang=en_us
autocmd BufEnter *.txt setlocal wrap
set spellsuggest=fast,5

"php stuff
autocmd FileType php let php_sql_query=1
autocmd FileType php let php_htmlInStrings=1
autocmd FileType php let php_folding=1
autocmd FileType php set omnifunc=phpcomplete#Complete
autocmd FileType php set noautoindent
autocmd FileType php set tabstop=4
autocmd FileType php set shiftwidth=4
autocmd FileType php set softtabstop=4

" c#
"set noshowmatch
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete
autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
autocmd FileType cs nnoremap <leader>fi :OmniSharpFindImplementations<cr>
"nnoremap <leader>ft :OmniSharpFindType<cr>
autocmd FileType cs nnoremap <leader>fs :OmniSharpFindSymbol<cr>
autocmd FileType cs nnoremap <leader>fu :OmniSharpFindUsages<cr>
autocmd FileType cs nnoremap <leader>fm :OmniSharpFindMembersInBuffer<cr>
autocmd FileType cs nnoremap <leader>dc :OmniSharpDocumentation<cr>
autocmd FileType cs nnoremap <leader>tt :OmniSharpTypeLookup<cr>
"let g:OmniSharp_typeLookupInPreview = 1

" Contextual code actions (requires CtrlP)
autocmd FileType cs nnoremap <leader><space> :OmniSharpGetCodeActions<cr>
" Run code actions with text selected in visual mode to extract method
autocmd FileType cs vnoremap <leader><space> :call OmniSharp#GetCodeActions('visual')<cr>

set updatetime=300

let g:Omnisharp_stop_server = 0
let g:OmniSharp_timeout = 5

let g:acp_enableAtStartup = 0
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist'
        \ }

let g:neocomplete#enable_auto_select = 0
let g:neocomplete#disable_auto_complete = 0
let g:neocomplete#enable_smart_case = 0
let g:neocomplete#enable_camel_case = 0
let g:neocomplete#enable_ignore_case = 1

call neocomplete#custom#source('_', 'sorters', [])

if !exists('g:neocomplete#sources')
	let g:neocomplete#sources = {}
endif

if !exists('g:neocomplete#sources#omni#input_patterns')
	let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\){};]'
let g:neocomplete#sources.cs = ['omni']
let g:neocomplete#enable_refresh_always = 1
let g:neocomplete#enable_insert_char_pre = 0
let g:neocomplete#enable_cursor_hold_i = 0
let g:neocomplete#cursor_hold_i_time = 300
let g:neocomplete#enable_at_startup = 1

set completeopt=longest,menuone

" Auto complete keybindings
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  "return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"
let g:SuperTabDefaultCompletionType = "<c-n>"
let g:SuperTabContextDefaultCompletionType = "<c-n>"

" use ctrl space for omnicomplete
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" <ESC> cancels the autocomplete window
inoremap <expr><ESC> pumvisible() ? neocomplete#cancel_popup() : "\<ESC>"
" BACKSPACE closes the autocomplete window and backspaces
inoremap <expr><BS> neocomplete#smart_close_popup()."\<BS>"

" echodoc
set splitbelow
set cmdheight=2
let g:echodoc_enable_at_startup = 1

" syntastic
let g:syntastic_error_symbol = "\ue0b0"
let g:syntastic_style_error_symbol = "\ue0b1"
let g:syntastic_warning_symbol = "\ue0b0"
let g:syntastic_style_warning_symbol = "\ue0b1"

highlight SyntasticErrorSign guifg=#ff0000 guibg=#282828
highlight SyntasticStyleErrorSign guifg=#ff0000 guibg=#282828
highlight SyntasticWarningSign guifg=#fabd2f guibg=#282828
highlight SyntasticStyleWarningSign guifg=#fabd2f guibg=#282828

" ctrl p
" ignore vcs, ignore meta
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(meta)$',
  \ }

let g:ctrlp_cache_dir = '~/.vim/cache/ctrlp'
let g:ctrlp_lazy_update = 250
let g:ctrlp_working_path_mode = 'ra'

" ag
let g:agprg='ag --nogroup --nocolor --column -U -i'
