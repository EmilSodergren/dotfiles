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

parser = ArgumentParser(description='Setup the konsole program')
packages_for_build = [
    "cmake",
    "extra-cmake-modules",
    "g++",
    "git",
    "libicu-dev",
    "libkf5auth-dev",
    "libkf5config-dev",
    "libkf5coreaddons-dev",
    "libkf5crash-dev",
    "libkf5declarative-dev",
    "libkf5i18n-dev",
    "libkf5kcmutils-dev",
    "libkf5newstuff-dev",
    "libkf5notifications-dev",
    "libkf5notifyconfig-dev",
    "libkf5package-dev",
    "libkf5parts-dev",
    "libkf5pty-dev",
    "libqt5core5a",
    "libqt5gui5",
    "libqt5qml5",
    "libqt5widgets5",
    "make",
    "qttools5-dev",
    "qt5-qmake",
    "qtbase5-dev",
    "qtbase5-dev-tools",
    "qtchooser",
    "qtmultimedia5-dev",
]

parser.add_argument('-b', '--build', action='store_true', help='Download/Update sources and build/install')
parser.add_argument('-c', '--clean', action='store_true', help='Clean before build')
args = parser.parse_args()

chdir(Path.home())
# Install packages only if needed
for pac in packages_for_build:
    if not apt_cache[pac].is_installed:
        print("Needs to install packages for building konsole")
        call(["sudo", "apt-get", "install", "-y", *packages_for_build])
        break

if args.clean and build_dir.exists():
    rmtree(build_dir)

if args.build:
    if not konsole_dir.exists():
        call(["git", "clone", "-b", "v23.08.3", "https://invent.kde.org/utilities/konsole.git", konsole_dir])
    else:
        call(["git", "-C", konsole_dir, "pull"])

    build_dir.mkdir(exist_ok=True)
    chdir(build_dir)
    # Debian 10 needs tag v19.12.3 in konsole, and kinit-dev package installed
    call(["cmake", "..", "-DCMAKE_BUILD_TYPE=release", "-DCMAKE_INSTALL_PREFIX={}".format(konsole_install_dir)])
    call(["make", "-j", nproc])
    if apt_cache["konsole"].is_installed:
        call(["sudo", "apt-get", "remove", "-y", "konsole"])
    call(["make", "install", "-j", nproc])
