.PHONY: build
build:
	docker build . -t stackptr/babelpod --platform linux/amd64
  
.PHONY: push
push:
	docker image push stackptr/babelpod
