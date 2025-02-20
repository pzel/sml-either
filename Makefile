.PHONY: polymlb test testClean clean
LIBDIR := lib/github.com/pzel/sml-either
MLB_PATH := -mlb-path-var 'SMLPKG $(shell pwd)/lib'

all:	 clean test

clean:
	rm -f bin/* tmp/*

test: polymlb $(shell find $(LIBDIR) | grep *.sql)
	rm -f Either.results
	mkdir -p bin
	polymlb $(MLB_PATH) -output runTests $(LIBDIR)/test/runTests.mlb && ./runTests && (tail -n1 ./Either.results | grep -v failures)

