INSTALL     := install
prefix      := /usr/local
exec_prefix := $(prefix)
sbindir     := $(exec_prefix)/sbin
datarootdir := $(prefix)/share
mandir      := $(datarootdir)/man
man5dir     := $(mandir)/man5
man8dir     := $(mandir)/man8
docdir      := $(datarootdir)/doc/vaiopower

ifeq ($(prefix), /usr/local)
  sysconfdir := $(prefix)/etc
else
  sysconfdir := /etc
endif

UDEVDIR     := /etc/udev/rules.d
SLEEPDIR    := /etc/pm/sleep.d
BASHCOMPDIR := /etc/bash_completion.d

all:
copy-exec:
	$(INSTALL) -d $(DESTDIR)$(sbindir)
	$(INSTALL) vaiopower $(DESTDIR)$(sbindir)
copy-conf:
	$(INSTALL) -d $(DESTDIR)$(sysconfdir)
	$(INSTALL) -m 0644 etc/vaiopower.conf $(DESTDIR)$(sysconfdir)
copy-udev:
	$(INSTALL) -d $(DESTDIR)$(UDEVDIR)
	$(INSTALL) -m 0644 85-vaiopower.rules.in $(DESTDIR)$(UDEVDIR)/85-vaiopower.rules
	sed -i -e 's;###SBINDIR###;$(sbindir);' $(DESTDIR)$(UDEVDIR)/85-vaiopower.rules
copy-sleep:
	$(INSTALL) -d $(DESTDIR)$(SLEEPDIR)
	$(INSTALL) sleep/vaiopower.in $(DESTDIR)$(SLEEPDIR)/vaiopower
	sed -i -e 's;###SBINDIR###;$(sbindir);' $(DESTDIR)$(SLEEPDIR)/vaiopower
copy-bash:
	$(INSTALL) -d $(DESTDIR)$(BASHCOMPDIR)
	$(INSTALL) -m 0644 bash-completion/vaiopower $(DESTDIR)$(BASHCOMPDIR)
copy-man:
	$(INSTALL) -d $(DESTDIR)$(man5dir)
	$(INSTALL) -d $(DESTDIR)$(man8dir)
	$(INSTALL) -m 0644 man/vaiopower*.5 $(DESTDIR)$(man5dir)
	$(INSTALL) -m 0644 man/vaiopower*.8 $(DESTDIR)$(man8dir)
copy-doc:
	$(INSTALL) -d $(DESTDIR)$(docdir)
	$(INSTALL) -m 0644 README $(DESTDIR)$(docdir)
copy: copy-exec copy-conf copy-sleep copy-bash copy-man copy-doc
install: copy copy-udev
clean:
distclean:
uninstall:
	rm -f $(DESTDIR)$(sbindir)/vaiopower
	rm -f $(DESTDIR)$(man5dir)/vaiopower*.5
	rm -f $(DESTDIR)$(man8dir)/vaiopower*.8
	rm -rf $(DESTDIR)$(docdir)
	rm -f $(DESTDIR)$(UDEVDIR)/85-vaiopower.rules
	rm -f $(DESTDIR)$(SLEEPDIR)/vaiopower
	rm -f $(DESTDIR)$(BASHCOMPDIR)/vaiopower
purge: uninstall
	rm -f $(DESTDIR)$(sysconfdir)/vaiopower.conf

.PHONY: all copy-exec copy-conf copy-udev copy-sleep copy-bash copy-man \
        copy-doc copy install clean distclean uninstall purge
