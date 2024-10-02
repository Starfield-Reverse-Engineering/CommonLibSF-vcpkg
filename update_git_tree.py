from json import dumps, load
from subprocess import run

# Update CLibNG git-tree
clib_git_tree = run(
    ["git", "rev-parse", "HEAD:ports/commonlibsf"], capture_output=True
).stdout.decode()

with open("./versions/c-/commonlibsf.json") as f:
    version = load(f)

version["versions"][0]["git-tree"] = clib_git_tree.strip("\n")

version_str = dumps(version, indent=2)
version_str += "\n"

with open("./versions/c-/commonlibsf.json", "w", newline="\r\n") as f:
    f.write(version_str)
