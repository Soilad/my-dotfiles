from re import split
import subprocess

print(
    subprocess.run(["nmcli", "device", "wifi", "list"], capture_output=True, text=True)
    .stdout.split("*")[1][:90:]
    .split()[4]
)
