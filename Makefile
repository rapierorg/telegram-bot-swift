all: build

test:
	swift test

build:
	swift build

clean:
	swift package clean

xcodeproj:
	swift package generate-xcodeproj

.PHONY: all test build clean xcodeproj
