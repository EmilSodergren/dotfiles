require("packer").startup(function(use)
  use "wbthomason/packer.nvim"

  use "Raimondi/delimitMate"
  use "ms-jpq/coq-nvim"
  use "ms-jpq/coq.artifacts"
  use "airblade/vim-gitgutter"
  use "alec-gibson/nvim-tetris"
  use "cespare/vim-toml"
  use {"ckipp01/nvim-jenkinsfile-linter", requires = { "nvim-lua/plenary.nvim" } }
  use "cyberkov/openhab-vim"
  use "dhruvasagar/vim-zoom"
  use {"elzr/vim-json", ft = "json"}
  use "ggandor/leap.nvim"
  use {"ray-x/go.nvim", requires = { "ray-x/guihua.lua" } }
  use {"iamcco/markdown-preview.nvim", run = "cd app && ./install.sh", ft = "markdown"}
  use "jreybert/vimagit"
  use {"junegunn/fzf", run = "./install --no-zsh --no-fish --key-bindings --completion --update-rc" }
  use "ibhagwan/fzf-lua"
  use {"lepture/vim-jinja", ft = "jinja"}
  use "machakann/vim-highlightedyank"
  use "mbbill/undotree"
  use "mfussenegger/nvim-ansible"
  use "neovim/nvim-lspconfig"
  use {"nvim-treesitter/nvim-treesitter" }
  use {"nvim-treesitter/nvim-treesitter-context" }
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
