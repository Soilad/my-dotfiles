import sqlite3
from sys import argv
from pathlib import Path


con = sqlite3.connect(str(Path.home()) + "/.config/eww/scripts/search.db")
cur = con.cursor()
cur.execute("SELECT * FROM apps WHERE appname=?", (argv[1],))
tmp = cur.fetchall()
print(tmp)
if tmp:
    print("yowza")
    cur.execute("UPDATE apps SET count=count+1 WHERE appname=?", (argv[1],))
else:
    print("new entry eh?")
    cur.execute("INSERT INTO apps VALUES (?, 1)", (argv[1],))
con.commit()
con.close()
