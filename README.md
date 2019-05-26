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
git clone https://github.com/neovim/neovim.git
cd neovim
sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
make distclean && make CMAKE_BUILD_TYPE=Release
sudo make install
```
## Uninstall
```
sudo rm /usr/local/bin/nvim
sudo rm -r /usr/local/share/nvim/
```
