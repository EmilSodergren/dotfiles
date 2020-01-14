# dotfiles
My linux configuration

```
cd ~
git clone git@github.com:EmilSodergren/dotfiles.git .dotfiles
cd .dotfiles
python setup.py [-i] [-p]
```

# Build Neovim
Steps to compile and install Neovim editor

## Build / Install
```
python3 neovim.py -i -o [-c]
```
## Uninstall
```
sudo rm /usr/local/bin/nvim
sudo rm -r /usr/local/share/nvim/
```
