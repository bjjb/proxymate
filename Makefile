.PHONY: clean default

default:
	npm run build

clean:
	rm -fv *.js docs/*.{js,css,html} app/*.{js,css,html}
