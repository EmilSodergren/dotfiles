from os.path import dirname, realpath, expanduser, join, exists, islink
from os import symlink, remove, chdir, makedirs, system
from subprocess import call, Popen, PIPE
from argparse import ArgumentParser
from datetime import datetime
from glob import glob
from shutil import rmtree, move
import re
import apt
import os
import sys

import check_dep_version

dotfilespath = dirname(realpath(__file__))
homefolder = expanduser("~")
local_bin = join(".local", "bin")
host_local_bin = join(homefolder, local_bin)
bfg_jar = join(host_local_bin, "bfg.jar")
marksman_bin = join(host_local_bin, "marksman")
ra_bin = join(host_local_bin, "rust-analyzer")
antiword = join(local_bin, "antiword")
ccls_config = join(local_bin, "ccls_config")
forgit = join(local_bin, "forgit")
write_notes = join(local_bin, "write_notes")
konsole_config = join(".local", "share", "konsole", "Emil.profile")
neovim_init = join(".config", "nvim")
pycodestyle_config = join(".config", "pycodestyle")
yapf_config = join(".config", "yapf", "style")
nodejs_language_servers = [
    "yaml-language-server", "dockerfile-language-server-nodejs", "bash-language-server", "neovim", "vscode-langservers-extracted"
]
settingsfiles = [
    ".bash_completion", ".bash_completion.d", ".bash_git", ".bashrc", ".gitconfig", ".profile", ".tmux.conf", ".vim", antiword, ccls_config,
    forgit, konsole_config, neovim_init, pycodestyle_config, write_notes, yapf_config
]
tree_sitter_languages = [
    "bash",
    "c",
    "dockerfile",
    "go",
    "gomod",
    "json",
    "make",
    "markdown",
    "python",
    "rust",
    "toml",
    "yaml",
]
rustup_bin = join(homefolder, ".cargo/bin/rustup")
rust_binaries = ["bat", "cargo-watch", "cargo-edit", "du-dust", "fd-find", "git-delta", "lsd", "ripgrep", "sd", "tokei", "ytop", "zoxide"]
packages_to_install = [
    "antiword",
    "apt-transport-https",
    "bash-completion",
    "curl",
    "docx2txt",
    "flameshot",
    "fonts-powerline",
    "git",
    "libclang-dev",
    "libssl-dev",
    "make",
    "python3-jedi",
    "python3-lib2to3",
    "python3-pip",
    "python3-semver",
    "python3-venv",
    "software-properties-common",
    "ssh-askpass",
    "vim-nox",
    "wl-clipboard",
    "xclip",
]
apt_cache = apt.Cache()

parser = ArgumentParser(description='Setup the machine')

parser.add_argument('-o', '--online', action='store_true', help='Download stuff from the internet')
parser.add_argument('-ob', '--only-brave', action='store_true', help='Only install brave browser and exit')
parser.add_argument('-sa', '--skip_all', action='store_true', help='Short hand for -sn -sc -sk -sr -st, only vaild if --online is defined')
parser.add_argument('-sn', '--skip_neovim', action='store_true', help='Should neovim be skipped, only vaild if --online is defined')
parser.add_argument('-c',
                    '--clean',
                    action='store_true',
                    help='If programs should be cleaned before build, only vaild if --online  is defined')
parser.add_argument('-sc', '--skip_ccls', action='store_true', help='Should ccls be skipped, only vaild if --online is defined')
parser.add_argument('-sk', '--skip_konsole', action='store_true', help='Should konsole be skipped, only vaild if --online is defined')
parser.add_argument('-st', '--skip_tmux', action='store_true', help='Should tmux be skipped, only vaild if --online is defined')
parser.add_argument('-sr', '--skip-rust', action='store_true', help='Skip downloading and updating the rust toolchain')
parser.add_argument('-f', '--font', action='store_true', help='Install Hack Nerd Fonts')
parser.add_argument('-p', '--pack', action='store_true', help='Pack everything in dotfiles.tar.gz')
parser.add_argument('-a', '--artifactory', action='store_true', help='Publish to Artifactory')
args = parser.parse_args()


# Maps the binary package name to the actual binary name
def rust_binary_mapper(f):
    if f == "du-dust":
        return "dust"
    if f == "fd-find":
        return "fd"
    if f == "git-delta":
        return "delta"
    if f == "ripgrep":
        return "rg"
    if f == "cargo-edit":
        return "cargo-add"
    return f


def exists_all(path, files):
    for f in files:
        if not exists(join(path, rust_binary_mapper(f))):
            return False
    return True


def install_brave_browser():
    if not exists("/etc/apt/sources.list.d/brave-browser-release.list"):
        call([
            "sudo", "curl", "-fsSLo", "/usr/share/keyrings/brave-browser-archive-keyring.gpg",
            "https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg"
        ])
        with open("/tmp/brave-browser-release.list", "w") as f:
            f.write(
                "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"
            )
        call(["sudo", "mv", "/tmp/brave-browser-release.list", "/etc/apt/sources.list.d/brave-browser-release.list"])
        call(["sudo", "apt-get", "update"])
        call(["sudo", "apt-get", "install", "-y", "brave-browser"])


def install_program(script_name, with_clean):
    if with_clean:
        system("python3 {} -b -c".format(script_name))
    else:
        system("python3 {} -b".format(script_name))


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
# Install packages only if needed
for pac in packages_to_install:
    if not apt_cache[pac].is_installed:
        print("Needs to install packages")
        call(["sudo", "apt-get", "install", "-y", *packages_to_install])
        break

