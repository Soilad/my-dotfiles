import subprocess
import re
import sys


def remove_ansi_colors(text):
    ansi_escape = re.compile(r"\x1B\[[0-?9;]*[mK]")
    return ansi_escape.sub("", text)


a = subprocess.check_output(["curl", "https://wttr.in/?T"], text=True)
print(
    [x[16::] for x in a[:400:].split("\n")][int(sys.argv[1])],
)
