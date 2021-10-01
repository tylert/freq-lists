Codeplugs
=========


Requirements
------------

You must have the following tools installed:

* (REQUIRED) editcp_ 1.0.23 or newer (and/or just the "dmrRadio_" binary 1.0.23 or newer) for exporting/importing codeplugs to/from JSON
* (REQUIRED) jq_ for working with JSON payloads
* (OPTIONAL) dmrconfig_ for working with codeplugs for radios that aren't supported by editcp yet
* (OPTIONAL) qdmr_ to provide a nice GUI when working with dmrconfig

.. _editcp: https://github.com/DaleFarnsworth-DMR/editcp
.. _dmrRadio: https://github.com/DaleFarnsworth-DMR/dmrRadio
.. _jq: https://stedolan.github.io/jq/
.. _dmrconfig: https://github.com/OpenRTX/dmrconfig
.. _qdmr: https://github.com/hmatuschek/qdmr

There are some really good programming tutorials at
https://youtu.be/VExx628R0DM and https://youtu.be/Lw0Y-jQZMZ0 which are useful
for learning about the digital side of things.


Converting Existing Codeplugs To Templates
------------------------------------------

::

    # Export the binary codeplug as JSON and fix some values
    dmrRadio codeplugToJSON codeplug.rdt before.json  # or use editcp
    cat before.json | jq --from-file Retevis_RT3S.jq > after.json


Generating Codeplugs From Templates
-----------------------------------

::

    # ========
    # WARNING:  Don't put spaces in the intro screen lines
    # ========

    # Create a data file containing your specific values
    cat << EOF > VA3DGN.conf
    {
      "GeneralSettings": {
        "IntroScreenLine1": "VA3DGN",
        "IntroScreenLine2": "3023396",
        "RadioID": "3023396",
        "RadioID1": "3021794",
        "RadioID2": "3023706",
        "RadioID3": "3021795",
        "RadioName": "VA3DGN"
      }
    }
    EOF

    make CALLSIGN=VA3DGN RADIO=Retevis_RT3S  # just build the codeplug
    make write_codeplug                      # write the codeplug to the radio
    make write                               # write both the codeplug and contacts


Updating Contacts Database
--------------------------

::

    make contacts        # just fetch the contacts
    make write_contacts  # write the contacts to the radio


Starting a New Codeplug
-----------------------

::

    # Create a brand new, empty codeplug
    dmrRadio newCodeplug -model RT3S -freq "136-174_400-480" new.rdt  # or use editcp

    # Make it even emptier still
    dmrRadio codeplugToJSON new.rdt new.json
    cat new.json \
        | jq 'del(.Contacts[])' \
        | jq 'del(.Channels[])' \
        | jq 'del(.GroupLists[])' \
        | jq 'del(.ScanLists[])' \
        | jq 'del(.Zones[])' > empty.json


Converting from CHIRP to DMR Channels
-------------------------------------

::

    python -m venv ~/.venv
    source ~/.venv/bin/activate
    pip install --requirement requirements.txt

    ./chirp_channels.py --help

    ./chirp_channels.py \
        --chirp_csv ../info/Simplex_2m_70cm_16char.csv \
        --codeplug_json codeplug1.json > codeplug2.json

    ./chirp_channels.py \
        --rx_only On \
        --chirp_csv ../info/Weather_info_VHF.csv \
        --codeplug_json codeplug2.json > codeplug3.json


Links
-----

* https://shapeshed.com/jq-json/
* https://programminghistorian.org/en/lessons/json-and-jq
* https://stackoverflow.com/questions/19529688/how-to-merge-2-json-objects-from-2-files-using-jq
