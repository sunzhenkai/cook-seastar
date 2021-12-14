.PHONY: all

all: run

run: assets/scripts/prepare.sh
	@sh $<