.PHONY: clean default

default:
	npm run build

clean:
	rm -fv *.js lib/*.js docs/*.{js,css,html} app/*.{js,css,html}
