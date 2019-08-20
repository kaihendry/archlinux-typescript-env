syntax on
filetype plugin indent on

call plug#begin('~/.vim/plugged')

Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': ':!install.sh \| UpdateRemotePlugins'}

autocmd FileType typescript,typescript.tsx setl omnifunc=TSOmniFunc
