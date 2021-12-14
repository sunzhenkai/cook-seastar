.PHONY: all

all: prepare

prepare: assets/scripts/prepare.sh
	@bash $<

resolve: external/install.sh
	@bash $<