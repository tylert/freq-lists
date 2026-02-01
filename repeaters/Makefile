SHELL := /usr/bin/env bash

%.ps: %.yaml
	@enscript -B -C1 -o $@ $^

%.pdf: %.ps
	@ps2pdf $^ $@
