"My Custom Vim Configs
"
"For using Mouse 
set mouse=a

"Function for remapping commands
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

" let g:solarized_termcolors=16

let g:solarized_termtrans = 1
set background=dark
colorscheme solarized 
set t_Co=256

" colo seoul256

"This method uses a command line abbreviation so %% expands to the full path of the directory that contains the current file.
cabbr <expr> %% expand('%:p:h')

syntax on
filetype indent plugin on

let NERDTreeShowHidden=1

noremap <S-Enter> O<Esc>j
noremap <CR> o<Esc>k

"Fix CR for command line window
augroup commandlinewindow
  autocmd!
  autocmd CmdwinEnter * nnoremap <buffer> <CR> <CR>
augroup END

"Fix CR for quickfix window
"autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

au BufRead,BufNewFile *.jinja2 setfiletype html
au BufNewFile,BufRead *.handlebars set syntax=html
au BufRead,BufNewFile *.handlebars setfiletype html
au BufRead,BufNewFile *.tag setfiletype html
au BufNewFile,BufRead *.tag set syntax=html
au FileType python set shiftwidth=4

"Any additional syntastic syntax checkers
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_sh_checkers = ['shellcheck']
let g:syntastic_JavaScript_checkers = ['jshint']

"Setup ALE to use eslint
let g:ale_linters = {
\   'javascript': ['standard'],
\   'python': ['flake8'],
\   'go': ['go', 'golint', 'errcheck'],
\   'c': ['gcc'],
\   'rust': ['cargo'],
\}
"\   'rust': ['rls', 'rustfmt']

let g:ale_rust_rls_toolchain='stable'

let g:ale_c_gcc_options = '-std=gnu11 -Wall -Wextra -Werror -Werror-implicit-function-declaration'

let g:ale_fixers = {
\   'javascript': ['standard'],
\   'rust': ['rustfmt'],
\}

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML
let markdown_folding=1

"Remap semicolon to colon
nnoremap ; :
vnoremap ; :


"Copy to clipboard
vnoremap <C-c> "+y

"Use ag for Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" Open Ack and put the cursor in the right position
map <leader>g :Find 

"Statusline already shows -- INSERT -- mode so we can hide it from vanilla vim
set noshowmode

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'component_function': {
      \   'filename': 'LightLineFilename'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }

function! LightLineFilename()
  return expand('%')
endfunction

" fix meta-keys which generate <Esc>a .. <Esc>z
" let c='a'
" while c <= 'z'
"   exec "set <M-".toupper(c).">=\e".c
"   exec "imap \e".c." <M-".toupper(c).">"
"   let c = nr2char(1+char2nr(c))
" endw

" vv to generate new vertical split
nnoremap <silent> vv <C-w>v

" leaderq to quit
map <leader>q :q<cr>

map <c-r><c-f> :CtrlPRegister<cr>

" fzf
set rtp+=~/.fzf

" fzf insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
imap <leader><tab> <plug>(fzf-maps-i)

" fzf mru and open files
command! FZFMru call fzf#run({
\ 'source':  reverse(s:all_files()),
\ 'sink':    'edit',
\ 'options': '-m -x +s',
\ 'down':    '40%' })

function! s:all_files()
  return extend(
  \ filter(copy(v:oldfiles),
  \        "v:val !~ 'fugitive:\\|NERD_tree\\|^/tmp/\\|.git/'"),
  \ map(filter(range(1, bufnr('$')), 'buflisted(v:val)'), 'bufname(v:val)'))
endfunction


" Fzf fuzzy finders
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>m :FZFMru<CR>
nmap <Leader>l :BLines<CR>
nmap <Leader>L :Lines<CR>
nmap <Leader>h :History<CR>
nmap <Leader>c :History:<CR>
nmap <Leader>/ :History/<CR>
nmap <Leader>' :Marks<CR>
nmap <Leader>s :Filetypes<CR>

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options

command! -bang -nargs=* Ag call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)
command! -bang -nargs=* FindIn call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.<q-args>, 1, <bang>0)

set grepprg=rg\ --vimgrep
nmap <c-f> :Find 

vnoremap <leader>f :call VisualSelection('rgfind', '')<CR>

"i3-vim-focus
map <silent> gwl :call Focus('right', 'l')<CR>
map <silent> gwh :call Focus('left', 'h')<CR>
map <silent> gwk :call Focus('up', 'k')<CR>
map <silent> gwj :call Focus('down', 'j')<CR>

map <silent> gml :call Move('r')<CR>
map <silent> gmh :call Move('R')<CR>
map <silent> gmk :call Move('R')<CR>
map <silent> gmj :call Move('L')<CR>

"i3-vim-focus is causing termite to sound a bell/urgent window
"occasionally
set belloff=all

"vim-easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_inc_highlight = 0

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{char}{label}`
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" HJKL motions: Line motions
" map <C-M>l <Plug>(easymotion-lineforward)
" map <C-M>j <Plug>(easymotion-j)
" map <C-M>k <Plug>(easymotion-k)
" map <C-M>h <Plug>(easymotion-linebackward)

let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" YouCompleteMe
let g:ycm_goto_buffer_command = 'vertical-split'
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
nnoremap <leader>yg :YcmCompleter GoTo<CR>
nnoremap <leader>yd :YcmCompleter GetDoc<CR>

let g:ycm_rust_src_path = '/home/maxb/.rustup/toolchains/nightly-x86_64-unknown-linux-gnu/lib/rustlib/src/'

let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function! ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"

map <C-K> :py3f /usr/share/clang/clang-format-4.0/clang-format.py<cr>
imap <C-K> <c-o>:py3f /usr/share/clang/clang-format-4.0/clang-format.py<cr>

set number
" set relativenumber
"Set Glg to pretty formatted git log
" command -nargs=* Glg Git! log --graph --pretty=format:'\%h - (\%ad)\%d \%s <\%an>' --abbrev-commit --date=local <args>
"Remove extra line on bottom
set cmdheight=0
