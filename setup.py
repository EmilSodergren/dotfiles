from os.path import dirname, realpath, expanduser, join, exists
from os import symlink, remove
from subprocess import call, Popen, PIPE
from argparse import ArgumentParser

dotfilespath = dirname(realpath(__file__))
homefolder = expanduser("~")

settingsfiles = [".vim", ".bashrc", ".tmux.conf", ".gitconfig", ".bash_git", ".profile", ".bash_completion", ".bash_completion.d"]

parser = ArgumentParser(description='Setup the machine')

parser.add_argument('-i', '--internet', action='store_true', help='Download stuff from the internet')
parser.add_argument('-n', '--nightly', action='store_true', help='Download the latest nightly build')
args = parser.parse_args()

for stuff in settingsfiles:
    linkpath = join(homefolder, stuff)
    sourcepath = join(dotfilespath, stuff)
    if exists(linkpath):
        remove(linkpath)
    symlink(sourcepath, linkpath)

if args.internet:
    call(["git", "clone", "https://github.com/VundleVim/Vundle.vim.git", homefolder+"/.dotfiles/.vim/bundle/Vundle.vim"])
    call(["vim","+VundleInstall","+qall"])
    call(["vim", "+GoInstallBinaries", "+qall"])
    
    ps = Popen(["curl", "https://sh.rustup.rs", "-sSf"], stdout=PIPE)
    call(["sh", "-s", "--", "-y"], stdin=ps.stdout)
    ps.wait()
    call(["rustup", "component", "add", "rustfmt"])
    call(["rustup", "component", "add", "rust-src"])
    call(["cargo", "install", "cargo-watch"])

    if args.nightly:
        call(["rustup", "install", "nightly"])
        call(["cargo", "+nightly", "install", "racer"])
