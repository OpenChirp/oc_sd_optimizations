# oc_sd_optimizations

* More strict log file size limitations to be able to fit in RAM
* Log Rotation every 5 minutes
* Systemd Journaling logging is done in RAM
* Removes old logs from the unmounted subdirectory
* /var/logs files are volatile
* Creates tmpfiles logs on boot to avoid problems with /var/log/ in RAM

## Install Procedure

```bash
curl -s https://api.github.com/repos/OpenChirp/oc_sd_optimizations/releases/latest \
| grep "browser_download_url.*deb" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -i -

sudo dpkg --purge oc-sd-optimizations
sudo dpkg -i oc-sd-optimizations*.deb

rm oc-sd-optimizations_*.deb

sudo reboot
```


## Removing 
```bash
dpkg --purge oc-sd-optimizations
```

