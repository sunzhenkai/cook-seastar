.PHONY: all

all: prepare

prepare: assets/scripts/prepare.sh
	@bash $<

install: external/install.sh
	@bash $<