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

 set foldmethod=indent

 let NERDTreeShowHidden=1

 nmap <S-Enter> O<Esc>j
 nmap <CR> o<Esc>k

 au BufRead,BufNewFile *.jinja2 setfiletype html
 au BufNewFile,BufRead *.handlebars set syntax=html
