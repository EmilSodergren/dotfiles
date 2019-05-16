from os.path import dirname, realpath, expanduser, join, exists, islink
from os import symlink, remove, chdir, getcwd, remove
from subprocess import call, check_output, Popen, PIPE
from argparse import ArgumentParser
import re

dotfilespath = dirname(realpath(__file__))
homefolder = expanduser("~")
diff_so_fancy = join("bin", "diff-so-fancy")
settingsfiles = [".vim", ".bashrc", ".tmux.conf", ".gitconfig", ".bash_git", ".profile", ".bash_completion", ".bash_completion.d", diff_so_fancy]
rust_binaries = ["cargo", "install-update", "-i", "cargo-update", "cargo-watch", "ripgrep", "fd-find", "tokei", "exa", "bat"]
rust_nightly_binaries = ["cargo", "+nightly", "install-update", "-i", "racer"]

parser = ArgumentParser(description='Setup the machine')

parser.add_argument('-i', '--internet', action='store_true', help='Download stuff from the internet')
parser.add_argument('-p', '--pack', action='store_true', help='Pack everything in dotfiles.tar.gz')
parser.add_argument('-m', '--installmarkdown', action='store_true', help='Install markdown plugin dependencies')
args = parser.parse_args()

for stuff in settingsfiles:
    linkpath = join(homefolder, stuff)
    sourcepath = join(dotfilespath, stuff)
    if islink(linkpath):
        remove(linkpath)
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
            # Rename raw_input to input on python3
            try: input = raw_input
            except NameError: pass
            new_email = input("Give mail ({}):".format(old_email)) or old_email

file_content = ""
with open(gitconfig_path, "rt") as f:
    file_content = f.read().replace(replace_line, "email = "+new_email)

with open(gitconfig_path, "wt") as fout:
    fout.write(file_content)

if args.internet:
    if (not exists(homefolder+"/.dotfiles/.vim/bundle/Vundle.vim")):
        call(["git", "clone", "https://github.com/VundleVim/Vundle.vim.git", homefolder+"/.dotfiles/.vim/bundle/Vundle.vim"])
    if (not exists(homefolder+"/.dotfiles/tmux-resurrect")):
        call(["git", "clone", "https://github.com/tmux-plugins/tmux-resurrect", homefolder+"/.dotfiles/tmux-resurrect"])
    call(["vim","+VundleUpdate","+qall"])
    call(["vim", "+GoInstallBinaries", "+qall"])

    ps = Popen(["curl", "https://sh.rustup.rs", "-sSf"], stdout=PIPE)
    call(["sh", "-s", "--", "-y"], stdin=ps.stdout)
    ps.wait()
    call(["wget", "-N", "-P", "bin", "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy"])
    call(["chmod", "+x", diff_so_fancy])
    call(["rustup", "update", "stable"])
    call(["rustup", "component", "add", "rustfmt"])
    call(["rustup", "component", "add", "rust-src"])
    test = call(rust_binaries)
    test2 = call(rust_nightly_binaries)
    if test != 0:
        call(["cargo", "install", "cargo-update"])
        call(rust_binaries)
    if test2 != 0:
        call(["rustup", "update", "nightly"])
        call(rust_nightly_binaries)

    print("Installing markdown-preview.nvim!")
    call(["vim", "+call mkdp#util#install()", "+qall"])

    call(["vim", "+FZF", "+qall"])


if args.pack:
    chdir(homefolder)
    call(["tar", "cfz", "dotfiles.tar.gz", ".dotfiles/", "go/bin/", ".cargo/bin/"])
