.PHONY: all

all: prepare

prepare: assets/scripts/prepare.sh
	@bash $<

update: assets/scripts/update.sh
	@bash $<