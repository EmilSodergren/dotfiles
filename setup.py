from os import chdir, system

from subprocess import run, Popen, PIPE, TimeoutExpired
from argparse import ArgumentParser
from datetime import datetime
from glob import glob
from shutil import move, copy2
from pathlib import Path
import json
import platform
import re
import apt
import os
import sys

dotfilespath = Path().resolve()
local_bin = Path(".local") / "bin"
host_local_bin = Path.home() / local_bin
bfg_jar = host_local_bin / "bfg.jar"
marksman_bin = host_local_bin / "marksman"
ra_bin = host_local_bin / "rust-analyzer"
hado_bin = host_local_bin / "hadolint"
antiword = local_bin / "antiword"
ccls_config = local_bin / "ccls_config"
forgit = local_bin / "forgit"
write_notes = local_bin / "write_notes"
konsole_config = Path(".local") / "share" / "konsole" / "Emil.profile"
neovim_init = Path(".config") / "nvim"
pycodestyle_config = Path(".config") / "pycodestyle"
yapf_config = Path(".config") / "yapf" / "style"
kwalletrc = Path.home() / ".config" / "kwalletrc"
yarn_packages = [
    "yaml-language-server", "dockerfile-language-server-nodejs", "bash-language-server", "neovim", "vscode-langservers-extracted",
    "ansible/ansible-language-server", "markdownlint-cli2"
]
settingsfiles = [
    ".bash_completion", ".bash_completion.d", ".bash_git", ".bashrc", ".gitconfig", ".golangci.yaml", ".profile", ".hadolint.yaml",
    ".tmux.conf", antiword, ccls_config, forgit, konsole_config, neovim_init, pycodestyle_config, write_notes, yapf_config
]
tree_sitter_languages = [
    "bash",
    "c",
    "comment",
    "csv",
    "diff",
    "dockerfile",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "jsonc",
    "lua",
    "luadoc",
    "luap",
    "make",
    "markdown",
    "markdown_inline",
    "printf",
    "python",
    "query",
    "regex",
    "rust",
    "sql",
    "tmux",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "xml",
    "yaml",
]
rustup_bin = Path.home() / ".cargo/bin/rustup"
rust_binaries = [
    "bat", "cargo-watch", "cargo-edit", "cargo-update", "du-dust", "fd-find", "git-delta", "lsd", "ripgrep", "sd", "tokei", "watchexec-cli",
    "ytop", "zoxide"
]
packages_to_install = [
    "antiword",
    "apt-transport-https",
    "bash-completion",
    "curl",
    "docx2txt",
    "flameshot",
    "fonts-powerline",
    "fswatch",
    "gawk",
    "git",
    "libclang-dev",
    "liblz4-tool",
    "libssl-dev",
    "libxml2-utils",
    "make",
    "python3-jedi",
    "python3-pip",
    "python3-semver",
    "python3-venv",
    "shellcheck",
    "software-properties-common",
    "ssh-askpass",
    "vim-nox",
    "xclip",
]
packages_to_install_wayland = ["wl-clipboard"]

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
    if f == "cargo-update":
        return "cargo-install-update"
    return f


def exists_all(path, files):
    for f in files:
        if not (path / rust_binary_mapper(f)).exists():
            return False
    return True


def install_brave_browser():
    if not Path("/etc/apt/sources.list.d/brave-browser-release.list").exists():
        keyring = "/usr/share/keyrings/brave-browser-archive-keyring.gpg"
        run(["sudo", "curl", "-fsSLo", keyring, "https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg"])
        Path("/tmp/brave-browser-release.list").write_text(
            f"deb [signed-by={keyring} arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main")
        run(["sudo", "mv", "/tmp/brave-browser-release.list", "/etc/apt/sources.list.d/brave-browser-release.list"])
        run(["sudo", "apt-get", "update"])
        run(["sudo", "apt-get", "install", "-y", "brave-browser"])


def install_program(script_name, with_clean):
    if with_clean:
        system("python3 {} -b -c".format(script_name))
    else:
        system("python3 {} -b".format(script_name))


# To minimize the footprint the tmux-thumbs is built
def install_tmux_thumbs(install_path, url):
    build_path = Path.home() / ".cargo" / "src" / "tmux-thumbs"
    if build_path.exists():
        run(["git", "pull"], cwd=build_path)
    else:
        build_path.mkdir(parents=True, exist_ok=True)
        run(["git", "clone", url], cwd=build_path.parent)
    run(["cargo", "build", "--release"], cwd=build_path)
    # Install binaries
    (install_path / "target" / "release").mkdir(parents=True, exist_ok=True)
    for file in ["Cargo.toml", "tmux-thumbs.tmux", "tmux-thumbs.sh", "target/release/thumbs", "target/release/tmux-thumbs"]:
        copy2(build_path / file, install_path / file)


for stuff in settingsfiles:
    linkpath = Path.home() / stuff
    sourcepath = dotfilespath / stuff
    if linkpath.is_symlink():
        linkpath.unlink()
    if not linkpath.parent.exists():
        linkpath.parent.mkdir(exist_ok=True)
    linkpath.symlink_to(sourcepath)

gitconfig_path = dotfilespath / ".gitconfig"
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

if kwalletrc.exists() and "Enabled=false" not in kwalletrc.read_text():
    kwalletrc.write_text("Enabled=false")

# Install good stuff, and nodejs
# Install packages only if needed
for pac in packages_to_install:
    if not apt_cache.has_key(pac):
        print("Needs to install packages")
        run(["sudo", "apt-get", "install", "-y", *packages_to_install])
        break

if os.environ.get("XDG_SESSION_TYPE") == "wayland":
    for pac in packages_to_install_wayland:
        if not apt_cache.has_key(pac):
            print("Needs to install packages")
            run(["sudo", "apt-get", "install", "-y", *packages_to_install_wayland])
            break

import check_dep_version
if not check_dep_version.check_programs():
    print("Error: programs not correct versions")
    sys.exit(1)

if args.online:
    if not glob("/etc/apt/sources.list.d/kubuntu-ppa*.list"):
        run(["sudo", "add-apt-repository", "-y", "ppa:kubuntu-ppa/backports"])
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

    run(["go", "install", "github.com/nametake/golangci-lint-langserver@latest"])
    run(["go", "install", "golang.org/x/tools/cmd/godoc@latest"])

    for tmuxpath, tmuxurl in [
        (dotfilespath / "tmux-resurrect", "https://github.com/tmux-plugins/tmux-resurrect"),
        (dotfilespath / "tmux-continuum", "https://github.com/tmux-plugins/tmux-continuum"),
        (dotfilespath / "tmux-cowboy", "https://github.com/tmux-plugins/tmux-cowboy"),
        (dotfilespath / "tmux-ssh-split", "https://github.com/pschmitt/tmux-ssh-split"),
        (dotfilespath / "tmux-notify", "https://github.com/rickstaa/tmux-notify"),
        (dotfilespath / "tmux-power", "https://github.com/wfxr/tmux-power"),
            # Tmux Thumbs installed futher down
    ]:
        if tmuxpath.exists():
            run(["git", "-C", tmuxpath, "pull"])
        else:
            run(["git", "clone", "--recursive", tmuxurl, tmuxpath])

    run(["npm", "install", "--prefix", Path.home() / ".local", "yarn"])
    yarn_bin = Path.home() / ".local" / "node_modules" / "yarn" / "bin" / "yarn"
    # Remove and add to get latest versions, ugly but works
    run([yarn_bin, "remove", *yarn_packages], cwd=Path.home() / ".local")
    run([yarn_bin, "add", *yarn_packages], cwd=Path.home() / ".local")
    markdownlint_cli2 = host_local_bin / "markdownlint-cli2"
    if markdownlint_cli2.is_symlink():
        markdownlint_cli2.unlink()
    markdownlint_cli2.symlink_to(Path.home() / ".local" / "node_modules" / "markdownlint-cli2" / "markdownlint-cli2-bin.mjs")

    (Path.home() / local_bin).mkdir(exist_ok=True)
    # Download Marksman
    run(["wget", "-N", "-O", marksman_bin, "https://github.com/artempyanykh/marksman/releases/latest/download/marksman-linux-x64"])
    os.chmod(marksman_bin, 0o755)
    # Download rust-analyzer
    run([
        "wget", "-P", "/tmp/",
        "https://github.com/rust-lang/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz"
    ])
    run(["gunzip", "/tmp/rust-analyzer-x86_64-unknown-linux-gnu.gz"])
    move("/tmp/rust-analyzer-x86_64-unknown-linux-gnu", ra_bin)
    os.chmod(ra_bin, 0o755)
    # Download Lua LS
    ps = Popen(['curl', 'https://api.github.com/repos/LuaLS/lua-language-server/releases/latest'], stdout=PIPE)
    latest_lua_version = json.load(ps.stdout).get('name')
    ps.wait()
    lua_tar_name = f'lua-language-server-{latest_lua_version}-linux-x64.tar.gz'
    luals_dl_url = f'https://github.com/LuaLS/lua-language-server/releases/download/{latest_lua_version}/{lua_tar_name}'
    lua_install_dir = Path.home() / '.local' / 'lib' / 'lua-language-server'
    run(['wget', '-P', '/tmp/', luals_dl_url])

    lua_install_dir.mkdir(parents=True, exist_ok=True)
    run(['tar', 'zxf', Path('/tmp/') / lua_tar_name], cwd=lua_install_dir)
    os.remove(Path('/tmp/') / lua_tar_name)
    lua_linkpath = host_local_bin / 'lua-language-server'
    if lua_linkpath.is_symlink():
        lua_linkpath.unlink()
    lua_linkpath.symlink_to(lua_install_dir / 'bin' / 'lua-language-server')

    # Download hadolint
    hadolint_url = 'https://github.com/hadolint/hadolint/releases/latest/download/hadolint-Linux-x86_64'
    run(['wget', '-P', '/tmp/', hadolint_url])
    move("/tmp/hadolint-Linux-x86_64", hado_bin)
    os.chmod(hado_bin, 0o755)

    # Download bfg.jar
    run(["wget", "-O", bfg_jar, "https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar"])
    os.chmod(bfg_jar, 0o755)
    # Download Hack font zip file
    run(["wget", "-N", "-P", "bin", "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"])

    import semver
    extra_pip_flags = ["--user", "--break-system-packages"]
    # For python version older than 3.11
    if semver.compare(platform.python_version(), "3.11.0") == -1:
        extra_pip_flags = []
    run([
        "python3", "-m", "pip", "install", "--force-reinstall", "--upgrade", *extra_pip_flags,
        "python-lsp-server[rope,pyflakes,mccabe,pycodestyle,yapf]"
    ])
    run(["python3", "-m", "pip", "install", "--force-reinstall", "--upgrade", *extra_pip_flags, "greenlet"])
    run(["python3", "-m", "pip", "install", "--force-reinstall", "--upgrade", *extra_pip_flags, "msgpack"])
    run(["python3", "-m", "pip", "install", "--force-reinstall", "--upgrade", *extra_pip_flags, "pynvim"])

    if not args.skip_all and not args.skip_rust:
        ps = Popen(["curl", "--proto", "=https", "--tlsv1.2", "-sSf", "https://sh.rustup.rs"], stdout=PIPE)
        run(["sh", "-s", "--", "--default-toolchain", "none", "-y"], stdin=ps.stdout)
        ps.wait()
        run([rustup_bin, "update", "stable"])
        run([rustup_bin, "component", "add", "rustfmt"])
        run([rustup_bin, "component", "add", "rust-src"])
        run([rustup_bin, "component", "add", "clippy"])

        if exists_all(Path.home() / ".cargo" / "bin", rust_binaries):
            run(["cargo", "install-update", "-ag"])
        else:
            run(["cargo", "install", *rust_binaries])
            run(["cargo", "install", "cargo-update"])
    # Fix tmux-thumbs
    install_tmux_thumbs(dotfilespath / "tmux-thumbs", "https://github.com/fcsonline/tmux-thumbs"),
    run(["nvim", "-u", neovim_init / "init.lua", "-c", "quitall"])
    run(["nvim", "-u", neovim_init / "init.lua", "--headless", "-c", "Lazy! install", "-c", "quitall"])
    run(["nvim", "--headless", "-c", "Lazy! sync", "-c", "quitall"])
    for lang in tree_sitter_languages:
        run(["nvim", "--headless", "-c", f"TSInstallSync! {lang}", "-c", "quitall"])
    try:
        run(["nvim"], timeout=10)
    except TimeoutExpired:
        run(["reset"], shell=True)
        pass

if args.font:
    run(["sudo", "unzip", "-o", dotfilespath / "bin" / "Hack.zip", "-d", "/usr/local/share/fonts/"])
    run(["fc-cache", "-f", "-v"])

if args.pack or args.artifactory:
    chdir(Path.home())
    run([
        "tar", r"--exclude=*/\.git", "-czf", "dotfiles.tar.gz", ".dotfiles/", "go/bin/", ".cargo/bin/", ".cargo/env", local_bin,
        ".local/node_modules", ".local/include", ".local/lib", ".local/share/nvim", ".local/share/konsole", "konsole", ".fzf.bash"
    ])
    print("")
    print(".dotfiles has been packed into " + str(Path.home() / "dotfiles.tar.gz"))

    if args.artifactory:
        command = ["jfrog", "rt", "u", str(Path.home() / "dotfiles.tar.gz"), "ace-generic-prod-se-blu-sync/u009893/dotfiles.tar.gz"]
        os.system(" ".join(command))

print("Finished: {}".format(datetime.now().strftime("%Y-%m-%d %H:%M:%S")))
