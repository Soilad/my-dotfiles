import os
import subprocess
import sys

apps = sorted(
    [
        x
        for x in (os.listdir("/bin") + os.listdir("/home/soi/.local/bin"))
        if x.startswith(sys.argv[1])
    ],
    key=len,
)
files = subprocess.run(
    ["find", "/home/soi/", "-iname", f"*{sys.argv[1]}*"], stdout=subprocess.PIPE
).stdout
print(
    *[(x.split("/")[-1], x) for x in files.decode("utf-8").split("\n")],
    sep="\n",
)
