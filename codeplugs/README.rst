Codeplugs
=========


Requirements
------------

You must have the following tools installed:

* (REQUIRED) editcp_ (and/or just the "dmrRadio_" binary) for exporting/importing codeplugs to/from JSON
* (REQUIRED) jq_ for working with JSON payloads
* (REQUIRED) sed for doing some things that jq can't do (to fix weird nested-quoting stuff)
* (REQUIRED) gomplate_ for templating files
* (OPTIONAL) dmrconfig_ for working with codeplugs for radios that aren't supported by editcp yet

.. _editcp: https://www.farnsworth.org/dale/codeplug/editcp/
.. _dmrRadio: https://github.com/DaleFarnsworth-DMR/dmrRadio
.. _jq: https://stedolan.github.io/jq/
.. _gomplate: https://gomplate.ca/
.. _dmrconfig: https://github.com/sergev/dmrconfig/

There's a good programming tutorial at
https://www.jeffreykopcak.com/2017/06/11/dmr-in-amateur-radio-programming-a-code-plug/
which is mostly-applicable.


Converting Existing Codeplugs To Templates
------------------------------------------

Codeplugs are exported to JSON text using "Editcp".  JSON files are then
augmented with "gomplate" formatting to turn them into templateble JSON files.

::

    # Export the binary codeplug as JSON
    dmrRadio codeplugToJSON codeplug1.rdt codeplug1.json  # or use editcp

    # Convert the JSON codeplug data into a template
    cat codeplug1.json | jq -f Retevis_RT3S.jq | sed 's/XXX/ds "dmr"/' > Retevis_RT3S.tmpl


Generating Codeplugs From Templates
-----------------------------------

Using a templateable JSON file to produce a JSON file containing specific
values is then done before converting them back into a binary codeplug.

::

    # ========
    # WARNING:  Don't put spaces in the intro screen lines
    # ========

    # Use the template to produce a JSON codeplug data file containing specific values
    cat << EOF > codeplug2.yaml
    GeneralSettings:
      IntroScreenLine1: 3023396
      IntroScreenLine2: 3021794
      RadioID: 3023396
      RadioID1: 3021794
      RadioID2: 3023706
      RadioID3: 3021795
      RadioName: VA3DGN
    EOF
    gomplate -d dmr=codeplug2.yaml -f Retevis_RT3S.tmpl | jq . > codeplug2.json

    # Use the template to produce a JSON codeplug data file containing specific values
    echo '{"GeneralSettings": {"RadioID": "3023706", "RadioName": "VA3VXN"}}' |\
    gomplate -d dmr=stdin:///in.json -f Retevis_RT3S.tmpl | jq . > codeplug3.json

    # Generate a binary codeplug from the JSON codeplug data file
    dmrRadio jsonToCodeplug codeplug4.json codeplug4.rdt  # or use editcp


Converting from CHIRP
---------------------

::

    python3 -m venv ~/.venv
    source ~/.venv/bin/activate
    pip install --requirement requirements.txt

    ./chirp_channels.py \
        --contact_name Contact1 \
        --input_filename ../info/simplex_2m_70cm.csv \
        --group_list GroupList1 \
        --scan_list ScanList1

    ./chirp_channels.py --help
