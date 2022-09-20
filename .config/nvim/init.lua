vim.g.mapleader = ","

local fn = vim.fn
local homedir = os.getenv("HOME")
local packerdir = homedir .. '/.local/share/nvim/site/pack/packer/start/packer.nvim/'

if fn.empty(fn.glob(packerdir)) > 0 then
  fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    packerdir,
  }
  vim.cmd [[packadd packer.nvim]]
end
vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"

require('plugins')

