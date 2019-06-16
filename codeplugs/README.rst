::

    echo '{"RadioID": "3023706", "RadioName": "VA3VXN"}' |\
    gomplate -d dmr=stdin:///in.json -f TYT_MD-390G.json.tmpl > TYT_MD-390G.json

    dmrRadio jsonToCodeplug TYT_MD-390G.json TYT_MD-390G.rdt

* https://www.farnsworth.org/dale/codeplug/editcp/
* https://gomplate.ca/
