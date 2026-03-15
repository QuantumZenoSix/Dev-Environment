# Update/upgrade
sudo apt update && sudo apt upgrade -y
# Install top 10 kali tolls (could also use katiloon)
sudo apt install kali-tools-top10 -y # Add more as needed here: https://www.kali.org/tools/kali-meta/


# Install Kali Desltop Manager (xfce) 
sudo apt install kali-desktop-xfce -y
# Install kex gui
sudo apt install kali-win-kex -y

# Start Kex (automatically)
# Windows Terminal - edit profile cmd (add kex --wtstart -s)
# C:\Windows\system32\wsl.exe -d kali-linux kex --wtstart -s


# Start Kex (manually) - run in home dir
# kex --win -s
# or...
# kex --win --wtstart

### TROUBLESHOOTING ###
# kill like 7 sed
# (If you are getting messages like "Actively refused" or "Trouble reading passwd file")
# mount -o remount rw /tmp/.X11-unix
# cd ; kex --win --wtstart
