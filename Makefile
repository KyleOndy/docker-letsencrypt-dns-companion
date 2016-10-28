IMAGE_NAME=kyleondy/dns-certbot:latest

.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .
