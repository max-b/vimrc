"My Custom Vim Configs
"
"For using Mouse 
 set mouse=a

 "let g:solarized_termcolors=16

 let g:solarized_termtrans = 1
 set background=light
 colorscheme solarized 

 "This method uses a command line abbreviation so %% expands to the full path of the directory that contains the current file.
 cabbr <expr> %% expand('%:p:h')

 syntax on
 filetype indent plugin on

 let NERDTreeShowHidden=1

 nmap <S-Enter> O<Esc>j
 nmap <CR> o<Esc>k

 au BufRead,BufNewFile *.jinja2 setfiletype html
 au BufNewFile,BufRead *.handlebars set syntax=html
 au BufNewFile,BufRead *.tag set syntax=html
 au BufNewFile,BufRead *.py set shiftwidth=2

 "Any additional syntastic syntax checkers
 let g:syntastic_python_checkers = ['pylint']
 let g:syntastic_sh_checkers = ['shellcheck']
 let g:syntastic_JavaScript_checkers = ['jshint']


 set foldmethod=syntax
 set foldlevelstart=1

 let javaScript_fold=1         " JavaScript
 let perl_fold=1               " Perl
 let php_folding=1             " PHP
 let r_syntax_folding=1        " R
 let ruby_fold=1               " Ruby
 let sh_fold_enabled=1         " sh
 let vimsyn_folding='af'       " Vim script
 let xml_syntax_folding=1      " XML
