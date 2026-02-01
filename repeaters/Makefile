SHELL := /usr/bin/env bash

%.ps: %.yaml
	@enscript --landscape --line-numbers=1 --no-header --output $@ $^

%.pdf: %.ps
	@ps2pdf $^ $@
