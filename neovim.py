from os import chdir
from subprocess import run
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

build_tag = 'master'

parser.add_argument('-c', '--clean', action='store_true', help='Clean before build and install')
parser.add_argument('-u', '--uninstall', action='store_true', help='Uninstall neovim local install path')
parser.add_argument('-b', '--build', action='store_true', help='Download/Update sources and build/install')
args = parser.parse_args()

if args.uninstall:
    run(["rm", "-f", nvim_install_dir / "bin" / "nvim"], check=True)
    run(["rm", "-fr", nvim_install_dir / "share" / "nvim"], check=True)
    run(["rm", "-fr", nvim_install_dir / "lib" / "nvim"], check=True)

chdir(Path.home())
# Install packages only if needed
for pac in packages_for_build:
    if not apt_cache.get(pac) or not apt_cache.get(pac).is_installed:
        print("Needs to install packages for building Neovim")
        run(["sudo", "apt-get", "install", "-y", *packages_for_build], check=True)
        break

if args.clean and neovimdir.exists():
    chdir(neovimdir)
    run(["make", "distclean"], check=True)

if args.build:
    if not neovimdir.exists():
        run(["git", "clone", "-b", build_tag, "https://github.com/neovim/neovim.git", neovimdir], check=True)
    else:
        run(["git", "-C", neovimdir, "pull"], check=True)
        run(["git", "-C", neovimdir, "checkout", build_tag], check=True)

    chdir(neovimdir)
    run(["make", "deps"], check=True)
    run(["make", "CMAKE_BUILD_TYPE=Release", f"CMAKE_INSTALL_PREFIX={nvim_install_dir}"], check=True)
    run(["make", "install"], check=True)
