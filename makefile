VERSION = 0.1.0

PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

.MAIN: default

default:
	@echo 'thanks for choosing pt.'
	@echo 'pt is a simple tool for template based project initializing.'
	@echo 'please edit the makefile to your liking then `make install`.'


install:
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f pt.sh $(DESTDIR)$(PREFIX)/bin/pt
	chmod 755 $(DESTDIR)$(PREFIX)/bin/pt
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	cp -f pt.1 $(DESTDIR)$(MANPREFIX)/man1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/pt.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/pt \
		$(DESTDIR)$(MANPREFIX)/man1/pt.1

.PHONY: default install uninstall
