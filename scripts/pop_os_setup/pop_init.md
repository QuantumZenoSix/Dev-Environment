# Setup


## Install Core Packages and cli/shell tools
```bash
sh -c "$(wget https://raw.githubusercontent.com/QuantumZenoSix/Dev-Environment/refs/heads/main/init.sh -O -)"
```

<br />

## Install core desktop packages
```bash
bash ./pop_os_setup/core.sh
```

<br />

## Installing gaming apps and dependencies
```bash
bash ./pop_os_setup/gaming.sh
```

<br />

## OS housekeeping
```bash
bash ./pop_os_setup/housekeeping.sh
```

<br />

## Brightness Issues  
See `./pop_os_setup/pop-os-brightness-fix.sh`

<br />

# Troubleshooting and configuration

## Power Management & Charge Limit

```bash
sudo apt install tlp tlp-rdw
sudo tlp start
sudo systemctl enable tlp
sudo tlp-stat -b          # checks if it's working
sudo tlp setcharge 80 85  # Set charge (min/max)
```  

<br />

Update conf
```
sudo nano /etc/tlp.conf
```  

<br />

Add/edit these lines
```
START_CHARGE_THRESH_BAT0=0
STOP_CHARGE_THRESH_BAT0=1
```

<br />

Save and run again
```
sudo tlp start
```


---
## SSD/NVMe Healthcheck
```
sudo apt install smartmontools
smartctl -a /dev/nvme0n1
```

<br />

Check 'Percentage Used'

---

## Windows Applications and their linux alertnatives.  


### Work
- MySql Workbench (flatpak)
- S3 Browser (cyberduck)
- Mremote (remmina)
- WinSCP (remmina)
- VNC  (remmina)
- OneDrive (browser)
- Teams (browser)
- Zoom (.deb)
- Sql Server (Azure Data Studio / .deb)


### Other
- Dolphin Emulator (flatpak)
- VirtualBox (apt virtualbox | or just use Virt-Manager, it's faster and runs better on linux)
- Davinci Resolve (Grab it from Blackmagic's site, follow System76's article)
- ShareX (Windows-only| flameshot + https://github.com/SeaDve/Kooha)
- Docker Desktop: [link](https://docs.docker.com/desktop/setup/install/linux/ubuntu/)




