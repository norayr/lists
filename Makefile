.POSIX:

ROOTDIR  = $$PWD

all:
	@if [ ! -d build ]; then \
		mkdir build;     \
	fi
	@cd build; voc -s ${ROOTDIR}/../src/lDefs.Mod      \
			  ${ROOTDIR}/../src/strutils.Mod   \
			  ${ROOTDIR}/../src/List.Mod       \
			  ${ROOTDIR}/../src/StringList.Mod

test:
	@if [ ! -d build ]; then      \
		echo Run make, first; \
		exit 1;               \
	fi
	@cd build; voc ${ROOTDIR}/../tests/TestList.Mod -m            \
		       ${ROOTDIR}/../tests/TestStrutils.Mod -m        \
		       > /dev/null 2>&1                               \
		       || (echo Failed to compile, have you run make? \
		           && exit 1)
	@./build/TestStrutils                                 \
		> /dev/null 2>81                              \
		&& echo ${ROOTDIR}/build/TestStrutils: passed \
		|| echo ${ROOTDIR}/buildTestStrutils: failed
	@./build/TestList                                 \
		> /dev/null 2>&1                          \
		&& echo ${ROOTDIR}/build/TestList: passed \
		|| echo ${ROOTDIR}/build/TestList: failed

clean:
	rm -rf build

.PHONY: test
