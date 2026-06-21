.PHONY: test testClean clean
LIBDIR := lib/github.com/pzel/sml-either
MLB_PATH := -mlb-path-var 'SMLPKG $(shell pwd)/lib'
MLCOMP ?= polymlb

ifeq ($(MLCOMP), polymlb)
MLCOMP_FLAGS=-ann 'ignoreFiles call-main.sml'
endif

all:	 clean test

clean:
	rm -f bin/* tmp/*

test: $(shell find $(LIBDIR) | grep *.sql)
	rm -f Either.results
	mkdir -p bin
	$(MLCOMP) $(MLCOMP_FLAGS) $(MLB_PATH) -output runTests $(LIBDIR)/test/runTests.mlb && ./runTests && (tail -n1 ./Either.results | grep -v failures)

