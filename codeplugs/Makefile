CALLSIGN ?=
MODEL ?= Retevis_RT3S

.PRECIOUS: %.json %.rdt

.PHONY: all
all: $(CALLSIGN).rdt

%.json: %.yaml
	@gomplate -d dmr=$(^) -f $(MODEL).tmpl | jq . > $(@)

%.rdt: %.json
	@dmrRadio jsonToCodePlug $(^) $(@)

.PHONY: clean
clean:
	@rm -f *.json *.rdt
