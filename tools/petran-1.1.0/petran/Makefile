#
# Makefile
#

CXX ?= g++ 
CXXFLAGS+=-Wall -Wno-deprecated
CXXFLAGS+=-I../inc -I../deflate

DEPS=\
	../inc/pe_defs.h \
	../inc/e32def.h \
	../inc/e32image.h \
	../inc/e32rom.h \
	../inc/e32std.h \
	../inc/e32uid.h \
	../inc/pe_file.h \
	../inc/h_utl.h \
	../inc/h_ver.h

OBJS=\
	petran.o \
	../e32uid/e32uid.o \
	../host/h_utl.o \
	../host/h_file.o \
	../host/h_mem.o \
	../pefile/pe_img.o \
	../pefile/pe_imp.o \
	../pefile/pe_dump.o \
	../pefile/pe_utl.o \
	../pefile/pe_io.o \
	../pefile/pe_tran.o \
	../pefile/pe_reloc.o \
	../pefile/pe_file.o \
	../deflate/compress.o \
	../deflate/decode.o \
	../deflate/deflate.o \
	../deflate/encode.o \
	../deflate/inflate.o \
	../deflate/panic.o

BIN=petran

all: $(BIN)

$(BIN): $(OBJS)
	$(CXX) $(LDFLAGS) $(OBJS) -o $@ $(LIBS)

%.o: %.cpp $(DEPS)
	$(CXX) $(CXXFLAGS) -c $< -o $@

install: $(BIN)
	install -m 755 $(BIN) $(DESTDIR)/usr/bin

uninstall:
	rm -f $(DESTDIR)/usr/bin/$(BIN)

clean:
	rm -f $(OBJS) $(BIN) core ../*/*~ ../*/*.o
