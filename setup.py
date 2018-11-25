from os.path import dirname, realpath, expanduser, join, exists
from os import symlink, remove
from subprocess import call, Popen, PIPE
from argparse import ArgumentParser

dotfilespath = dirname(realpath(__file__))
homefolder = expanduser("~")

settingsfiles = [".vim", ".bashrc", ".tmux.conf", ".gitconfig", ".bash_git"]

parser = ArgumentParser(description='Setup the machine')

parser.add_argument('-i', '--internet', action='store_true', help='Download stuff from the internet')
args = parser.parse_args()

for stuff in settingsfiles:
    linkpath = join(homefolder, stuff)
    sourcepath = join(dotfilespath, stuff)
    if exists(linkpath):
        remove(linkpath)
    symlink(sourcepath, linkpath)

if args.internet:
    call(["vim","+VundleInstall","+qall"])
    call(["vim", "+GoInstallBinaries", "+qall"])
    
    ps = Popen(["curl", "https://sh.rustup.rs", "-sSf"], stdout=PIPE)
    call(["sh"], stdin=ps.stdout)
    ps.wait()
    call(["rustup", "install", "nightly"])
