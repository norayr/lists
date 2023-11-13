VOC = /opt/voc/bin/voc
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir_path := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
build_dir_path := $(mkfile_dir_path)/build
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))
BLD := $(mkfile_dir_path)/build
DPD  =  deps
DPS := $(mkfile_dir_path)/$(DPD)

all: get_deps build_deps buildLists

get_deps:
	mkdir -p $(DPS)
	if [ -d $(DPS)/strutils ]; then cd $(DPS)/strutils; git pull; cd -; else cd $(DPS); git clone https://github.com/norayr/strutils; cd -; fi

build_deps:
	mkdir -p $(mkfile_dir_path)
	cd $(BUILD)
	make -f $(mkfile_dir_path)/$(DPD)/strutils/GNUmakefile BUILD=$(BLD)

buildLists:
	cd $(BLD) && $(VOC) -s $(mkfile_dir_path)/src/List.Mod
	cd $(BLD) && $(VOC) -s $(mkfile_dir_path)/src/StringList.Mod

tests:
	cd $(BLD) && $(VOC) $(mkfile_dir_path)/test/testList.Mod -m
	build/testList

clean:
	if [ -d "$(BLD)" ]; then rm -rf $(BLD); fi
