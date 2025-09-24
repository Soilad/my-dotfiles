import subprocess

a = subprocess.check_output(
    ["xprop", "-root", "-notype", "_NET_CURRENT_DESKTOP"], text=True
)[-2]
ps = subprocess.Popen(["wmctrl", "-l"], stdout=subprocess.PIPE)
b = subprocess.check_output(
    ["cut", "-d", " ", "-s", "-f", "3"], stdin=ps.stdout
).decode("utf-8")

if a in b:
    subprocess.Popen(
        [
            "eww",
            "open",
            "time",
        ],
    )
    subprocess.Popen(["eww", "close", "clock"])
else:
    subprocess.Popen(
        [
            "eww",
            "open",
            "clock",
        ],
    )
    subprocess.Popen(["eww", "close", "time"])
print("a")
