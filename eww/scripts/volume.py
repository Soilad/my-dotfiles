import sys
import subprocess

match sys.argv[2]:
    case "up":
        subprocess.run(
            [
                "pactl",
                f"set-{sys.argv[1]}-volume",
                f"@DEFAULT_{sys.argv[1].upper()}@",
                "+5%",
            ]
        )
    case "down":
        subprocess.run(
            [
                "pactl",
                f"set-{sys.argv[1]}-volume",
                f"@DEFAULT_{sys.argv[1].upper()}@",
                "-5%",
            ]
        )
