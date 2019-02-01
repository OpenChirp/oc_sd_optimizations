NAME=oc-sd-optimizations
VERSION=0.02
MAINTAINER='Artur Balanuta'
DEPS := rsyslog
WORK_DIR=src
ARCH=all

DESCRIPTION='OpenChirp.io SD card Optimizations'

POSTINSTALL_SCRIPT=deb/post-install.sh
PREINSTALL_SCRIPT=deb/pre-install.sh
POSTUNINSTALL_SCRIPT=deb/post-uninstall.sh

COMMON_FPM_ARGS=\
	--log error \
	-C $(WORK_DIR) \
	--name $(NAME) \
	--version $(VERSION) \
	--maintainer $(MAINTAINER) \
	--description $(DESCRIPTION) \
	--config-files /etc/cron.d/00-oc-logrotate \
	--config-files /etc/logrotate.d/rsyslog \
	--config-files /etc/systemd/journald.conf.d/00-oc-journal.conf \
	--config-files /etc/tmpfiles.d/oc-logs.conf \
	--after-install $(POSTINSTALL_SCRIPT) \
	--before-install $(PREINSTALL_SCRIPT) \
	--after-remove $(POSTUNINSTALL_SCRIPT) \
	--verbose



.PHONY: package
package:
	fpm -s dir -t deb -a $(ARCH) $(COMMON_FPM_ARGS) $(foreach dep,$(DEPS),-d $(dep))
	mv $(NAME)_$(VERSION)_*.deb build/
