Codeplugs
=========


Requirements
------------

You must have the following tools installed:

* editcp_ (and/or just the "dmrRadio" binary) for exporting/importing codeplugs to/from JSON
* jq_ for working with JSON payloads
* sed for doing the things that jq can't do (weird quoting stuff)
* gomplate_ for templating files

.. _editcp: https://www.farnsworth.org/dale/codeplug/editcp/
.. _jq: https://stedolan.github.io/jq/
.. _gomplate: https://gomplate.ca/


Converting Existing Codeplugs
-----------------------------

Codeplugs are exported to JSON text using "Editcp".  JSON files are then
augmented with "gomplate" formatting to turn them into templateble JSON files.

::

    # Convert a codeplug into a template
    dmrRadio codeplugToJSON foo.rdt foo.json  # or use editcp
    cat foo.json | jq -f template.jq | sed -f template.sed > TYT_MD-390G.json.tmpl


Generating Codeplugs From Templates
-----------------------------------

Using a templateable JSON file to produce a JSON file containing specific
values is then done before converting them back into a binary codeplug.

::

    # Use the template to produce something with specific values
    echo '{"GeneralSettings": {"RadioID": "3023706", "RadioName": "VA3VXN"}}' |\
    gomplate -d dmr=stdin:///in.json -f TYT_MD-390G.json.tmpl | jq . > TYT_MD-390G.json

    # Generate a codeplug from the file with specific values
    dmrRadio jsonToCodeplug TYT_MD-390G.json TYT_MD-390G.rdt  # or use editcp
