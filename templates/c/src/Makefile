# {{:project}} 
# See LICENSE file for copyright and license details.

include config.mk

SRC = {{:project}}.c
OBJ = $(SRC:.c=.o)

all: options {{:project}}

options:
	@echo {{:project}} build options:
	@echo "CFLAGS   = $(CFLAGS)"
	@echo "LDFLAGS  = $(LDFLAGS)"
	@echo "CC       = $(CC)"

.c.o:
	$(CC) -c $(CFLAGS) $<

config.h:
	cp config.def.h $@

$(OBJ): config.h

{{:project}}: ${OBJ}
	$(CC) -o $@ $^ $(LDFLAGS)

clean:
	rm -f {{:project}} ${OBJ}


install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f dmenu dmenu_path dmenu_run stest $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/dmenu
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < {{:project}}.1 > $(DESTDIR)$(MANPREFIX)/man1/{{:project}}.1

	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/{{:project}}.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/{{:project}}
		$(DESTDIR)$(MANPREFIX)/man1/{{:project}}.1

.PHONY: all options clean install uninstall {{:project}}
