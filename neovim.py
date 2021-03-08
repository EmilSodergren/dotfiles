from os.path import expanduser, join, exists, basename
from os import chdir
from subprocess import call
from argparse import ArgumentParser
import apt

homefolder = expanduser("~")
nvim_install_dir = join(homefolder, ".local")
neovimdir = join(homefolder, "neovim")
apt_cache = apt.Cache()

parser = ArgumentParser(description='Setup the neovim program')
packages_for_build = [
    "ninja-build", "gettext", "libtool", "libtool-bin", "autoconf", "automake", "cmake", "g++", "pkg-config", "unzip", "wget", "curl"
]

parser.add_argument('-c', '--clean', action='store_true', help='Clean before build and install')
parser.add_argument('-u', '--uninstall', action='store_true', help='Uninstall neovim local install path')
parser.add_argument('-o', '--online', action='store_true', help='Download/Update sources and build/install')
args = parser.parse_args()

if args.uninstall:
    call(["rm", "-f", join(nvim_install_dir, "bin", "nvim")])
    call(["rm", "-fr", join(nvim_install_dir, "share", "nvim")])
    call(["rm", "-fr", join(nvim_install_dir, "lib", "nvim")])

chdir(homefolder)
# Install packages only if needed
for pac in packages_for_build:
    if not apt_cache[pac].is_installed:
        print("Needs to install packages for building Neovim")
        call(["sudo", "apt-get", "install", "-y", *packages_for_build])
        break

if args.clean and exists(neovimdir):
    chdir(neovimdir)
    call(["make", "distclean"])

if args.online:
    if not exists(neovimdir):
        call(["git", "clone", "https://github.com/neovim/neovim.git", basename(neovimdir)])
    else:
        call(["git", "-C", neovimdir, "pull"])

    chdir(neovimdir)
    call(["make", "deps"])
    call(["make", "CMAKE_BUILD_TYPE=Release", "CMAKE_INSTALL_PREFIX={}".format(nvim_install_dir)])
    call(["make", "install"])
