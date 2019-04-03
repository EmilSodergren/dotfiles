from os.path import dirname, realpath, expanduser, join, exists
from os import symlink, remove, chdir, getcwd
from subprocess import call, Popen, PIPE
from argparse import ArgumentParser
import re

dotfilespath = dirname(realpath(__file__))
homefolder = expanduser("~")

settingsfiles = [".vim", ".bashrc", ".tmux.conf", ".gitconfig", ".bash_git", ".profile", ".bash_completion", ".bash_completion.d"]

parser = ArgumentParser(description='Setup the machine')

parser.add_argument('-i', '--internet', action='store_true', help='Download stuff from the internet')
parser.add_argument('-n', '--nightly', action='store_true', help='Download the latest nightly build')
args = parser.parse_args()

for stuff in settingsfiles:
    linkpath = join(homefolder, stuff)
    sourcepath = join(dotfilespath, stuff)
    if exists(linkpath):
        remove(linkpath)
    symlink(sourcepath, linkpath)

gitconfig_path = join(dotfilespath, ".gitconfig")
regex = re.compile("email = (.*$)")
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
    # Ugly fix to install markdown dependencies
    current = getcwd()
    chdir(homefolder+"/.vim/bundle/markdown-preview.nvim/app/")
    call(["bash", "install.sh"])
    chdir(current)
    # End of ugly fix
    call(["vim", "+GoInstallBinaries", "+qall"])
    call(["vim", "+FZF", "+qall"])

    ps = Popen(["curl", "https://sh.rustup.rs", "-sSf"], stdout=PIPE)
    call(["sh", "-s", "--", "-y"], stdin=ps.stdout)
    ps.wait()
    call(["rustup", "component", "add", "rustfmt"])
    call(["rustup", "component", "add", "rust-src"])
    call(["cargo", "install", "cargo-watch"])

    if args.nightly:
        call(["rustup", "install", "nightly"])
        call(["cargo", "+nightly", "install", "racer"])
