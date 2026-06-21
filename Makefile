LIBDIR := lib/github.com/pzel/sml-either
MLCOMP ?= polymlb

ifeq ($(MLCOMP), polymlb)
MLCOMP_FLAGS=-ann 'ignoreFiles call-main.sml'
endif

.PHONY: all
all:	 test

.PHONY: clean
clean:
	-@find -type d | grep MLB | xargs -n1 rm -rf
	-@rm -f runTests Either.results

.PHONY: test
test: $(shell find $(LIBDIR) | grep *.sql) clean
	@$(MLCOMP) $(MLCOMP_FLAGS) -output runTests $(LIBDIR)/test/runTests.mlb \
	&& ./runTests \
	&& (tail -n1 ./Either.results | grep -v failures)

.PHONY: test-all
test-all:
	@MLCOMP=polymlb $(MAKE) test
	@MLCOMP=mlton $(MAKE) test
	@MLCOMP=mlkit $(MAKE) test
	@echo "SUCCESSFULLY COMPILED ON ALL COMPILERS"
