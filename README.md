# dotfiles
My linux configuration

```
cd ~
git clone git@github.com:EmilSodergren/dotfiles.git .dotfiles
cd .dotfiles
python3 neovim.py -i -o [-c]
python3 setup.py [-o] [-u] [-p]
```
## Preparing for another user
sudo su <user> -s /bin/bash -c "python3 setup.py -o -p"
