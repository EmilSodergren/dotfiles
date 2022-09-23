from os.path import expanduser, join, exists, basename
from os import chdir, cpu_count
from subprocess import call
from argparse import ArgumentParser
from shutil import rmtree
import apt

homefolder = expanduser("~")
tmux_install_dir = join(homefolder, ".local")
tmux_dir = join(homefolder, "tmux")
apt_cache = apt.Cache()
nproc = str(cpu_count())

parser = ArgumentParser(description='Build the tmux program')
packages_for_build = [
    "make",
    "bison",
    "libevent-dev",
]

parser.add_argument('-b', '--build', action='store_true', help='Download/Update sources and build/install')
parser.add_argument('-c', '--clean', action='store_true', help='Clean before build')
args = parser.parse_args()

chdir(homefolder)
# Install packages only if needed
for pac in packages_for_build:
    if not apt_cache[pac].is_installed:
        print("Needs to install packages for building konsole")
        call(["sudo", "apt-get", "install", "-y", *packages_for_build])
        break

if args.clean:
    if exists(tmux_dir):
        rmtree(tmux_dir)

if args.build:
    if not exists(tmux_dir):
        call(["git", "clone", "https://github.com/tmux/tmux.git", basename(tmux_dir)])
    else:
        call(["git", "-C", tmux_dir, "pull"])

    chdir(basename(tmux_dir))
    call(["sh", "autogen.sh"])
    call(["./configure", "--prefix={}".format(tmux_install_dir)])
    call(["make", "-j", nproc])
    if apt_cache["tmux"].is_installed:
        call(["sudo", "apt-get", "remove", "-y", "tmux"])
    call(["make", "install"])
