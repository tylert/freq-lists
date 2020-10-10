Codeplugs
=========


Requirements
------------

You must have the following tools installed:

* (REQUIRED) editcp_ 1.0.23 or newer (and/or just the "dmrRadio_" binary 1.0.23 or newer) for exporting/importing codeplugs to/from JSON
* (REQUIRED) jq_ for working with JSON payloads
* (OPTIONAL) dmrconfig_ for working with codeplugs for radios that aren't supported by editcp yet

.. _editcp: https://github.com/DaleFarnsworth-DMR/editcp
.. _dmrRadio: https://github.com/DaleFarnsworth-DMR/dmrRadio
.. _jq: https://stedolan.github.io/jq/
.. _dmrconfig: https://github.com/sergev/dmrconfig/

There are some really good programming tutorials at
https://youtu.be/VExx628R0DM and https://youtu.be/Lw0Y-jQZMZ0 which are useful
for learning about the digital side of things.


Converting Existing Codeplugs To Templates
------------------------------------------

::

    # Export the binary codeplug as JSON and fix some values
    dmrRadio codeplugToJSON codeplug.rdt before.json  # or use editcp
    cat before.json | jq -f Retevis_RT3S.jq > after.json

    # TODO:  Add example for codeplugs for foreign models that editcp doesn't support yet


Generating Codeplugs From Templates
-----------------------------------

::

    # ========
    # WARNING:  Don't put spaces in the intro screen lines
    # ========

    # Create a data file containing your specific values
    cat << EOF > data.json
    {
      "GeneralSettings": {
        "IntroScreenLine1": "3023396",
        "IntroScreenLine2": "3021794",
        "RadioID": "3023396",
        "RadioID1": "3021794",
        "RadioID2": "3023706",
        "RadioID3": "3021795",
        "RadioName": "VA3DGN"
      }
    }
    EOF

    # Merge your data file with your codeplug
    jq -s '.[0] * .[1]' data.json codeplug.json

    # Convert the JSON file back into a binary codeplug
    dmrRadio jsonToCodeplug codeplug.json codeplug.rdt  # or use editcp


Starting a New Codeplug
-----------------------

::

    # Create a brand new, empty codeplug
    dmrRadio newCodeplug -model RT3S -freq "136-174_400-480" new.rdt  # or use editcp

    # Make it even emptier still
    dmrRadio codeplugToJSON new.rdt new.json
    cat new.json | jq 'del(.Channels[])' | jq 'del(.GroupLists[])' | jq 'del(.ScanLists[])' | jq 'del(.Zones[])' > empty.json


Converting from CHIRP to DMR Channels
-------------------------------------

::

    python3 -m venv ~/.venv
    source ~/.venv/bin/activate
    pip install --requirement requirements.txt

    ./chirp_channels.py \
        --input_filename ../info/simplex_2m_70cm.csv \

    ./chirp_channels.py --help


Updating User Database
----------------------

::

    # Fetch the userdb and strip off the stuff that dmrRadio doesn't like yet
    wget https://database.radioid.net/static/user.csv
    cat user.csv | cut -d',' -f1-7 | sort -g | egrep '^[0-9]' > clean.csv

    # Build a list of countries to include
    cat << EOF > countries.txt
    Australia
    Canada
    France
    New Zealand
    United Kingdom
    United States
    EOF

    # Prepare the filtered user database and upload it to the radio
    dmrRadio filterUsers countries.txt clean.csv ready.csv
    dmrRadio writeUV380Users ready.csv


Links
-----

* https://shapeshed.com/jq-json/
* https://programminghistorian.org/en/lessons/json-and-jq
* https://stackoverflow.com/questions/19529688/how-to-merge-2-json-objects-from-2-files-using-jq
