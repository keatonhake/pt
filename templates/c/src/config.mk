# {{:project}} version
VERSION = 0.1.0

# paths
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man


# includes and libs
INCS =
LIBS =

# flags
CPPFLAGS = -D_DEFAULT_SOURCE -DVERSION=\"$(VERSION)\"
CFLAGS   = -std=c99 -pedantic -Wall -Os $(INCS) $(CPPFLAGS)
LDFLAGS  = $(LIBS)

# compiler and linker
CC = cc
