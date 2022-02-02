from os import popen
import platform

LINUX_DISTRO = platform.freedesktop_os_release()["ID"]

if LINUX_DISTRO == "arch":
    update_amount = popen("checkupdates | wc -l").read()
    print("No new updates!" if update_amount == 0 else ("New updates: " + str(update_amount)))

elif LINUX_DISTRO == "fedora":
    try:
        print("New updates: " + str(popen("dnf check-update").read().split("\n")[::-1][1:].index("")))
    except ValueError:
        print("No new updates!")
    except:
        print("Error in update-checker.py!")
else:
    print("Unknown linux distribution :(")