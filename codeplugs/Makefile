RADIO ?= Retevis_RT3S
CALLSIGN ?= VA3DGN

CONF = $(wildcard *.conf)
JSON = $(CONF:.conf=.json)
RDT = $(CONF:.conf=.rdt)

GENERATED_FILES = $(JSON) $(RDT)

.PHONY: all
all: $(CALLSIGN).rdt

$(CALLSIGN).json: $(RADIO).tmpl $(RADIO).jq $(CALLSIGN).conf
	@cat $(RADIO).tmpl | jq --from-file $(RADIO).jq > $@ && \
  jq --slurp '.[0] * .[1]' $(RADIO).tmpl $(CALLSIGN).conf > $@

%.rdt: %.json
	@dmrRadio jsonToCodeplug $< $@

.PHONY: write
write: $(CALLSIGN).rdt
	@dmrRadio writeCodeplug $<

.PHONY: clean
clean:
	@rm -f $(GENERATED_FILES)
