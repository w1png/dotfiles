from os import popen
from typing import ValuesView

try:
    print("New updates: " + str(popen("dnf check-update").read().split("\n")[::-1][1:].index("")))
except ValueError:
    print("No new updates!")
except:
    print("Error in update-checker.py!")