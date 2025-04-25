SHELL := /usr/bin/env bash

PYTHON ?= python
VENV ?= .venv

GENERATED_FILES =

.SUFFIXES:
.SUFFIXES: .yaml .jq .json .rdt
.PRECIOUS: .yaml .jq

.PHONY: all
all: venv
# all: $(GENERATED_FILES)

ACTIVATE_SCRIPT = $(VENV)/bin/activate
.PHONY: venv
venv: $(ACTIVATE_SCRIPT)
$(ACTIVATE_SCRIPT): requirements.txt
	@test -d $(VENV) || $(PYTHON) -m venv $(VENV) && \
  source $(ACTIVATE_SCRIPT) && \
  $(PYTHON) -m pip install --upgrade pip setuptools wheel && \
  $(PYTHON) -m pip install --requirement $< && \
  touch $(ACTIVATE_SCRIPT)

.PHONY: venv_upgrade
venv_upgrade:
	@rm -rf $(VENV) && \
  $(PYTHON) -m venv $(VENV) && \
  source $(ACTIVATE_SCRIPT) && \
  $(PYTHON) -m pip install --upgrade pip setuptools wheel && \
  $(PYTHON) -m pip install --requirement requirements_bare.txt && \
  $(PYTHON) -m pip freeze > requirements.txt && \
  touch $(ACTIVATE_SCRIPT)

# moo: venv
#   @source $(ACTIVATE_SCRIPT) && \
#   ./moo.py > $@

.PHONY: clean
clean:
	@rm -rf $(GENERATED_FILES)

.PHONY: reallyclean
reallyclean: clean
	@rm -rf $(VENV)
