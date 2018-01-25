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
set clipboard+=unnamed

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
highlight ExtraWhitespace ctermbg=darkred ctermfg=white guibg=#592929

" " hightlight anything that goes longer than 80 chars
" :au BufWinEnter * let w:m1=matchadd('WarnMsg', '\%<81v.\%>77v', -1)
" :au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>81v.\+', -1)
set colorcolumn=80
highlight ColorColumn ctermbg=darkgrey guibg=darkgrey

autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red ctermfg=white
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" the above flashes annoyingly while typing, be calmer in insert mode
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/

" Configure spacejam to delete whitespace
let g:spacejam_filetypes = 'ruby,javascript,vim,perl,sass,scss,css,coffee,haml,elixir'

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
set fdl=1
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
autocmd FileType elixir set commentstring=#\ %s
autocmd FileType python set commentstring=#\ %s
autocmd FileType yaml set commentstring=#\ %s
autocmd FileType c set commentstring=//\ %s

" Bring back my mappings
xmap \\  <Plug>Commentary<CR>
nmap \\  <CR><Plug>Commentary
nmap \\\ <Plug>CommentaryLine<CR>
nmap \\u <Plug>CommentaryUndo<CR>

" auto-completion settings
set complete=.,b,u,]
set wim=longest,list

" deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" tslime configuration

let g:tslime_always_current_session = 1
let g:tslime_always_current_window = 1
let g:tslime_ensure_trailing_newlines = 1

vmap <leader>t <Plug>SendSelectionToTmux

let g:tslime_normal_mapping = '<leader>t'
let g:tslime_visual_mapping = '<leader>t'
let g:tslime_vars_mapping = '<leader>T'

" rubocop config
if filereadable("./bin/stubs/rubocop")
  let g:ale_ruby_rubocop_executable="bin/stubs/rubocop"
endif

" vim-test configuration
map <Leader>T :call TestStrategyToggle()<cr>
map <Leader>R :call TestToggleRspecCommand()<CR>

nmap <silent> <leader>d :TestNearest<CR>
nmap <silent> <leader>t :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>g :TestVisit<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure Rainbow Parenthesis
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

let test#strategy = "tslime"

" vim-mix-format configuration
let g:mix_format_on_save = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle the test strategy
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! TestStrategyToggle()
  if g:test#strategy == "neovim"
    let g:test#strategy = "tslime"
  else
    let g:test#strategy = "neovim"
  endif

  echo g:test#strategy
endfunction


function! TestToggleRspecCommand()
  if !exists("g:test#ruby#rspec#executable")
    let g:test#ruby#rspec#executable = "bundle exec spec"
  elseif g:test#ruby#rspec#executable == "bundle exec spec"
    let g:test#ruby#rspec#executable = "bundle exec rspec"
  else
    let g:test#ruby#rspec#executable = "bundle exec spec"
  end

  echo g:test#ruby#rspec#executable
endfunction
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

