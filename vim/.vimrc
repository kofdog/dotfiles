"" Vundle
filetype off
se rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'chriskempson/base16-vim'          " colors
Plugin 'christoomey/vim-tmux-navigator'   " seamless navigation
Plugin 'ctrlpvim/ctrlp.vim'               " fuzzy finder
"Plugin 'edkolev/tmuxline.vim'             " tmux statusline
"Plugin 'hsanson/vim-android'              " Android/Gradle integration
"Plugin 'jelera/vim-javascript-syntax'     " better syntax highlighting for JS
"Plugin 'morhetz/gruvbox'                  " colors
"Plugin 'mustache/vim-mustache-handlebars' " Javascript Handlebars syntax
Plugin 'octol/vim-cpp-enhanced-highlight' " better syntax highlighting for C++
"Plugin 'othree/html5.vim'                 " syntax highlighting for HTML5
"Plugin 'pangloss/vim-javascript'          " better syntax/indent for JS
Plugin 'skywind3000/asyncrun.vim'         " asynchronous shell commands
Plugin 'tomlion/vim-solidity'             " Ethereum programming syntax
Plugin 'tpope/vim-commentary'             " comments
"Plugin 'tpope/vim-dispatch'               " asynchronous compilation in tmux
Plugin 'tpope/vim-fugitive'               " git integration
Plugin 'tpope/vim-obsession'              " make persistent sessions
"Plugin 'tyrannicaltoucan/vim-quantum'     " colors
"Plugin 'vhdirk/vim-cmake'                 " cmake integration
Plugin 'vim-airline/vim-airline'          " aesthetics
Plugin 'vim-airline/vim-airline-themes'   " colors
Plugin 'vim-scripts/a.vim'                " header/src switching
Plugin 'vim-scripts/Smart-Tabs'           " tabs:indentation::spaces:alignment

call vundle#end()

"" Settings
" File reading
se ar
se ffs+=mac

