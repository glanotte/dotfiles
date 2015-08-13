set shell=/bin/sh

" configure pathogen
call pathogen#infect()

"Set leader key
let mapleader = " "

"home row escape
inoremap fd <ESC>

" shortcuts to adding notes
map <leader>nn :sp ~/Dropbox/notes/programming_notes.txt<cr>
map <leader>np :sp ~/Dropbox/notes/project_notes.txt<cr>

"Setting to allow clipboard access with p and y
if $TMUX == ''
  set clipboard+=unnamed
endif

filetype plugin indent on
filetype on  " Automatically detect file types.
set nocompatible  " We don't want vi compatibility.

" set .pl files as prolog
let g:filetype_pl="prolog"
" try to speed up scrolling for large files
set ttyfast
set lazyredraw

" Store temporary files in a central spot, thanks to Gary Bernhardt
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Ignore extension files
set wildignore=*.dll,*.o,*.obj,*.bak,*.pyc,*.swp " ignore these"

" Configure airline
let g:airline_powerline_fonts = 1
let g:rails_statusline=1
set laststatus=2
set encoding=utf-8

" Color for non-gui vim
colorscheme geoff_gui

" Set the title string to display the full path
set title
set titlestring=VIM:\ %-25.55F\ %a%r%m titlelen=70

" show a dot for trailing whitespace
set listchars=tab:▸\ ,trail:·
set list
highlight ExtraWhitespace ctermbg=darkred guibg=#382424

" " hightlight anything that goes longer than 80 chars
" :au BufWinEnter * let w:m1=matchadd('WarnMsg', '\%<81v.\%>77v', -1)
" :au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
set colorcolumn=80
:hi ColorColumn ctermbg=red guibg=red

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" the above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'

" Have ctags look in gems.tags
set tags+=gems.tags

syntax enable
set smartindent

set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
set expandtab

set showmatch
set incsearch

" TagList
map <leader>tl :TlistToggle <cr>
let Tlist_Use_Right_Window = 1

" Code Folding
set fdm=syntax
set fdc=2
" set the level high enough that nothing should be folded initially
set fdl=10
" Love the cursor line
set cursorline
"syntax for scss
au BufRead,BufNewFile *.scss set filetype=scss

"
" Override filetype for handlebars+erb files
au BufNewFile,BufRead *.hbs.erb,*.handlebars.erb,*.hb.erb set ft=handlebars.eruby

" Relative Line numbers, requires vim 7.3+
set rnu
autocmd InsertEnter * :set number
autocmd InsertLeave * :set rnu

set hlsearch

" Don't use Ex mode, use Q for formatting
map Q gq

"Adding #{} to AutoClose Plugin and activating it for String interpolation
let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'", '#{': '}'}
let g:AutoCloseProtectedRegions = ["Character"]
let g:AutoCloseExpandEnterOn = ""

"Load custom configuration
let my_home = expand("$HOME/")
if filereadable(my_home . '.vimrc.local')
	source ~/.vimrc.local
endif

" Quick jumping between splits
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-H> <C-W>h<C-W>_
map <C-L> <C-W>l<C-W>_

set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=5
set winminheight=5
set winheight=999

" CtrlP configuration, heavily inspired by Gary Bernhardt's Command-T config
let g:ctrlp_working_path_mode = 'r'
map <leader>gv :CtrlPClearCache<cr>:CtrlP app/views<cr>
map <leader>gc :CtrlPClearCache<cr>:CtrlP app/controllers<cr>
map <leader>gm :CtrlPClearCache<cr>:CtrlP app/models<cr>
map <leader>gh :CtrlPClearCache<cr>:CtrlP app/helpers<cr>
map <leader>ga :CtrlPClearCache<cr>:CtrlP app/assets<cr>
map <leader>gs :CtrlPClearCache<cr>:CtrlP app/assets/stylesheets<cr>
map <leader>gj :CtrlPClearCache<cr>:CtrlP app/assets/javascripts<cr>
map <leader>gh :CtrlPClearCache<cr>:CtrlP lib<cr>
map <leader>gp :CtrlPClearCache<cr>:CtrlP public<cr>
map <leader>f :CtrlP<cr>
map <leader>F :CtrlPClearCache<cr>:CtrlP<cr>

" Rails specific files
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gR :call ShowRoutes()<cr>

" Map ,e and ,v to open files in the same directory as the current file
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>s :sp %%
map <leader>v :view %%

if has("autocmd")
  " Auto Indent
  filetype indent on

  " Restore cursor position when opening a file
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif

" Comments for vim-commentary
autocmd FileType ruby set commentstring=#\ %s
autocmd FileType python set commentstring=#\ %s
autocmd FileType yaml set commentstring=#\ %s
autocmd FileType c set commentstring=//\ %s

" auto-completion settings
set complete=.,b,u,]
set wim=longest,list

" vim-rspec configuration
let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'

map <Leader>X :let g:rspec_command = "!time bundle exec rspec {spec}"<CR>
map <Leader>x :let g:rspec_command = "call Send_to_Tmux(\"bundle exec rspec {spec}\n\")"<CR>

map <leader>t :call RunCurrentSpecFile()<CR>
map <leader>d :call RunNearestSpec()<CR>
map <leader>l :call RunLastSpec()<CR>
map <leader>a :call RunAllSpecs()<CR>
map <leader>z :call RunSpecDirectory()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Run the current specs for a directory
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RunSpecDirectory()
    let s:last_spec_location = "%:h"
    call RunSpecs(s:last_spec_location)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Moves a variable declaration to an rspec let comment (Thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE (thanks Gary Bernhardt)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Shortcut for the rails routes file
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>gr :topleft :split config/routes.rb<cr>
function! ShowRoutes()
" Requires 'scratch' plugin
  :topleft 100 :split __Routes__
" Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
" Delete everything
  :normal 1GdG
" Put routes output in buffer
  :0r! rake -s routes
" Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . "_ "
" Move cursor to bottom
  :normal 1GG
" Delete empty trailing line
  :normal dd
endfunction
