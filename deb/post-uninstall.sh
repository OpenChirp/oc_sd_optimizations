dpkg-divert --package oc-sd-optimizations --remove --rename /etc/logrotate.d/rsyslog
systemctl restart cron.service
