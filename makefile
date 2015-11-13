PYTHON = python3

all:

dist: dist/pdfcrowd3-*.zip dist/pdfcrowd3-*.tar.gz

dist/pdfcrowd3-*.tar.gz dist/pdfcrowd3-*.zip: setup.py pdfcrowd.py
	grep "__version__ = \""`grep -oE "version='[0-9.]+" setup.py | sed "s/version='//"` pdfcrowd.py > /dev/null
	rm -rf dist/* build/* python/MANIFEST
	$(PYTHON) setup.py clean && $(PYTHON) setup.py sdist --formats=gztar,zip

test:
	$(PYTHON) ./tests.py $(API_USERNAME) $(API_TOKEN) $(API_HOSTNAME) $(API_HTTP_PORT) $(API_HTTPS_PORT)

publish:
	rm -rf dist/* build/* python/MANIFEST
	$(PYTHON) setup.py clean && $(PYTHON) setup.py sdist upload

init:
	test -d ../test_files/out || mkdir -p ../test_files/out
	test -e test_files || ln -s ../test_files/ test_files

.PHONY: clean
clean:
	rm -rf dist/* build/* python/MANIFEST ./test_files/out/py_client*.pdf

