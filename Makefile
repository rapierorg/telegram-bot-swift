all: build

test:
	swift test

build:
	swift build

clean:
	swift package clean

.PHONY: all test build clean
