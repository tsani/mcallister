.PHONY: deploy dist/client.js deps

$(shell mkdir -p deploy)

deploy: deploy/index.js deploy/index.html deploy/index.css

deploy/index.html: frontend/index.html
	cp $< $@

deploy/index.css: frontend/index.css
	cp $< $@

deploy/index.js: dist/client.js frontend/index.js
	cat $^ > $@

dist/client.js: deps
	cabal run client $@

deps:
	cabal update
	cabal install --only-dependencies