" Fancy indentation and such
se ai
se bs=indent,eol,start
se cin
se cino=(0,u0,U0
se cpt-=i
se sta

" Aesthetic
"se cc=81
se dy+=lastline
se lsp=0
se noeb
se nojs
se sm

se fo+=j
se hid

" Search
se nohls
se ic
se is
se scs
se wig=**/build/**,*.o,*.obj,.gitignore,.vimlocal,Session.vim,cscope*,tags

se mouse=

" Default indentation
se noet
se sw=8
se sts=0
se ts=8

se nf-=octal

" Statusline
se ls=2
se ru
se sc
se nosmd
se wmnu

se sh=/bin/bash

se ttimeout
se ttm=100

"" Filetype adjustments
au FileType c,cpp,make setl sw=8 ts=8 sts=0 noet nu "cc=81
au FileType css,html,javascript setl sw=2 ts=2 et nu "cc=81
au FileType java,xml setl sw=4 ts=4 et nu "cc=101
au FileType haskell setl sw=4 ts=4 et nu "cc=80
au FileType python setl sw=4 ts=4 et nu "cc=80
au FileType sh,tmux,vim setl sw=4 ts=4 et
au FileType solidity setl sua+=.sol nu

" Obligatory
filetype plugin indent on
se nocp
syntax on

" Color scheme
se t_8f=[38;2;%lu;%lu;%lum
se t_8b=[48;2;%lu;%lu;%lum
se t_ZH=[3m
se t_ZR=[23m
se termguicolors
se bg=dark
colo base16-gruvbox-dark-hard
" let g:gruvbox_contrast_dark='hard'
" let g:gruvbox_italic=1
" colo gruvbox

" GUI stuff
se gfn=Source\ Code\ Pro\ for\ Powerline\ Semibold\ 11
se go-=m
se go-=T
se go-=r
se go-=R
se go-=l
se go-=L

" Remove trailing whitespace on save
au BufWritePre * :%s/\s\+$//e

" Disable auto-commenting
au FileType * setl fo-=c fo-=r fo-=o

" Get backups out of the way
se bdir=~/.vim/backup//
se dir=~/.vim/swap//
se noswf

"" Path/Tags
" Project workspace
se path=$PWD/**
se tag+=./tags
se nocst
silent! cs add cscope.out
:se csqf=s-,c-,d-,i-,t-,e-,a-
:se csre

" Linux kernel
se path+=~/linux/include
se path+=~/linux/arch/x86/include
se tag+=~/linux/tags

se path+=/usr/include
se tag+=/usr/include/pcl-1.7/pcl/tags
silent! cs add /usr/include/pcl-1.7/pcl/cscope.out

"" Airline
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tmuxline#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline_theme='base16'
" let g:airline_theme='gruvbox'

"" Android
"let g:android_sdk_tags = '$PWD/tags'
"let g:gradle_daemon = 1
"let g:gradle_quickfix_show = 1

"" CtrlP
let g:ctrlp_show_hidden = 1
nn <c-n> :CtrlPBuffer<CR>

"" AsyncRun
let g:asyncrun_open = 10

"" Mustache/Handlebars
"au FileType html se syn=mustache

"" Keybindings
" Leader key
let mapleader = " "

" Buffer manipulation
nn gb :bn<CR>
nn gB :bp<CR>
nn <Leader>bd :b#\|bd#<CR>

" Quickfix
" q: toggle quickfix
"nn <Leader>qq :call asyncrun#quickfix_toggle(10)<CR>
" o: (open) jump to quickfix if exists
nn <Leader>qo :cw<CR>
" q: close quickfix
nn <Leader>qq :ccl<CR>
" n/p: cycle next/previous quickfix
nn <Leader>qn :cnewer<CR>
nn <Leader>qp :colder<CR>

" Build
" f: make single file
nn <Leader>mf :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)"<CR>
" l: make local (current directory)
nn <Leader>ml :AsyncRun -cwd="$(VIM_FILEDIR)" make<CR>
" a: make all (whole project)
nn <Leader>ma :AsyncRun -cwd=<root> make<CR>
" c: make all (cmake project)
nn <Leader>mc :AsyncRun -cwd=<root>/build make<CR>
" r: run main project binary, requires 'run' target defined in Makefile
nn <silent> <Leader>mr :AsyncRun -cwd=<root> -raw make run<CR>:ccl<CR>
" m: run (cmake project)
nn <silent> <Leader>mm :AsyncRun -cwd=<root>/build -raw make run<CR>:ccl<CR>

" ctags/cscope
nn <Leader><C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" s: Find this C symbol
nn <leader>fs :exec("cs find s ".expand("<cword>"))<CR>
" g: Find this definition
nn <leader>fg :exec("cs find g ".expand("<cword>"))<CR>
" d: Find functions called by this function
nn <leader>fd :exec("cs find d ".expand("<cword>"))<CR>
" c: Find functions calling this function
nn <leader>fc :exec("cs find c ".expand("<cword>"))<CR>
" t: Find this text string
nn <leader>ft :exec("cs find t ".expand("<cword>"))<CR>
" e: Find this egrep pattern
nn <leader>fe :exec("cs find e ".expand("<cword>"))<CR>
" f: Find this file
nn <leader>ff :exec("cs find f ".expand("<cword>"))<CR>
" i: Find files #including this file
nn <leader>fi :exec("cs find i ".expand("<cword>"))<CR>

" git
nn <leader>gc :G commit -a<CR>
nn <leader>gd :G diff -b --ignore-blank-lines<CR>
nn <leader>gg :exec("G grep ".expand("<cword>"))<CR><CR><CR>
nn <leader>gl :G log<CR>
nn <leader>gs :G<CR>

" Exit Insert mode
im jk <Esc>

" Source per-project configuration
silent! so .vimlocal
