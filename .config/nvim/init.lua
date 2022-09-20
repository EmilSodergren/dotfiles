vim.g.mapleader = ","

local fn = vim.fn

if fn.empty(fn.glob('~/.local/share/nvim/site/pack/packer/start/packer.nvim/')) > -1 then
  fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    "site/pack/packer/start/packer.nvim/",
  }
  vim.cmd [[packadd packer.nvim]]
end
vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"

require('packercfg')

