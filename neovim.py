from os import chdir
from subprocess import call
from argparse import ArgumentParser
from pathlib import Path
import apt

nvim_install_dir = Path.home() / ".local"
neovimdir = Path.home() / "neovim"
apt_cache = apt.Cache()

parser = ArgumentParser(description='Setup the neovim program')
packages_for_build = [
    "ninja-build", "gettext", "libtool", "libtool-bin", "autoconf", "automake", "cmake", "g++", "pkg-config", "unzip", "wget", "curl"
]

parser.add_argument('-c', '--clean', action='store_true', help='Clean before build and install')
parser.add_argument('-u', '--uninstall', action='store_true', help='Uninstall neovim local install path')
parser.add_argument('-b', '--build', action='store_true', help='Download/Update sources and build/install')
args = parser.parse_args()

if args.uninstall:
    call(["rm", "-f", nvim_install_dir / "bin" / "nvim"])
    call(["rm", "-fr", nvim_install_dir / "share" / "nvim"])
    call(["rm", "-fr", nvim_install_dir / "lib" / "nvim"])

chdir(Path.home())
# Install packages only if needed
for pac in packages_for_build:
    if not apt_cache[pac].is_installed:
        print("Needs to install packages for building Neovim")
        call(["sudo", "apt-get", "install", "-y", *packages_for_build])
        break

if args.clean and neovimdir.exists():
    chdir(neovimdir)
    call(["make", "distclean"])

if args.build:
    if not neovimdir.exists():
        call(["git", "clone", "https://github.com/neovim/neovim.git", neovimdir.parent])
    else:
        call(["git", "-C", neovimdir, "pull"])

    chdir(neovimdir)
    call(["make", "deps"])
    call(["make", "CMAKE_BUILD_TYPE=Release", "CMAKE_INSTALL_PREFIX={}".format(nvim_install_dir)])
    call(["make", "install"])
