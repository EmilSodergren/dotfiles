from os import chdir, cpu_count
from subprocess import run
from argparse import ArgumentParser
from shutil import rmtree
from pathlib import Path
import apt
import check_dep_version

konsole_install_dir = Path.home() / ".local"
konsole_dir = Path.home() / "konsole"
build_dir = konsole_dir / "build"
apt_cache = apt.Cache()
nproc = str(cpu_count())

common_packages = ["cmake", "extra-cmake-modules", "g++", "git", "make", "qtchooser", "libicu-dev"]
packages_for_u22 = [
    "libqt5core5a",
    "libqt5gui5",
    "libqt5widgets5",
]
packages_for_u24 = [
    "libqt5core5t64",
    "libqt5gui5t64",
    "libqt5widgets5t64",
]
packages_for_Qt5 = [
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
    "libqt5qml5",
    "qttools5-dev",
    "qt5-qmake",
    "qtbase5-dev",
    "qtbase5-dev-tools",
    "qtmultimedia5-dev",
]
packages_for_Qt6 = [
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
    "qmake6",
    "qt6-base-dev",
    "qt6-tools-dev",
    "qt6-multimedia-dev",
    "qt6-5compat-dev",
]


def get_dep_packages():
    match check_dep_version.get_kernel_version_string():
        case "5.15.0":
            return common_packages + packages_for_Qt5 + packages_for_u22
        case "6.8.0":
            return common_packages + packages_for_Qt5 + packages_for_u24
        case "6.17.0":
            return common_packages + packages_for_Qt6
        case _:
            raise ValueError("No match for current kernel version")


def get_konsole_tag():
    match check_dep_version.get_kernel_version_string():
        case "5.15.0":
            return "v23.08.5"
        case "6.8.0":
            return "v23.08.5"
        case "6.17.0":
            return "v25.08.5"
        case _:
            raise ValueError("No match for current kernel version")


parser = ArgumentParser(description='Setup the konsole program')
parser.add_argument('-b', '--build', action='store_true', help='Download/Update sources and build/install')
parser.add_argument('-c', '--clean', action='store_true', help='Clean before build')
args = parser.parse_args()

chdir(Path.home())
# Install packages only if needed
for pac in get_dep_packages():
    if not apt_cache.get(pac) or not apt_cache.get(pac).is_installed:
        print("Needs to install packages for building konsole")
        run(["sudo", "apt-get", "install", "-y", *get_dep_packages()], check=True)
        break

if args.clean and build_dir.exists():
    rmtree(build_dir)

if args.build:
    if not konsole_dir.exists():
        run(["git", "clone", "-b", get_konsole_tag(), "https://invent.kde.org/utilities/konsole.git", konsole_dir], check=True)
    else:
        run(["git", "-C", konsole_dir, "pull"], check=True)
        run(["git", "-C", konsole_dir, "checkout", get_konsole_tag()], check=True)

    build_dir.mkdir(exist_ok=True)
    chdir(build_dir)
    # Debian 10 needs tag v19.12.3 in konsole, and kinit-dev package installed
    run(["cmake", "..", "-DCMAKE_BUILD_TYPE=release", f"-DCMAKE_INSTALL_PREFIX={konsole_install_dir}"], check=True)
    run(["make", "-j", nproc], check=True)
    if apt_cache.get("konsole") and apt_cache.get("konsole").is_installed:
        run(["sudo", "apt-get", "remove", "-y", "konsole"], check=True)
    run(["make", "install", "-j", nproc], check=True)
