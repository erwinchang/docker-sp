all: build

help:
	@echo ""
	@echo "-- Help Menu"
	@echo "  1. make run         - start sp8388 docker image"
	@echo "  2. make build       - build the sp8388 image"
	@echo "  3. make release     - release the sp8388 image"

run:
	@docker run -v ${HOME}:/mnt/home --rm --name sp8388-image -it erwinchang/sp8388 /bin/bash

build:
	@docker build --tag=erwinchang/sp8388 .

release: build
	@docker build --tag=erwinchang/sp8388:$(shell cat VERSION) .
