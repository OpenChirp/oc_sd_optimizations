echo "Pre-Install"
dpkg-divert --package oc-sd-optimizations --divert /etc/logrotate.d.rsyslog.old --rename /etc/logrotate.d/rsyslog
