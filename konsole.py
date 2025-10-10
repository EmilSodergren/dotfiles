from os import chdir, cpu_count
from subprocess import call
from argparse import ArgumentParser
from shutil import rmtree
from pathlib import Path
import apt

konsole_install_dir = Path.home() / ".local"
konsole_dir = Path.home() / "konsole"
build_dir = konsole_dir / "build"
apt_cache = apt.Cache()
nproc = str(cpu_count())

build_tag = "v25.08.2"

packages_for_build = [
    "cmake",
    "extra-cmake-modules",
    "g++",
    "git",
    "libicu-dev",
    "libkf6auth-dev",
    "libkf6config-dev",
    "libkf6coreaddons-dev",
    "libkf6crash-dev",
    "libkf6declarative-dev",
    "libkf6i18n-dev",
    "libkf6kcmutils-dev",
    "libkf6iconthemes-dev",
    "libkf6textwidgets-dev",
    "libkf6dbusaddons-dev",
    "libkf6kcmutils-dev",
    "libkf6newstuff-dev",
    "libkf6notifications-dev",
    "libkf6notifyconfig-dev",
    "libkf6package-dev",
    "libkf6parts-dev",
    "libkf6pty-dev",
    "libqt6core6t64",
    "libqt6gui6",
    "libqt6qml6",
    "libqt6widgets6",
    "make",
    "qmake6",
    "qt6-base-dev",
    "qt6-tools-dev",
    "qtchooser",
    "qt6-multimedia-dev",
    "qt6-5compat-dev",
]

parser = ArgumentParser(description='Setup the konsole program')
parser.add_argument('-b', '--build', action='store_true', help='Download/Update sources and build/install')
parser.add_argument('-c', '--clean', action='store_true', help='Clean before build')
args = parser.parse_args()

chdir(Path.home())
# Install packages only if needed
for pac in packages_for_build:
    if not apt_cache.get(pac) or not apt_cache.get(pac).is_installed:
        print("Needs to install packages for building konsole")
        call(["sudo", "apt-get", "install", "-y", *packages_for_build])
        break

if args.clean and build_dir.exists():
    rmtree(build_dir)

if args.build:
    if not konsole_dir.exists():
        call(["git", "clone", "-b", build_tag, "https://invent.kde.org/utilities/konsole.git", konsole_dir])
    else:
        call(["git", "-C", konsole_dir, "pull"])
        call(["git", "-C", konsole_dir, "checkout", build_tag])

    build_dir.mkdir(exist_ok=True)
    chdir(build_dir)
    # Debian 10 needs tag v19.12.3 in konsole, and kinit-dev package installed
    call(["cmake", "..", "-DCMAKE_BUILD_TYPE=release", "-DCMAKE_INSTALL_PREFIX={}".format(konsole_install_dir)])
    call(["make", "-j", nproc])
    if apt_cache.get("konsole") and apt_cache.get("konsole").is_installed:
        call(["sudo", "apt-get", "remove", "-y", "konsole"])
    call(["make", "install", "-j", nproc])
