"My Custom Vim Configs
"
"For using Mouse 
 set mouse=a

 colorscheme peaksea 

 "This method uses a command line abbreviation so %% expands to the full path of the directory that contains the current file.
 cabbr <expr> %% expand('%:p:h')

 syntax on
 filetype indent plugin on

 set foldmethod=indent

 nmap <S-Enter> O<Esc>j
 nmap <CR> o<Esc>k

 au BufRead,BufNewFile *.jinja2 setfiletype html
