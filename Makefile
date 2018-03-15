export DESTDIR ?=
export PREFIX ?= /usr/local
export CROSS_COMPILE =

export INCDIR ?= $(PREFIX)/include/audio_route
export LIBDIR ?= $(PREFIX)/lib
export BINDIR ?= $(PREFIX)/bin
export MANDIR ?= $(PREFIX)/share/man

CC = $(CROSS_COMPILE)gcc
AR = $(CROSS_COMPILE)ar
LD = $(CROSS_COMPILE)gcc

WARNINGS = -Wall -Wextra -Werror -Wfatal-errors
override CFLAGS := $(WARNINGS) $(INCLUDE_DIRS) -fPIC $(CFLAGS)

LIBS=-ltinyalsa -lexpat

OBJECTS = audio_route.o

.PHONY: all
all: libaudioroute.a libaudioroute.so

audio_route.o: audio_route.c

libaudioroute.a: $(OBJECTS)

libaudioroute.a: $(OBJECTS)
	$(AR) $(ARFLAGS) $@ $^

libaudioroute.so: libaudioroute.so.1
	ln -sf $< $@

libaudioroute.so.1: libaudioroute.so.1.1.1
	ln -sf $< $@

libaudioroute.so.1.1.1: $(OBJECTS)
	$(LD) $(LIBS) $(LDFLAGS) -shared -Wl,-soname,libaudioroute.so.1 $^ -o $@


.PHONY: clean
clean:
	rm -f libaudioroute.a
	rm -f libaudioroute.so
	rm -f libaudioroute.so.1
	rm -f libaudioroute.so.1.1.1
	rm -f $(OBJECTS)

.PHONY: install
install: libaudioroute.a libaudioroute.so.1
	install -d $(DESTDIR)$(LIBDIR)/
	install libaudioroute.a $(DESTDIR)$(LIBDIR)/
	install libaudioroute.so.1.1.1 $(DESTDIR)$(LIBDIR)/
	ln -sf libaudioroute.so.1.1.1 $(DESTDIR)$(LIBDIR)/libaudioroute.so.1
	ln -sf libaudioroute.so.1 $(DESTDIR)$(LIBDIR)/libaudioroute.so
	install -d $(DESTDIR)$(INCDIR)/
	install include/audio_route/audio_route.h $(DESTDIR)$(INCDIR)/

