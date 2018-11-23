from os.path import dirname, realpath, expanduser, join, exists
from os import symlink, remove

dotfilespath = dirname(realpath(__file__))
homefolder = expanduser("~")

settingsfiles = [".vim", ".bashrc", ".tmux.conf", ".gitconfig", ".bash_git"]

for stuff in settingsfiles:
    linkpath = join(homefolder, stuff)
    sourcepath = join(dotfilespath, stuff)
    if exists(linkpath):
        remove(linkpath)
    symlink(sourcepath, linkpath)


