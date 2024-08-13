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

* Figure out how to do the same "jq" thing with https://github.com/itchyny/gojq instead
* Ensure we aren't doing anything incompatible with https://github.com/itchyny/gojq#difference-to-jq
* Check the docs at https://github.com/jqlang/jq/releases/tag/jq-1.7 too

::

    go install github.com/itchyny/gojq/cmd/gojq@latest

    cat foo.yaml | gojq --yaml-input '.' > foo.json   # convert YAML to JSON
    cat foo.json | gojq --yaml-output '.' > foo.yaml  # convert JSON to YAML

    cat foo.json | gojq -r tostring > minified.json   # minify JSON
    cat minified.json | gojq > foo.json               # unminify JSON

::

    cat radios/stubs.yaml 1.yaml 2.yaml ... n.yaml | gojq --yaml-input -s -f radios/merge.jq

* https://richrose.dev/posts/linux/jq/jq-json2csv  CSV output from gojq works too
