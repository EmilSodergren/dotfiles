require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use "Raimondi/delimitMate"
  use "ms-jpq/coq-nvim"
  use "ms-jpq/coq.artifacts"
  use "airblade/vim-gitgutter"
  use "alec-gibson/nvim-tetris"
  use "cespare/vim-toml"
  use "cyberkov/openhab-vim"
  use "dhruvasagar/vim-zoom"
  use {"elzr/vim-json", ft = "json"}
  use {"fatih/vim-go", run = ":GoUpdateBinaries"}
  use {"iamcco/markdown-preview.nvim", run = "cd app && ./install.sh", ft = "markdown"}
  use "jreybert/vimagit"
  use {"junegunn/fzf", run = "./install --no-zsh --no-fish --key-bindings --completion --update-rc" }
  use "junegunn/fzf.vim"
  use {"lepture/vim-jinja", ft = "jinja"}
  use "machakann/vim-highlightedyank"
  use "mbbill/undotree"
  use "neovim/nvim-lspconfig"
  use {"nvim-treesitter/nvim-treesitter", run = ':TSUpdate' }
  use {"plasticboy/vim-markdown", ft = "markdown"}
  use {"rust-lang/rust.vim", ft = "rust"}
  use "simeji/winresizer"
  use "simrat39/rust-tools.nvim"
  use "numToStr/Comment.nvim"
  use "tpope/vim-fugitive"
  use "tpope/vim-surround"
  use "vim-airline/vim-airline"
  use "vim-airline/vim-airline-themes"
  use "wellle/tmux-complete.vim"

end)
