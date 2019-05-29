from os.path import dirname, realpath, expanduser, join, exists, islink, basename
from os import symlink, remove, chdir, listdir, getcwd, remove, makedirs
from subprocess import call, check_output, Popen, PIPE
from argparse import ArgumentParser
import re

homefolder = expanduser("~")
neovimdir = join(homefolder, "neovim")
nvim2 = join(neovimdir, "pynvim", "python2")
nvim3 = join(neovimdir, "pynvim", "python3")

parser = ArgumentParser(description='Setup the neovim program')

parser.add_argument('-o', '--online', action='store_true', help='Download stuff from the internet')
parser.add_argument('-i', '--install', action='store_true', help='Build and install neovim')
parser.add_argument('-c', '--clean', action='store_true', help='Clean before build and install')
parser.add_argument('-d', '--deps', action='store_true', help='Install dependencies')
parser.add_argument('-p', '--pack', action='store_true', help='Pack neovim in a tar file')
args = parser.parse_args()

call(["sudo", "apt", "install", "-y", "python-pip", "python3-pip"])
if args.clean or args.install:
    call(["sudo", "apt-get", "install", "ninja-build", "gettext", "libtool", "libtool-bin", "autoconf", "automake", "cmake", "g++", "pkg-config", "unzip"])

    if args.clean:
        chdir(neovimdir)
        call(["sudo", "make", "distclean"])
        call(["sudo", "rm", "-rf", nvim2, nvim3])

if args.online:
    if not exists(neovimdir):
        call(["git", "clone", "https://github.com/neovim/neovim.git", basename(neovimdir)])
    chdir(neovimdir)
    call(["git", "pull"])

    if not exists(nvim2):
        makedirs(nvim2)
    chdir(nvim2)
    call(["python", "-m", "pip", "download", "pynvim"])

    if not exists(nvim3):
        makedirs(nvim3)
    chdir(nvim3)
    call(["python3", "-m", "pip", "download", "pynvim"])

    chdir(neovimdir)
    call(["sudo", "make", "deps"])

if args.install:
    call(["make", "CMAKE_BUILD_TYPE=RelWithDebInfo"])
    call(["sudo", "make", "install"])

if args.deps:
    chdir(nvim2)
    call(["python2", "-m", "pip", "install", "-f", "./"] + listdir(nvim2) + ["--no-index"])
    chdir(nvim3)
    call(["python3", "-m", "pip", "install", "-f", "./"] + listdir(nvim3) + ["--no-index"])

if args.pack:
    chdir(homefolder)
    call(["tar", "cfz", "neovim.tar.gz", basename(neovimdir)])
    print("")
    print("Neovim has been packed into " + join(homefolder, "neovim.tar.gz"))

