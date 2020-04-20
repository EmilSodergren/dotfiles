from os.path import dirname, realpath, expanduser, join, exists, islink, basename
from os import symlink, remove, chdir, listdir, getcwd, remove, makedirs
from subprocess import call, check_output, Popen, PIPE
from argparse import ArgumentParser
import fileinput
import re

homefolder = expanduser("~")
neovimdir = join(homefolder, "neovim")

parser = ArgumentParser(description='Setup the neovim program')

parser.add_argument('-o', '--online', action='store_true', help='Download stuff from the internet')
parser.add_argument('-i', '--install', action='store_true', help='Build and install neovim')
parser.add_argument('-c', '--clean', action='store_true', help='Clean before build and install')
parser.add_argument('-p', '--pack', action='store_true', help='Pack neovim in a tar file')
parser.add_argument('-u', '--uninstall', action='store_true', help='Uninstall neovim on the sudo make install path')
args = parser.parse_args()

if args.uninstall:
    call(["sudo", "rm", "/usr/local/bin/nvim"])
    call(["sudo", "rm", "-r", "/usr/local/share/nvim/"])

chdir(homefolder)
if args.clean or args.install:
    call(["sudo", "apt-get", "install", "ninja-build", "gettext", "libtool", "libtool-bin", "autoconf", "automake", "cmake", "g++", "pkg-config", "unzip", "wget", "curl"])

    if args.clean and exists(neovimdir):
        chdir(neovimdir)
        call(["sudo", "make", "distclean"])
        call(["sudo", "rm", "-rf", pynvim])

if args.online:
    if not exists(neovimdir):
        call(["git", "clone", "https://github.com/neovim/neovim.git", basename(neovimdir)])
    chdir(neovimdir)
    call(["git", "checkout", "--", "."])
    call(["git", "pull"])

    if not exists(pynvim):
        makedirs(pynvim)
    chdir(pynvim)

    chdir(neovimdir)
    call(["make", "deps"])

    # Can't get the make parameter CMAKE_BUILD_TYPE to take
    # Change the Makefile instead, before continuing
    for line in fileinput.input("Makefile", inplace=True):
        print(line.replace("Debug", "Release"), end="")
    call(["make"])

if args.install:
    chdir(neovimdir)
    call(["sudo", "make", "install"])

if args.pack:
    chdir(homefolder)
    weird_file = join(neovimdir, ".deps", "build", "src", "luarocks", "spec", "fixtures", "abc.bz2")
    if exists(weird_file):
        remove(weird_file)
    call(["tar", "cfz", "neovim.tar.gz", basename(neovimdir)])
    print("")
    print("Neovim has been packed into " + join(homefolder, "neovim.tar.gz"))

