echo "Post-Uninstall"

dpkg-divert --package oc-sd-optimizations --rename --remove /etc/logrotate.d/rsyslog

systemctl restart cron.service
systemctl restart systemd-journald.service

# remove tmpfs from fstab
if grep -qF "oc-tmpfs-logs" /etc/fstab;
then
    cp /etc/fstab /tmp/fstab
    echo "$(sed '/#oc-tmpfs-logs/,+2 d' /tmp/fstab)" > /tmp/fstab
    mv /tmp/fstab /etc/fstab
fi

#
# Echo Reboot is required
echo "!--------------------------!"
echo "! Reboot is required !!!   !"
echo "! Please Reboot System !!! !"
echo "!--------------------------!"
