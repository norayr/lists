VOC = /opt/voc/bin/voc
BUILD=build
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
mkfile_dir_path := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
current_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))


all:
		mkdir -p $(BUILD)
		cd $(BUILD) && $(VOC) -s \
		$(mkfile_dir_path)/src/lDefs.Mod \
		$(mkfile_dir_path)/src/strutils.Mod \
		$(mkfile_dir_path)/src/List.Mod \
		$(mkfile_dir_path)/src/StringList.Mod

tests: all
		$(VOC) $(mkfile_dir_path)/tst/TestList.Mod -m
		$(VOC) $(mkfile_dir_path)/tst/TestStrutils.Mod -m
		$(BUILD)/TestStrutils
		$(BUILD)/TestList

clean:
		if [ -d "$(BUILD)" ]; then rm -rf $(BUILD); fi
