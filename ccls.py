from os import chdir, cpu_count
from math import floor
from subprocess import call
from argparse import ArgumentParser
from shutil import rmtree
from pathlib import Path
import apt

ccls_install_dir = Path.home() / ".local"
ccls_dir = Path.home() / "ccls"
apt_cache = apt.Cache()

parser = ArgumentParser(description='Setup the ccls program')
packages_for_build = ["clang", "cmake", "libclang-dev", "llvm-dev", "rapidjson-dev"]

build_tag = 'master'

parser.add_argument('-u', '--uninstall', action='store_true', help='Uninstall ccls local install path')
parser.add_argument('-b', '--build', action='store_true', help='Download/Update sources and build/install')
parser.add_argument('-c', '--clean', action='store_true', help='Clean before build')
args = parser.parse_args()

if args.uninstall:
    call(["rm", "-f", ccls_install_dir / "bin" / "ccls"])

chdir(Path.home())
# Install packages only if needed
for pac in packages_for_build:
    if not apt_cache.has_key(pac):
        print("Needs to install packages for building CCLS")
        call(["sudo", "apt-get", "install", "-y", *packages_for_build])
        break

if ccls_dir.exists():
    rmtree(ccls_dir)

if args.build:
    if not ccls_dir.exists():
        call(["git", "clone", "-b", build_tag, "--depth=1", "--recursive", "https://github.com/MaskRay/ccls", ccls_dir])
    else:
        call(["git", "-C", ccls_dir, "pull"])
        call(["git", "-C", ccls_dir, "checkout", build_tag])

    chdir(ccls_dir)
    call(["cmake", "-H.", "-BRelease", "-DCMAKE_BUILD_TYPE=Release", "-DCMAKE_INSTALL_PREFIX={}".format(ccls_install_dir)])
    call(["cmake", "--build", "Release", "--target", "install", "--parallel", str(floor(0.75 * cpu_count()))])