if not check_dep_version.check_programs():
    print("Error: programs not correct versions")
    sys.exit(1)

if args.online:
    if not glob("/etc/apt/sources.list.d/kubuntu-ppa*.list"):
        call(["sudo", "add-apt-repository", "-y", "ppa:kubuntu-ppa/backports"])
    install_brave_browser()
    if not args.skip_all:
        if not args.skip_neovim:
            install_program("neovim.py", args.clean)
        if not args.skip_ccls:
            install_program("ccls.py", args.clean)
        if not args.skip_konsole:
            install_program("konsole.py", args.clean)
        if not args.skip_tmux:
            install_program("tmux.py", args.clean)

    packer_plugin = join(homefolder, ".local/share/nvim/site/pack/packer/start/packer.nvim")
    if not exists(packer_plugin):
        call(["git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", packer_plugin])
    call(["nvim", "-u", ".config/nvim/lua/plugins.lua", "--headless", "-c", "autocmd User PackerComplete quitall", "-c", "PackerSync"])
    coq_deps = join(packer_plugin, "../coq-nvim/.vars")
    if args.clean and exists(coq_deps):
        rmtree(coq_deps)
    if not exists(coq_deps):
        p = Popen(["python3", "-m", "coq", "deps"], cwd=realpath(join(coq_deps, "..")))
        p.wait()
    for lang in tree_sitter_languages:
        pass
        # call(["nvim", "-c", "TSInstallSync! {}".format(lang), "-c", "quitall"])

    for tmuxpath, tmuxurl in [(join(dotfilespath, "tmux-resurrect"), "https://github.com/tmux-plugins/tmux-resurrect"),
                              (join(dotfilespath, "tmux-continuum"), "https://github.com/tmux-plugins/tmux-continuum"),
                              (join(dotfilespath, "tmux-notify"), "https://github.com/ChanderG/tmux-notify")]:
        if exists(tmuxpath):
            call(["git", "-C", tmuxpath, "pull"])
        else:
            call(["git", "clone", tmuxurl, tmuxpath])

    call(["npm", "install", "--prefix", join(homefolder, ".local"), *nodejs_language_servers])
    makedirs(local_bin, exist_ok=True)

    # Download Marksman
    call(["wget", "-N", "-O", marksman_bin, "https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux"])
    os.chmod(marksman_bin, 0o755)
    # Download rust-analyzer
    call([
        "wget", "-P", "/tmp/",
        "https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz"
    ])
    call(["gunzip", "/tmp/rust-analyzer-x86_64-unknown-linux-gnu.gz"])
    move("/tmp/rust-analyzer-x86_64-unknown-linux-gnu", ra_bin)
    os.chmod(ra_bin, 0o755)
    # Download online resources
    call(["wget", "-N", "-O", bfg_jar, "https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar"])
    os.chmod(bfg_jar, 0o755)
    call(["wget", "-N", "-P", "bin", "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"])

    call(["python3", "-m", "pip", "install", "--upgrade", "python-lsp-server[rope,pyflakes,mccabe,pycodestyle,yapf]"])
    call(["python3", "-m", "pip", "install", "--upgrade", "greenlet"])
    call(["python3", "-m", "pip", "install", "--upgrade", "msgpack"])
    call(["python3", "-m", "pip", "install", "--upgrade", "pynvim"])

    if not args.skip_all and not args.skip_rust:
        ps = Popen(["curl", "--proto", "=https", "--tlsv1.2", "-sSf", "https://sh.rustup.rs"], stdout=PIPE)
        call(["sh", "-s", "--", "--default-toolchain", "none", "-y"], stdin=ps.stdout)
        ps.wait()
        call([rustup_bin, "update", "stable"])
        call([rustup_bin, "component", "add", "rustfmt"])
        call([rustup_bin, "component", "add", "rust-src"])
        call([rustup_bin, "component", "add", "clippy"])

        if exists_all(join(homefolder, ".cargo", "bin"), rust_binaries):
            call(["cargo", "install-update", "-ag"])
        else:
            call(["cargo", "install", *rust_binaries])
            call(["cargo", "install", "cargo-update"])

if args.font:
    call(["sudo", "unzip", "-o", join(dotfilespath, "bin", "Hack.zip"), "-d", "/usr/local/share/fonts/"])
    call(["fc-cache", "-f", "-v"])

if args.pack or args.artifactory:
    chdir(homefolder)
    call([
        "tar", r"--exclude=*/\.git", "-czf", "dotfiles.tar.gz", ".dotfiles/", "go/bin/", ".cargo/bin/", ".cargo/env", local_bin,
        ".local/node_modules", ".local/include", ".local/lib", ".local/share/nvim", ".local/share/konsole"
    ])
    print("")
    print(".dotfiles has been packed into " + join(homefolder, "dotfiles.tar.gz"))

    auth_file = join(homefolder, ".dotfiles", "auth.json")
    if args.artifactory:
        command = ["jfrog", "rt", "u", join(homefolder, "dotfiles.tar.gz"), "ace-generic-prod-se-blu-sync/u009893/dotfiles.tar.gz"]
        os.system(" ".join(command))

print("Finished: {}".format(datetime.now().strftime("%H:%M:%S")))
