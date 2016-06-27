all: build

build:
	./generate_wrappers.rb

rebuild: clean build

clean:
	rm -f out/Types/*
	rm -f out/Methods/*

.PHONY: all build rebuild clean
