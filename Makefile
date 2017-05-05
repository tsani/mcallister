.PHONY: deploy dist/client.js deps bin/mcallister

DEPLOY_DEST=/srv/http/mcallister

$(shell mkdir -p deploy)

deploy: bin/mcallister deploy/index.js deploy/index.html deploy/index.css
	cp deploy/* $(DEPLOY_DEST)

bin/mcallister:
	cabal build
	cp dist/build/mcallister/mcallister bin

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
