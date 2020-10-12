RADIO ?= Retevis_RT3S
CALLSIGN ?= VA3DGN

CONF = $(wildcard *.conf)
JSON = $(CONF:.conf=.json)
RDT = $(CONF:.conf=.rdt)

GENERATED_FILES = $(JSON) $(RDT)

%.json: $(RADIO).tmpl $(RADIO).jq $(CALLSIGN).conf
	@cat $(RADIO).tmpl | jq -f $(RADIO).jq > $@

%.rdt: %.json
	@dmrRadio jsonToCodeplug $< $@

.PHONY: clean
clean:
	@rm -f $(GENERATED_FILES)
