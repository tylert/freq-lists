Codeplugs
=========


Requirements
------------

You must have the following tools installed:

* (REQUIRED) editcp_ (and/or just the "dmrRadio_" binary) for exporting/importing codeplugs to/from JSON
* (REQUIRED) jq_ for working with JSON payloads
* (OPTIONAL) dmrconfig_ for working with codeplugs for radios that aren't supported by editcp yet

.. _editcp: https://www.farnsworth.org/dale/codeplug/editcp/
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
    dmrRadio codeplugToJSON codeplug.rdt codeplug.json  # or use editcp
    cat codeplug.json | jq -f Retevis_RT3S.jq > Retevis_RT3S.json


Generating Codeplugs From Templates
-----------------------------------

::

    # ========
    # WARNING:  Don't put spaces in the intro screen lines
    # ========

    # Use the template to produce a JSON codeplug data file containing specific values
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
    jq -s '.[0] * .[1]' data.json codeplug.json
    dmrRadio jsonToCodeplug codeplug.json codeplug.rdt  # or use editcp


Starting a New Codeplug
-----------------------

::

    # https://github.com/DaleFarnsworth-DMR/dmrRadio/issues/1
    # dmrRadio newCodeplug action not yet supported
    # use editcp to create a new codeplug and save it
    dmrRadio codeplugToJSON new.rdt new.json
    cat new.json | jq 'del(.Channels[])' > empty.json


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
