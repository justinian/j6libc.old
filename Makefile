CC  := clang
CXX := clang++
LD  := ld.lld
PREFIX ?= /tmp/poplibc/

# This is a list of all non-source files that are part of the distribution.
AUXFILES := Makefile Readme.txt

# Directories belonging to the project
PROJDIRS := functions include popcorn
# Directory where binaries should be written
BUILDDIR ?= build

# All source files of the project
SRCS := $(shell find -L ${PROJDIRS} -type f -name "*.c")
# All header files of the project
HEADERS := $(shell find -L include -type f -name "*.h")
POPHEADERS := $(shell find -L popcorn/include -type f -name "*.h")

OBJS := $(patsubst %.c,${BUILDDIR}/%.o,${SRCS})
TSTSRCS := $(shell find -L tests -type f -name "*.c")
TSTOBJS := $(patsubst %.c,${BUILDDIR}/%.o,${TSTSRCS})
TSTOBJS += $(patsubst %.c,${BUILDDIR}/%_testing.o,${SRCS})

DEPS := $(patsubst %.c,${BUILDDIR}/%.d,${SRCS})
TSTDEPS := $(patsubst %.c,${BUILDDIR}/%.d,${TSTSRCS})

WARNINGS := -Werror -Wall -Wextra -pedantic -Wno-unused-parameter -Wshadow
WARNINGS += -Wpointer-arith -Wcast-align -Wwrite-strings -Wmissing-declarations
WARNINGS += -Wredundant-decls -Wnested-externs -Winline -Wno-long-long
WARNINGS += -Wuninitialized -Wstrict-prototypes -Wdeclaration-after-statement
WARNINGS += -Wno-unused-function

DEFINES := -DHAVE_MMAP=0 -DDLMALLOC_EXPORT="" -DNO_MALLINFO
DEFINES += -DLACKS_UNISTD_H -DLACKS_FCNTL_H -DLACKS_SYS_PARAM_H

INCLUDES := -isystem ${PWD}/include -isystem ${PWD}/popcorn/include

CFLAGS := -std=c11 ${INCLUDES} ${WARNINGS} ${DEFINES} ${USERFLAGS} -ggdb
LIBCFLAGS := -target x86_64-elf -ffreestanding -nostdinc -nostdlib -std=c11 ${CFLAGS}

.PHONY: all clean test todos fixmes help install

all: tags ${BUILDDIR}/libc.a test

${BUILDDIR}/libc.a: ${OBJS}
	${AR} rc ${BUILDDIR}/libc.a $?

tags: ${SRCS}
	ctags -R functions include popcorn

test: ${BUILDDIR}/test
	@if $<; then true; else echo; echo "*** TESTS FAILED ***"; false; fi

${BUILDDIR}/test: ${TSTOBJS}
	${CC} -o $@ $^

-include ${DEPS} ${TSTDEPS}

clean:
	-${RM} -r ${BUILDDIR}

todos:
	-@for file in $(shell find . -type f \! -name Makefile); do grep -H TODO $$file; done; true

fixmes:
	-@for file in $(shell find . -type f \! -name Makefile); do grep -H FIXME $$file; done; true

help:
	@echo "Available make targets:"
	@echo
	@echo "all              - build libc.a"
	@echo "clean            - remove all object files, dependency files and test drivers"
	@echo "test             - build and run tests (link libc.a)"
	@echo "todos            - list all TODO comments in the sources"
	@echo "fixmes           - list all FIXME comments in the sources"
	@echo "install          - install the library to $$PREFIX"
	@echo "help             - print this list"
	@echo
	@echo "Any additional compiler flags you want to use can be passed as USERFLAGS"
	@echo "(Usage: USERFLAGS=\"flags\" make [...])."
	@echo
	@echo "Installation prefix is specified as PREFIX"
	@echo "(Usage: make install PREFIX=/path/to/sysroot/)."
	@echo
	@echo "If you want to build to a different path, you can specify BUILDDIR"
	@echo "(Usage: make [...] BUILDDIR=/path/to/binaries/)."

install: ${BUILDDIR}/libc.a
	install -d "${PREFIX}/include" "${PREFIX}/lib"
	install -C "${BUILDDIR}/libc.a" "${PREFIX}/lib/"
	for hdr in ${HEADERS}; do install -D $${hdr} "${PREFIX}/$${hdr}"; done
	for hdr in $(patsubst popcorn/%,%,${POPHEADERS}); do install -D "popcorn/$${hdr}" "${PREFIX}/$${hdr}"; done

${BUILDDIR}/%.o: %.c Makefile 
	@mkdir -p $(dir $@)
	${CC} ${LIBCFLAGS} -MMD -MP -c $< -o $@

${BUILDDIR}/%_testing.o: %.c Makefile 
	@mkdir -p $(dir $@)
	${CC} ${CFLAGS} -DTESTING -MMD -MP -c $< -o $@

${BUILDDIR}/tests/%.o: tests/%.c Makefile
	@mkdir -p $(dir $@)
	${CC} ${CFLAGS} -I tests -MMD -MP -c $< -o $@
