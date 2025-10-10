import re
import semver
from subprocess import run

semver_re = re.compile(
    r'(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)(?:-((?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*)(?:\.(?:0|[1-9]\d*|\d*[a-zA-Z-][0-9a-zA-Z-]*))*))?(?:\+([0-9a-zA-Z-]+(?:\.[0-9a-zA-Z-]+)*))?'
)


def program_is_at_least(command, min_version):
    if type(command) == str:
        command = command.split(" ")
    try:
        version_text = run(command, capture_output=True).stdout.decode("utf-8")
    except OSError:
        print("Error: Running command \"{}\"".format(" ".join(command)))
        return False
    current_version = semver_re.findall(version_text)
    if len(current_version) < 1:
        print("Did not find a semver version in: {}".format(version_text))
        return False
    current_version = ".".join(current_version[0][:3])
    return semver.compare(current_version, min_version) >= 0


def check_programs():
    golangver = "1.18.5"
    nodever = "16.0.0"
    is_ok = True
    if not program_is_at_least("go version", golangver):
        print("Bad version of Golang, need at least version {}".format(golangver))
        print("Get latest version at https://go.dev/dl")
        is_ok = False
    if not program_is_at_least("node --version", nodever):
        print("Bad version of Node, need at least version {}".format(nodever))
        print("Get latest version at https://nodejs.org/en/download")
        is_ok = False
    return is_ok
