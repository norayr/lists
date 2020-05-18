VOC = /opt/voc/bin/voc
BLD=bld


all:
		mkdir -p $(BLD)
		cd $(BLD) && \
		$(VOC) -s \
		../src/lDefs.Mod \
		../src/strutils.Mod \
		../src/List.Mod \
		../src/StringList.Mod

tests: all
		cd $(BLD) && \
		$(VOC) ../tst/TestList.Mod -m
		cd $(BLD) && \
		$(VOC) ../tst/TestStrutils.Mod -m
		$(BLD)/TestStrutils
		$(BLD)/TestList

clean:
		if [ -d "$(BLD)" ]; then rm -rf $(BLD); fi
