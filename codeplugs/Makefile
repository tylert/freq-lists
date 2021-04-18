RADIO ?= Retevis_RT3S
CALLSIGN ?= VA3DGN

CONF = $(wildcard *.conf)
JSON = $(CONF:.conf=.json)
RDT = $(CONF:.conf=.rdt)

GENERATED_FILES = $(JSON) $(RDT) user.csv scrubbed.csv filtered.csv

.PHONY: all
all: $(CALLSIGN).rdt

$(CALLSIGN).json: $(RADIO).tmpl $(RADIO).jq $(CALLSIGN).conf
	@cat $(RADIO).tmpl | jq --from-file $(RADIO).jq > $(@) && \
  jq --slurp '.[0] * .[1]' $(RADIO).tmpl $(CALLSIGN).conf > $(@)

%.rdt: %.json
	@dmrRadio jsonToCodeplug $< $@

.PHONY: write
write: $(CALLSIGN).rdt
	@dmrRadio writeCodeplug $<

user.csv:
	@wget https://database.radioid.net/static/$(@)

# Force all rows to have 7 columns, sort by ID, drop lines that don't start with an ID
scrubbed.csv: user.csv
	@cat $(^) | cut -d',' -f1-7 | sort -g | egrep '^[0-9]' > $(@)

.PHONY: contacts
contacts: filtered.csv
filtered.csv: scrubbed.csv
	@dmrRadio filterUsers countries.txt $(^) $(@)

.PHONY: clean
clean:
	@rm -f $(GENERATED_FILES)
