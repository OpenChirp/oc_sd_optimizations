systemctl restart systemd-journald.service
rm -rf /var/log/journal/

# Clean Old Logs to minimize space
find /var/log -name \*.gz -type f -print0  | xargs -0 rm -f
find /var/log -name \*.xz -type f -print0  | xargs -0 rm -f
find /var/log -name \*.1 -type f -print0  | xargs -0 rm -f
for filename in $(find /var/log -type f -print);
do
    truncate -s 0 "$filename"
done

# Add tmpfs to fstab
if grep -qF "oc-tmpfs-logs" /etc/fstab;
then
   echo ""
else
    cp /etc/fstab /tmp/fstab
    echo "#oc-tmpfs-logs" >> /tmp/fstab
    echo "tmpfs /var/log tmpfs defaults,size=250M,noatime,nosuid,nodev,noexec,mode=0755 0 0" >> /tmp/fstab
    echo "tmpfs /tmp tmpfs defaults,size=150M,noatime,nosuid,nodev,noexec,mode=1777 0 0" >> /tmp/fstab
    mv /tmp/fstab /etc/fstab
fi

# Mount the tmpfs for /var/log
mount -a

# Create temp files in /var/log
systemd-tmpfiles --create


systemctl restart cron.service
