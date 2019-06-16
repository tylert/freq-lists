::

    echo '{"RadioID": "3023396", "RadioName": "VA3DGN"}' |\
    gomplate -d dmr=stdin:///in.json -f TYT_MD-390G.json.tmpl > TYT_MD-390G.json

    dmrRadio jsonToCodeplug TYT_MD-390G.json TYT_MD-390G.rdt

* https://www.farnsworth.org/dale/codeplug/editcp/
* https://gomplate.ca/
