VERSION = 0.1.0

#PREFIX = /usr/local
PREFIX = $(HOME)/.local
MANPREFIX = $(PREFIX)/share/man
TEMPLATES := $(PREFIX)/share/pt/templates

.MAIN: default

default:
	@echo 'thanks for choosing pt.'
	@echo 'pt is a simple tool for template based project initializing.'
	@echo 'please edit the makefile to your liking then `make install`.'

check:
	shellcheck pt.sh


install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f pt.sh $(DESTDIR)$(PREFIX)/bin/pt
	sed -i 's|{{:templates}}|$(DESTDIR)$(TEMPLATES)|g' $(DESTDIR)$(PREFIX)/bin/pt
	chmod 755 $(DESTDIR)$(PREFIX)/bin/pt
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f pt.1 $(DESTDIR)$(MANPREFIX)/man1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/pt.1
	mkdir -p $(DESTDIR)$(PREFIX)/share/pt
	cp -fr templates $(DESTDIR)$(PREFIX)/share/pt
	chmod -R u=rwX,go=rX $(DESTDIR)$(PREFIX)/share/pt


uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/pt \
		$(DESTDIR)$(MANPREFIX)/man1/pt.1
	rm -rf $(DESTDIR)$(PREFIX)/share/pt

.PHONY: default install uninstall check
