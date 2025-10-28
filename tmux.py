from os import chdir, cpu_count
from subprocess import run
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
    if not apt_cache.get(pac) or not apt_cache.get(pac).is_installed:
        print("Needs to install packages for building konsole")
        run(["sudo", "apt-get", "install", "-y", *packages_for_build], check=True)
        break

if args.clean:
    if tmux_dir.exists():
        rmtree(tmux_dir)

if args.build:
    if not tmux_dir.exists():
        run(["git", "clone", "-b", build_tag, "https://github.com/tmux/tmux.git", tmux_dir], check=True)
    else:
        run(["git", "-C", tmux_dir, "pull"], check=True)
        run(["git", "-C", tmux_dir, "checkout", build_tag], check=True)

    chdir(tmux_dir)
    run(["sh", "autogen.sh"], check=True)
    run(["./configure", f"--prefix={tmux_install_dir}"], check=True)
    run(["make", "-j", nproc], check=True)
    if apt_cache.get("tmux") and apt_cache.get("tmux").is_installed:
        run(["sudo", "apt-get", "remove", "-y", "tmux"], check=True)
    run(["make", "install"], check=True)
