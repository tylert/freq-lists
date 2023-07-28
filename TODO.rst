Libs
----

* "encoding/csv" stdlib stuff  to work with CSV files
* "encoding/json" stdlib stuff  to work with JSON files
* https://github.com/goccy/go-yaml  to work with YAML files
* https://github.com/go-yaml/yaml  to work with YAML files
* https://github.com/qax-os/excelize  to work with XLSX files
* https://github.com/unidoc/unioffice  to work with XLSX files
* https://github.com/bitfield/script  to rule them all and in the darkness bind them


Notes
-----

* figure out how to do the same "jq" thing with https://github.com/itchyny/gojq

::

    go install github.com/itchyny/gojq/cmd/gojq@latest

    cat foo.yaml | gojq --yaml-input '.' > foo.json   # convert YAML to JSON
    cat foo.json | gojq --yaml-output '.' > foo.yaml  # convert JSON to YAML

    # =======================
    # CLOSE, BUT NOT QUITE!!!
    # =======================

    cat repeaters/*.yaml | gojq --yaml-input -s 'map(to_entries)|flatten|group_by(.key)|map({(.[0].key):map(.value)})|add' | less
