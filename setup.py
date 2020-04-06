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
rust_binaries = ["cargo", "install", "cargo-watch", "ripgrep", "fd-find", "tokei", "lsd", "bat"]
rust_analyzer = ["cargo", "install", "--git", "https://github.com/rust-analyzer/rust-analyzer",  "rust-analyzer"]

parser = ArgumentParser(description='Setup the machine')

parser.add_argument('-o', '--online', action='store_true', help='Download stuff from the internet')
parser.add_argument('-u', '--update-go-binaries', action='store_true', help='Skip updating the go binaries')
parser.add_argument('-sr', '--skip-rust', action='store_true', help='Skip downloading and updating the rust toolchain')
parser.add_argument('-f', '--font', action='store_true', help='Install Nerd Fonts')
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
regex = re.compile(r"email =( ?)(.*)$")
replace_line = ""
old_email = ""
new_email = ""
with open(gitconfig_path, "rt") as f:
    for line in f:
        result = regex.search(line)
        if result:
            replace_line = result.group(0)
            old_email = result.group(2) or "EmilSodergren@users.noreply.github.com"
            new_email = input("Give mail ({}):".format(old_email)) or old_email

file_content = ""
with open(gitconfig_path, "rt") as f:
    file_content = f.read().replace(replace_line, "email = "+new_email)

with open(gitconfig_path, "wt") as fout:
    fout.write(file_content)

# Install dependencies for Rust binaries
call(["sudo", "apt-get", "-y", "install", "libclang-dev", "libssl-dev", "fonts-powerline", "python3-jedi"])

if args.online:
    try:
        call(["nvim", "+PlugUpgrade", "+PlugUpdate", "+UpdateRemotePlugins", "+qall"])
    except FileNotFoundError:
        call(["vim", "+PlugUpgrade", "+PlugUpdate", "+UpdateRemotePlugins", "+qall"])
    if args.update_go_binaries:
        try:
            call(["nvim", "+set ft=go", "+GoUpdateBinaries", "+qall"])
        except FileNotFoundError:
            call(["vim", "+set ft=go", "+GoUpdateBinaries", "+qall"])

    if exists(join(dotfilespath, "tmux-resurrect")):
        call(["git", "-C", join(dotfilespath, "tmux-resurrect"), "pull"])
        call(["git", "-C", join(dotfilespath, "tmux-continuum"), "pull"])
    else:
        call(["git", "clone", "https://github.com/tmux-plugins/tmux-resurrect", join(dotfilespath, "tmux-resurrect")])
        call(["git", "clone", "https://github.com/tmux-plugins/tmux-continuum", join(dotfilespath, "tmux-continuum")])

    makedirs(join(homefolder, "bin"), exist_ok=True)
    call(["wget", "-N", "-P", "bin", "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy"])
    call(["chmod", "+x", diff_so_fancy])
    call(["wget", "-N", "-P", "bin", "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip"])

    if not args.skip_rust:
        ps = Popen(["curl", "https://sh.rustup.rs", "-sSf"], stdout=PIPE)
        call(["sh", "-s", "--", "-y"], stdin=ps.stdout)
        ps.wait()
        call(["rustup", "update", "stable"])
        call(["rustup", "component", "add", "rustfmt"])
        call(["rustup", "component", "add", "rust-src"])

        if exists(join(homefolder,".cargo", "bin", "cargo-install-update")):
            call(["cargo", "install-update", "-ag"])
        else:
            call(rust_binaries)
            call(rust_analyzer)
            call(["cargo", "install", "cargo-update"])

if args.font:
    call(["sudo", "unzip", "-o", join(dotfilespath, "bin", "Hack.zip"), "-d", "/usr/local/share/fonts/"])
    call(["fc-cache", "-f", "-v"])

if args.pack:
    chdir(homefolder)
    call(["tar", "cfz", "dotfiles.tar.gz", ".dotfiles/", "go/bin/", ".cargo/bin/", ".fzf"])
    print("")
    print(".dotfiles has been packed into " + join(homefolder, "dotfiles.tar.gz"))
