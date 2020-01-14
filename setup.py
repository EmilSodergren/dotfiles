from os.path import dirname, realpath, expanduser, join, exists, islink
from os import symlink, remove, chdir, getcwd, remove, makedirs
from subprocess import call, check_output, Popen, PIPE
from argparse import ArgumentParser
import re

dotfilespath = dirname(realpath(__file__))
homefolder = expanduser("~")
diff_so_fancy = join("bin", "diff-so-fancy")
neovim_init = join(".config", "nvim", "init.vim")
settingsfiles = [".vim", ".bashrc", ".tmux.conf", ".gitconfig", ".bash_git", ".profile", ".bash_completion", ".bash_completion.d", diff_so_fancy, neovim_init]
rust_binaries = ["cargo", "install-update", "-i", "cargo-update", "cargo-watch", "ripgrep", "fd-find", "tokei", "exa", "bat"]
rust_nightly_binaries = ["cargo", "+nightly", "install-update", "-i", "racer"]

parser = ArgumentParser(description='Setup the machine')

parser.add_argument('-i', '--internet', action='store_true', help='Download stuff from the internet')
parser.add_argument('-p', '--pack', action='store_true', help='Pack everything in dotfiles.tar.gz')
args = parser.parse_args()

for stuff in settingsfiles:
    linkpath = join(homefolder, stuff)
    sourcepath = join(dotfilespath, stuff)
    if islink(linkpath):
        remove(linkpath)
    if not exists(dirname(linkpath)):
        makedirs(dirname(linkpath), exist_ok=True)
    symlink(sourcepath, linkpath)

gitconfig_path = join(dotfilespath, ".gitconfig")
regex = re.compile(r"email = *(.*)$")
replace_line = ""
old_email = ""
new_email = ""
with open(gitconfig_path, "rt") as f:
    for line in f:
        result = regex.search(line)
        if result:
            replace_line = result.group(0)
            old_email = result.group(1) or "EmilSodergren@users.noreply.github.com"
            new_email = input("Give mail ({}):".format(old_email)) or old_email

file_content = ""
with open(gitconfig_path, "rt") as f:
    file_content = f.read().replace(replace_line, "email = "+new_email)

with open(gitconfig_path, "wt") as fout:
    fout.write(file_content)

if args.internet:
    try:
        call(["nvim", "+PlugUpgrade", "+PlugUpdate", "+GoInstallBinaries", "+UpdateRemotePlugins", "+qall"])
    except FileNotFoundError:
        call(["vim", "+PlugUpgrade", "+PlugUpdate", "+GoInstallBinaries", "+UpdateRemotePlugins", "+qall"])

    ps = Popen(["curl", "https://sh.rustup.rs", "-sSf"], stdout=PIPE)
    call(["sh", "-s", "--", "-y"], stdin=ps.stdout)
    ps.wait()
    makedirs(join(homefolder, "bin"), exist_ok=True)
    call(["wget", "-N", "-P", "bin", "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy"])
    call(["chmod", "+x", diff_so_fancy])
    call(["rustup", "update", "stable"])
    call(["rustup", "component", "add", "rustfmt"])
    call(["rustup", "component", "add", "rust-src"])
    call(["rustup", "component", "add", "rls", "--toolchain", "stable-x86_64-unknown-linux-gnu"])
    test = call(rust_binaries)
    if test != 0:
        call(["cargo", "install", "cargo-update"])
        call(rust_binaries)
    test2 = call(rust_nightly_binaries)
    if test2 != 0:
        call(["rustup", "update", "nightly"])
        call(rust_nightly_binaries)

if args.pack:
    chdir(homefolder)
    call(["tar", "cfz", "dotfiles.tar.gz", ".dotfiles/", "go/bin/", ".cargo/bin/", ".fzf"])
    print("")
    print(".dotfiles has been packed into " + join(homefolder, "dotfiles.tar.gz"))
