all: build

build:
	mkdir -p out
	swift run --package-path ../Rapier rapier TelegramAPIDefinition.yml out

rebuild: clean build

clean:
	rm -f out/*

.PHONY: all build rebuild clean
