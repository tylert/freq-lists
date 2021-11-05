Codeplugs
=========


Requirements
------------

You must have the following tools installed:

* (REQUIRED) editcp_ 1.0.23 or newer (and/or just the "dmrRadio_" binary 1.0.23 or newer) for exporting/importing codeplugs to/from JSON
* (SUGGESTED) jq_ for working with JSON payloads

.. _editcp: https://github.com/DaleFarnsworth-DMR/editcp
.. _dmrRadio: https://github.com/DaleFarnsworth-DMR/dmrRadio
.. _jq: https://stedolan.github.io/jq/

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


DFU Mode
--------

Retevis RT3S DFU mode uses top side key + PTT + twist power knob.  Retevis RT90
DFU mode uses orange emergency button + P1 + plug-in "hard" power (ignore
"soft" power button).  TYT MD-390 DFU mode uses the same method as Retevis
RT3S.


Links
-----

* https://shapeshed.com/jq-json/
* https://programminghistorian.org/en/lessons/json-and-jq
* https://stackoverflow.com/questions/19529688/how-to-merge-2-json-objects-from-2-files-using-jq
* https://www.farnsworth.org/dale/codeplug/editcp/  main page for Editcp
* https://github.com/DaleFarnsworth-DMR  source for editcp, dmrRadio, libraries, etc.
* https://dm3mat.darc.de/qdmr/  main page for qdmr
* https://github.com/hmatuschek/qdmr  source for qdmr
* https://openrtx.org/#/  main page for OpenRTX
* https://github.com/OpenRTX  OpenRTX firmware, dmrconfig tool, etc.
