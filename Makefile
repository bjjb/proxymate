.PHONY: image clean

default: image

proxymate: main.go
	go build

main: main.go
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main .

clean:
	rm -fv *.js lib/*.js docs/*.{js,css,html} app/*.{js,css,html} main starfish

image: main
	docker build -t bjjb/proxymate .
