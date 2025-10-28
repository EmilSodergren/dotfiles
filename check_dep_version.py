import re
from subprocess import run
import semver

semver_re = re.compile(
    r'(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?'
)


def get_kernel_version_string():
    semver_string = run(["uname", "-r"], capture_output=True, check=True).stdout.decode("utf-8")
    a = semver.VersionInfo.parse(semver_string)
    return f"{a.major}.{a.minor}.{a.patch}"


def version_is_at_least(version_str, min_version):
    current_version = semver_re.findall(version_str)
    if len(current_version) < 1:
        print(f"Did not find a semver version in: {version_str}")
        return False
    current_version = ".".join(current_version[0][:3])
    try:
        a = semver.VersionInfo.parse(current_version)
        b = semver.VersionInfo.parse(min_version)
        return a >= b
    except ValueError:
        print(f"Did not find a semver version in: {version_str} or in: {min_version}")
        return False


def program_is_at_least(command, min_version):
    if isinstance(command, str):
        command = command.split(" ")
    try:
        version_text = run(command, capture_output=True, check=True).stdout.decode("utf-8")
    except OSError:
        print(f'Error: Running command "{" ".join(command)}"')
        return False
    return version_is_at_least(version_text, min_version)


def check_programs():
    golangver = "1.23.0"
    nodever = "22.0.0"
    is_ok = True
    if not program_is_at_least("go version", golangver):
        print(f"Bad version of Golang, need at least version {golangver}")
        print("Get latest version at https://go.dev/dl")
        is_ok = False
    if not program_is_at_least("node --version", nodever):
        print(f"Bad version of Node, need at least version {nodever}")
        print("Get latest version at https://nodejs.org/en/download")
        is_ok = False
    return is_ok
