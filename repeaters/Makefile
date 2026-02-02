SHELL := /usr/bin/env bash

%.ps: %.yaml
	@enscript --header='$$n|$(shell git describe --always --dirty --tags)|Page $$% of $$=' --landscape --line-numbers=1 --output $@ $^

%.pdf: %.ps
	@ps2pdf $^ $@
