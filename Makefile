.PHONY: all

all: prepare

prepare: assets/scripts/prepare.sh
	@sh $<