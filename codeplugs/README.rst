::

    # Convert a codeplug into a template
    dmrRadio codeplugToJSON foo.rdt foo.json
    cat foo.json | jq --file template.jq | sed --file template.sed > TYT_MD-390G.json.tmpl

    # Use the template to produce something with specific values
    echo '{"RadioID": "3023706", "RadioName": "VA3VXN"}' |\
    gomplate -d dmr=stdin:///in.json -f TYT_MD-390G.json.tmpl | jq . > TYT_MD-390G.json

    # Generate a codeplug from the file with specific values
    dmrRadio jsonToCodeplug TYT_MD-390G.json TYT_MD-390G.rdt

* https://www.farnsworth.org/dale/codeplug/editcp/
* https://gomplate.ca/
* https://stedolan.github.io/jq/
