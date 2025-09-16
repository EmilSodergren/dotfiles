from os import chdir, cpu_count
from subprocess import call
from argparse import ArgumentParser
from shutil import rmtree
from pathlib import Path
import apt

tmux_install_dir = Path.home() / ".local"
tmux_dir = Path.home() / "tmux"
apt_cache = apt.Cache()
nproc = str(cpu_count())

build_tag = "3.5a"

parser = ArgumentParser(description='Build the tmux program')
packages_for_build = [
    "make",
    "bison",
    "libevent-dev",
]

parser.add_argument('-b', '--build', action='store_true', help='Download/Update sources and build/install')
parser.add_argument('-c', '--clean', action='store_true', help='Clean before build')
args = parser.parse_args()

chdir(Path.home())
# Install packages only if needed
for pac in packages_for_build:
    if not apt_cache.has_key(pac):
        print("Needs to install packages for building konsole")
        call(["sudo", "apt-get", "install", "-y", *packages_for_build])
        break

if args.clean:
    if tmux_dir.exists():
        rmtree(tmux_dir)

if args.build:
    if not tmux_dir.exists():
        call(["git", "clone", "-b", build_tag, "https://github.com/tmux/tmux.git", tmux_dir])
    else:
        call(["git", "-C", tmux_dir, "pull"])
        call(["git", "-C", tmux_dir, "checkout", build_tag])

    chdir(tmux_dir)
    call(["sh", "autogen.sh"])
    call(["./configure", "--prefix={}".format(tmux_install_dir)])
    call(["make", "-j", nproc])
    if apt_cache.has_key("tmux"):
        call(["sudo", "apt-get", "remove", "-y", "tmux"])
    call(["make", "install"])
