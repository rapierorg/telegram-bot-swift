all: build

test:
	swift test

build:
	swift build
#	swift build -Xswiftc -j1

rebuild: clean build

clean:
	@echo --- Invoking swift build --clean
	-swift build --clean

.PHONY: all build rebuild clean
