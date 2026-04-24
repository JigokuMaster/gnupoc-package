#
# Makefile
#

#GCC_VERSION=-2.95
CC ?= gcc
CXX ?= g++
CFLAGS+=-I../include -Wall
#CFLAGS+=-D_UNICODE -DUNICODE
CFLAGS+=-DTEST -ggdb
CXXFLAGS+=-std=c++98 $(CFLAGS)


#LDFLAGS=
LIBS=-lz -lcrypto -ldl
OBJS=\
	crtsis.o \
	makesis.o \
	parsecmd.o \
	parsepkg.o \
	utf8.o \
	utils.o \
	stub.o \
	wcstub.o \
	signutils.o \
	sisfilegen.o \
	crc.o \
	sisfield.o

BIN=makesis signsis makekeys
DEVTOOLS=finddatetime dumpcontroller dumptree

all: $(BIN)

devtools: finddatetime dumpcontroller dumptree

makesis: $(OBJS) Makefile
	$(CXX) $(LDFLAGS) $(OBJS) -o $@ $(LIBS)

signsis: signsis.o crc.o signutils.o sisfield.o
	$(CXX) $(LDFLAGS) $+ -o $@ $(LIBS)

finddatetime: finddatetime.o sisfield.o
	$(CXX) -o $@ $+ $(LDFLAGS) $(LIBS)

dumpcontroller: dumpcontroller.o sisfield.o
	$(CXX) -o $@ $+ $(LDFLAGS) $(LIBS)

dumptree: dumptree.o sisfield.o
	$(CXX) -o $@ $+ $(LDFLAGS) $(LIBS)

%.o: %.cpp crtsis.h makesis.h parsecmd.h parsepkg.h utf8.h utils.h \
	../include/windows.h ../include/tchar.h
	$(CXX) $(CXXFLAGS) -c $< -o $@

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

install: $(BIN)
	install -m 755 $(BIN) $(DESTDIR)/usr/bin

uninstall:
	rm -f $(DESTDIR)/usr/bin/$(BIN)

clean:
	rm -f *.o $(BIN) $(DEVTOOLS) core
