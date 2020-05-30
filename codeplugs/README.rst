Codeplugs
=========


Requirements
------------

You must have the following tools installed:

* Editcp_ (and/or just the "dmrRadio" binary) for exporting/importing codeplugs to/from JSON
* jq_ for working with JSON payloads
* sed for doing the things that jq can't do (weird quoting stuff)
* gomplate_ for templating files
* dmrconfig_ for working with codeplugs from radios that aren't supported by Editcp yet

.. _Editcp: https://www.farnsworth.org/dale/codeplug/editcp/
.. _jq: https://stedolan.github.io/jq/
.. _gomplate: https://gomplate.ca/
.. _dmrconfig: https://github.com/sergev/dmrconfig/

There's a good tutorial at
https://www.jeffreykopcak.com/2017/06/11/dmr-in-amateur-radio-programming-a-code-plug/
which is mostly-applicable.


Converting Existing Codeplugs To Templates
------------------------------------------

Codeplugs are exported to JSON text using "Editcp".  JSON files are then
augmented with "gomplate" formatting to turn them into templateble JSON files.

::

    # Export the binary codeplug as JSON
    dmrRadio codeplugToJSON foo.rdt foo.json  # or use editcp

    # Convert the JSON codeplug data into a template
    cat foo.json | jq -f Retevis_RT3S.jq | sed 's/XXX/ds "dmr"/' > Retevis_RT3S.tmpl


Generating Codeplugs From Templates
-----------------------------------

Using a templateable JSON file to produce a JSON file containing specific
values is then done before converting them back into a binary codeplug.

::

    # Use the template to produce a JSON codeplug data file containing specific values
    echo '{"GeneralSettings": {"RadioID": "3023706", "RadioName": "VA3VXN"}}' |\
    gomplate -d dmr=stdin:///in.json -f TYT_MD-390G.tmpl | jq . > 3023706.json

    # Use the template to produce a JSON codeplug data file containing specific values
    cat << EOF > bla.yaml
    GeneralSettings:
      RadioID: 3023396
      RadioName: VA3DGN
    EOF
    gomplate -d dmr=bla.yaml -f Retevis_RT3S.tmpl | jq . > 3023396.json

    # Generate a binary codeplug from the JSON codeplug data file
    dmrRadio jsonToCodeplug 3023706.json 3023706.rdt  # or use editcp
