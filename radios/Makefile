SHELL := /bin/bash

SOURCE_FILES = $(wildcard *.odt)

PDF_FILES = $(SOURCE_FILES:.odt=.pdf)

GENERATED_FILES ?= $(PDF_FILES)

.PHONY : all
all : $(GENERATED_FILES)

.PHONY : pdf
pdf : $(PDF_FILES)

%.pdf : %.odt
	@libreoffice --headless --convert-to pdf $^ \
  "-env:UserInstallation=file:///tmp/libreofficebug"

.PHONY : clean
clean :
	@rm -f $(GENERATED_FILES)
