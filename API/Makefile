all: build

build:
	mkdir -p out
	swift run --package-path ../Rapier rapier TelegramAPIDefinition.yml out

install:
	cp ./out/Methods.swift ../Sources/TelegramBotSDK/Generated
	cp ./out/Types.swift ../Sources/TelegramBotSDK/Generated

rebuild: clean build

clean:
	rm -f out/Methods.swift
	rm -rf out/Types.swift

.PHONY: all build install rebuild clean
