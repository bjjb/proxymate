.PHONY: clean default

default:
	npm run build

clean:
	rm -fv *.js app/*.{js,css,html}
