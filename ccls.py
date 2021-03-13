from os.path import expanduser, join, exists, basename
from os import chdir
from subprocess import call
from argparse import ArgumentParser
import apt

homefolder = expanduser("~")
ccls_install_dir = join(homefolder, ".local")
ccls_dir = join(homefolder, "ccls")
apt_cache = apt.Cache()

parser = ArgumentParser(description='Setup the ccls program')
packages_for_build = ["clang", "cmake", "libclang-dev", "llvm-dev", "rapidjson-dev"]

parser.add_argument('-u', '--uninstall', action='store_true', help='Uninstall ccls local install path')
parser.add_argument('-b', '--build', action='store_true', help='Download/Update sources and build/install')
args = parser.parse_args()

if args.uninstall:
    call(["rm", "-f", join(ccls_install_dir, "bin", "ccls")])

chdir(homefolder)
# Install packages only if needed
for pac in packages_for_build:
    if not apt_cache[pac].is_installed:
        print("Needs to install packages for building CCLS")
        call(["sudo", "apt-get", "install", "-y", *packages_for_build])
        break

if args.build:
    if not exists(ccls_dir):
        call(["git", "clone", "--depth=1", "--recursive", "https://github.com/MaskRay/ccls", basename(ccls_dir)])
    else:
        call(["git", "-C", ccls_dir, "pull"])

    chdir(ccls_dir)
    call(["cmake", "-H.", "-BRelease", "-DCMAKE_BUILD_TYPE=Release", "-DCMAKE_INSTALL_PREFIX={}".format(ccls_install_dir)])
    call(["cmake", "--build", "Release", "--target", "install"])
