from os.path import dirname, realpath, expanduser, join, exists, islink
from os import symlink, remove, chdir, makedirs
from subprocess import call, Popen, PIPE
from argparse import ArgumentParser
import re

dotfilespath = dirname(realpath(__file__))
homefolder = expanduser("~")
local_bin = join(".local", "bin")
diff_so_fancy = join(local_bin, "diff-so-fancy")
bfg_jar = join(local_bin, "bfg-1.13.0.jar")
antiword = join(local_bin, "antiword")
neovim_init = join(".config", "nvim", "init.vim")
pycodestyle_config = join(".config", "pycodestyle")
yapf_config = join(".config", "yapf", "style")
nodejs_language_servers = ["yaml-language-server", "dockerfile-language-server-nodejs", "bash-language-server"]
settingsfiles = [
    ".vim", ".bashrc", ".tmux.conf", ".gitconfig", ".bash_git", ".profile", ".bash_completion", ".bash_completion.d", diff_so_fancy,
    neovim_init, antiword, bfg_jar, pycodestyle_config, yapf_config
]
rust_binaries = ["bat", "cargo-watch", "du-dust", "fd-find", "lsd", "ripgrep", "sd", "tokei", "ytop", "zoxide"]
rust_analyzer = ["https://github.com/rust-analyzer/rust-analyzer", "xtask", "rust-analyzer"]

parser = ArgumentParser(description='Setup the machine')

parser.add_argument('-o', '--online', action='store_true', help='Download stuff from the internet')
parser.add_argument('-u',
                    '--update-go-binaries',
                    action='store_true',
                    help='Update the go binaries, requires manual restart of the script after completion')
parser.add_argument('-sr', '--skip-rust', action='store_true', help='Skip downloading and updating the rust toolchain')
parser.add_argument('-f', '--font', action='store_true', help='Install Nerd Fonts')
parser.add_argument('-p', '--pack', action='store_true', help='Pack everything in dotfiles.tar.gz')
args = parser.parse_args()


def exists_all(path, files):
    for f in files[2:]:
        if not exists(join("path", f)):
            return False
    return True


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
    file_content = f.read().replace(replace_line, "email = " + new_email)

with open(gitconfig_path, "wt") as fout:
    fout.write(file_content)

# Install good stuff, and nodejs
call(["sudo", "apt-get", "-y", "install", "antiword", "docx2txt", "tmux", "nodejs", "npm"])
# Install dependencies for Rust binaries
call(["sudo", "apt-get", "-y", "install", "libclang-dev", "libssl-dev", "fonts-powerline", "python3-jedi", "python3-lib2to3"])

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

    call(["npm", "install", "--prefix", join(homefolder, ".local"), *nodejs_language_servers])
    call(["sudo", "apt", "install", "-y", "python3-pip"])
    makedirs(local_bin, exist_ok=True)

    # Download online resources
    call([
        "wget", "-N", "-P", local_bin,
        "https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy"
    ])
    call(["chmod", "+x", diff_so_fancy])
    call(["wget", "-N", "-P", local_bin, "https://repo1.maven.org/maven2/com/madgag/bfg/1.13.0/bfg-1.13.0.jar"])
    call(["chmod", "+x", bfg_jar])
    call(["wget", "-N", "-P", "bin", "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip"])

    call(["python3", "-m", "pip", "install", "--upgrade", "python-language-server[rope,pyflakes,mccabe,pycodestyle,yapf]"])
    call(["python3", "-m", "pip", "install", "--upgrade", "pynvim"])

    if not args.skip_rust:
        ps = Popen(["curl", "--proto", "=https", "--tlsv1.2", "-sSf", "https://sh.rustup.rs"], stdout=PIPE)
        call(["sh", "-s", "--", "--default-toolchain", "none", "-y"], stdin=ps.stdout)
        ps.wait()
        call(["rustup", "update", "stable"])
        call(["rustup", "component", "add", "rustfmt"])
        call(["rustup", "component", "add", "rust-src"])
        call(["rustup", "component", "add", "clippy"])

        if exists_all(join(homefolder, ".cargo", "bin"), rust_binaries):
            call(["cargo", "install-update", "-ag"])
        else:
            call(["cargo", "install", *rust_binaries])
            call(["cargo", "install", "--git", *rust_analyzer])
            call(["cargo", "install", "cargo-update"])

if args.font:
    call(["sudo", "unzip", "-o", join(dotfilespath, "bin", "Hack.zip"), "-d", "/usr/local/share/fonts/"])
    call(["fc-cache", "-f", "-v"])

if args.pack:
    chdir(homefolder)
    call([
        "tar", "cfz", "dotfiles.tar.gz", ".dotfiles/", "go/bin/", ".cargo/bin/", ".cargo/env", local_bin, ".local/node_modules",
        ".local/include", ".local/lib", ".fzf"
    ])
    print("")
    print(".dotfiles has been packed into " + join(homefolder, "dotfiles.tar.gz"))
