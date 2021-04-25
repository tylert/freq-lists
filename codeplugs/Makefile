RADIO ?= Retevis_RT3S
# CALLSIGN ?= VA3DGN

CONF = $(wildcard *.conf)
JSON = $(CONF:.conf=.json)
RDT = $(CONF:.conf=.rdt)

GENERATED_FILES = $(JSON) $(RDT) countries.txt user.csv scrubbed.csv filtered.csv

.PHONY: all
all: $(CALLSIGN).rdt contacts

# Force some settings to be set and some config values to be configured
$(CALLSIGN).json: $(RADIO).tmpl $(RADIO).jq $(CALLSIGN).conf
	@cat $(RADIO).tmpl | jq --from-file $(RADIO).jq > $(@) && \
  jq --slurp '.[0] * .[1]' $(RADIO).tmpl $(CALLSIGN).conf > $(@)

%.rdt: %.json
	@dmrRadio jsonToCodeplug $(<) $(@)

.PHONY: write_codeplug
write_codeplug: $(CALLSIGN).rdt
	@dmrRadio writeCodeplug $(<)

countries.txt:
	@echo "Australia\nCanada\nNew Zealand\nUnited Kingdom\nUnited States" > $(@)

user.csv:
	@wget https://database.radioid.net/static/$(@)

# Force all rows to have 7 columns, sort by ID, drop lines that don't start with an ID
scrubbed.csv: user.csv
	@cat $(<) | cut -d',' -f1-7 | sort -g | egrep '^[0-9]' > $(@)

.PHONY: contacts
contacts: filtered.csv
filtered.csv: scrubbed.csv countries.txt
	@dmrRadio filterUsers countries.txt $(<) $(@)

# This kinda assumes you're using a Retevis RT3S or Tytera/TYT MD-UV380/MD-UV390
.PHONY: write_contacts
write_contacts: filtered.csv
	@dmrRadio writeUV38Users $(<)

.PHONY: write
write: write_codeplug write_contacts

.PHONY: clean
clean:
	@rm -f $(GENERATED_FILES)
