set foldmethod=syntax
set foldlevelstart=1

""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType python inoremap <buffer> $r return 
au FileType python inoremap <buffer> $i import 
au FileType python inoremap <buffer> $p print 
au FileType python inoremap <buffer> $f # --- <esc>a
au FileType python map <buffer> <leader>1 /class 
au FileType python map <buffer> <leader>2 /def 
au FileType python map <buffer> <leader>C ?class 
au FileType python map <buffer> <leader>D ?def 
au FileType python set cindent
au FileType python set cinkeys-=0#
au FileType python set indentkeys-=0#

autocmd FileType python UltiSnipsAddFiletypes python 

""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
" au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> $log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return 
au FileType javascript inoremap <buffer> $f // --- PH<esc>FP2xi

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction

augroup javascript_folding
  au!
  au FileType javascript setlocal foldmethod=syntax
augroup END

autocmd FileType js UltiSnipsAddFiletypes javascript-node 
autocmd FileType js UltiSnipsAddFiletypes javascript 

""""""""""""""""""""""""""""""
" => CoffeeScript section
"""""""""""""""""""""""""""""""
function! CoffeeScriptFold()
    setl foldmethod=indent
    setl foldlevelstart=1
endfunction
au FileType coffee call CoffeeScriptFold()

au FileType gitcommit call setpos('.', [0, 1, 1, 0])

""""""""""""""""""""""""""""""
" => Makefile section
"""""""""""""""""""""""""""""""
autocmd FileType make setlocal noexpandtab

""""""""""""""""""""""""""""""
" => Markdown section
"""""""""""""""""""""""""""""""
au FileType markdown set foldmethod=expr

""""""""""""""""""""""""""""""
" => Rust section
"""""""""""""""""""""""""""""""
autocmd FileType rust UltiSnipsAddFiletypes rust 

""""""""""""""""""""""""""""""
" => Shell section
""""""""""""""""""""""""""""""
if exists('$TMUX') 
    if has('nvim')
        set termguicolors
    else
        set term=screen-256color 
    endif
endif

autocmd FileType sh UltiSnipsAddFiletypes sh

""""""""""""""""""""""""""""""
" => Twig section
""""""""""""""""""""""""""""""
autocmd BufRead *.twig set syntax=html filetype=html

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Fugitive (vim-fugitive)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set up fancy higlighting for git log
 syn match gitLgLine /^[_\*|\/\\ ]\+\(\<\x\{4,40\}\>.*\)\?$/

 syn match gitLgHead /^[_\*|\/\\ ]\+\(\<\x\{4,40\}\> - ([^)]\+)\( ([^)]\+)\)\? \)\?/ contained containedin=gitLgLine

 syn match gitLgDate /(\u\l\l \u\l\l \d\=\d \d\d:\d\d:\d\d \d\d\d\d)/ contained containedin=gitLgHead nextgroup=gitLgRefs skipwhite

 syn match gitLgRefs /([^)]*)/ contained containedin=gitLgHead

 syn match gitLgGraph /^[_\*|\/\\ ]\+/ contained containedin=gitLgHead,gitLgCommit nextgroup=gitHashAbbrev skipwhite

 syn match gitLgCommit /^[^-]\+- / contained containedin=gitLgHead nextgroup=gitLgDate skipwhite

 syn match gitLgIdentity /<[^>]*>$/ contained containedin=gitLgLine

 hi def link gitLgGraph Comment

 hi def link gitLgDate gitDate

 hi def link gitLgRefs gitReference

 hi def link gitLgIdentity gitIdentity
