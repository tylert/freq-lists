# Typst

* <https://typst.app/docs/reference/model/table>
* <https://typst.app/docs/reference/data-loading/csv>
* <https://forum.typst.app/t/displaying-specific-data-from-csv-file/1283/5>
* <https://typst.app/universe/package/tabut>


# JQ/YQ

* <https://github.com/itchyny/gojq#difference-to-jq>
* <https://github.com/jqlang/jq/releases/tag/jq-1.7>
* <https://itchyny.medium.com/golang-implementation-of-jq-gojq-ad5bd46a4af2>
* <https://stackoverflow.com/questions/72488570/merge-2-yaml-files-with-update-in-place-only#72495954> merge 2 YAML files using gojq
* <https://github.com/mikefarah/yq/issues/1967> merge 2 YAML files using yq
* <https://github.com/mikefarah/yq/discussions/1561> merge 2 YAML files using yq
* <https://richrose.dev/posts/linux/jq/jq-json2csv> CSV output from gojq works too

    go install github.com/itchyny/gojq/cmd/gojq@latest

    cat foo.yaml | gojq --yaml-input '.' > foo.json   # convert YAML to JSON
    cat foo.json | gojq --yaml-output '.' > foo.yaml  # convert JSON to YAML

    cat foo.json | gojq -r tostring > minified.json   # minify JSON
    cat minified.json | gojq > foo.json               # unminify JSON

    cat radios/stubs.yaml 1.yaml 2.yaml ... n.yaml | gojq --yaml-input -s -f radios/merge.jq


# Piping

* <https://stackoverflow.com/questions/49704456/how-to-read-from-device-when-stdin-is-pipe/49704981#49704981>
