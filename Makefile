.POSIX:

all:
	@if [ ! -d build ]; then \
		mkdir build;     \
	fi
	@cd build; voc -s ${.CURDIR}/src/lDefs.Mod      \
			  ${.CURDIR}/src/strutils.Mod   \
			  ${.CURDIR}/src/List.Mod       \
			  ${.CURDIR}/src/StringList.Mod

test:
	@if [ ! -d build ]; then      \
		echo Run make, first; \
		exit 1;               \
	fi
	@cd build; voc ${.CURDIR}/tests/TestList.Mod -m               \
		       ${.CURDIR}/tests/TestStrutils.Mod -m           \
		       > /dev/null 2>&1                               \
		       || (echo Failed to compile, have you run make? \
		           && exit 1)
	@./build/TestStrutils                \
		&& echo TestStrutils: passed \
		|| echo TestStrutils: failed
	@./build/TestList                \
		&& echo TestList: passed \
		|| echo TestList: failed

clean:
	rm -rf build

.PHONY: test
