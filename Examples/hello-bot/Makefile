all: build

build:
	swift build -Xswiftc -j8

rebuild: clean build

clean:
	@echo --- Invoking swift build --clean
	-swift build --clean

.PHONY: all build rebuild clean
