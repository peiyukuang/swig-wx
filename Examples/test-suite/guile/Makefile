#######################################################################
# $Header: /cvsroot/swig/SWIG/Examples/test-suite/guile/Makefile.in,v 1.8 2005/06/10 11:30:32 mkoeppe Exp $
# Makefile for guile test-suite
#######################################################################

LANGUAGE     = guile
VARIANT      = _gh
SCRIPTSUFFIX = _runme.scm
srcdir       = .
top_srcdir   = ../../..
top_builddir = ../../../
GUILE        = 

C_TEST_CASES = long_long list_vector pointer_in_out multivalue

include $(srcdir)/../common.mk

# Overridden variables here
# none!

# Rules for the different types of tests
%.cpptest: 
	$(setup) \
	($(swig_and_compile_cpp); ) && \
	$(run_testcase)

%.ctest:
	$(setup) \
	($(swig_and_compile_c); ) && \
	$(run_testcase)

# override the default in common.mk by adding SWIGOPT +=
swig_and_compile_multi_cpp = \
	for f in `cat $(top_srcdir)/$(EXAMPLES)/$(TEST_SUITE)/$*.list` ; do \
	  SWIGOPT=" -runtime "; \
	  export SWIGOPT; \
	  $(MAKE) -f $(top_builddir)/$(EXAMPLES)/Makefile CXXSRCS="$(CXXSRCS)" \
	  SWIG_LIB="$(SWIG_LIB)" SWIG="$(SWIG)" LIBS='$(LIBS)' \
	  INCLUDES="$(INCLUDES)" SWIGOPT="$(SWIGOPT) $$SWIGOPT" NOLINK=true \
	  TARGET="$(TARGETPREFIX)$${f}$(TARGETSUFFIX)" INTERFACE="$$f.i" \
	  $(LANGUAGE)$(VARIANT)_cpp; \
	  SWIGOPT=" -noruntime "; \
	done

%.multicpptest: 
	$(setup) \
	($(swig_and_compile_multi_cpp); ) && \
	$(run_testcase)

# Runs the testcase. A testcase is only run if
# a file is found which has _runme.scm appended after the testcase name.
run_testcase = \
	if [ -f $(srcdir)/$(SCRIPTPREFIX)$*$(SCRIPTSUFFIX) ]; then (	  \
	  env LD_LIBRARY_PATH=.:$$LD_LIBRARY_PATH $(GUILE) -l $(srcdir)/$(SCRIPTPREFIX)$*$(SCRIPTSUFFIX);) \
	fi;

# Clean
%.clean:
	@rm -f $*-guile

clean:
	$(MAKE) -f $(top_builddir)/$(EXAMPLES)/Makefile guile_clean
