freq-lists
==========

This information is intended purely for educational purposes.  It is your
responsibility to ensure that you and your equipment are behaving themselves
properly.


Requirements
------------

You must have the following tools installed:

* (REQUIRED) Python 3.10.x or newer;  for using the "multi_outputter" script for processing the input data files
* (REQUIRED) dmrRadio_ binary 1.0.23 or newer;  for exporting/importing codeplugs to/from JSON and generating blank codeplugs
* (SUGGESTED) editcp_ 1.0.23 or newer;  for further editing codeplugs
* (REQUIRED) jq_;  for working with JSON payloads

.. _editcp: https://github.com/DaleFarnsworth-DMR/editcp
.. _dmrRadio: https://github.com/DaleFarnsworth-DMR/dmrRadio
.. _jq: https://stedolan.github.io/jq/

There are some really good programming tutorials at
https://youtu.be/VExx628R0DM and https://youtu.be/Lw0Y-jQZMZ0 which are useful
for learning about the digital side of things.


Running Things
--------------

::

    # Initial setup
    make && source .venv/bin/activate

    # Create new stock codeplugs and CSV files for mobile and handheld radios
    ./generate_rdt.sh
    ./generate_csv.sh


Converting Existing Codeplugs To Templates
------------------------------------------

::

    # Export the binary codeplug as JSON and fix some values
    dmrRadio codeplugToJSON codeplug.rdt before.json
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

    make write_codeplug  # write the codeplug to the radio
    make write           # write both the codeplug and contacts


Updating Contacts Database
--------------------------

::

    make contacts        # just fetch the contacts
    make write_contacts  # write the contacts to the radio


Starting a New Codeplug
-----------------------

::

    # Create a brand new, empty codeplug
    dmrRadio newCodeplug -model RT3S -freq "400-480_136-174" new.rdt

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


Talkgroups
----------

* 3022;  Quebec

::

    VE3TST 444.125+ TG=2 TS=2

    VE2RAO 441.95+ Brandmeister
        TG=3022 TS=1 CC=1  (Quebec)
        TG=3023 TS=2 CC=1  (Ontario)
        TG=302 TS=2 CC=1  (Canada)
        TG=2 TS=2 CC=1  (local)
        TG=310 TS=2 CC=1  (TAC 310)
    (use TS=2 for all TG except 3022)

    VE3ORF TG=2

* https://wiki.brandmeister.network/index.php/TalkGroup/98638  WVNET
* https://wirelessvillage.ninja
* https://rfhackers.com


Hotspots
--------

::

    VE3YXY -> 445.225

* https://www.ailunce.com/blog/Set-up-MMDVM-DMR-Hotspot-to-work-with-Ailunce-HD1
* https://www.ailunce.com/blog/How-to-set-Rx-Tx-Offset
* https://github.com/VR2VYE/MMDVM_HS_firmware
* https://github.com/g4klx/MMDVMHost/pull/90


Admit Criteria determines when your radio is allowed to transmit.  The
recommended setting for repeater channels is Color Code Free; this configures
your radio to be polite to your own digital system.  You should configure your
In Call Criteria to Follow Admit Criteria.  Simplex channels should be
configured as Always for both Admit Criteria and Always or Follow TX for In
Call Criteria.


Linking and Transcoding
-----------------------

* https://n5amd.com/digital-radio-how-tos/build-digital-voice-transcoding-server/
* https://g0wcz.nodestone.io/building-a-transcoder-for-dmr-d-star/
* https://ad6dm.net/log/wp-content/uploads/2019/05/How-to-Create-a-Multimode-Digital-Voice-Reflector.pdf
* https://www.chrishoodblog.com/building-a-dmr-repeater-using-bridgecom-mobiles-pt1/
* https://www.chrishoodblog.com/make-your-own-dmr-server/
* https://sin.groups.io/g/main/message/355
* https://blog.rosenberg-watt.com/2018/08/14/towards-better-global-dmr-ham-radio-id-generation/
* https://tgifnetwork.createaforum.com/hotspot-configurartion/adding-second-hotspot-do-i-need-a-second-dmr-id/

::

    Control Software
      Controller Software:  MMDVM Host
      Controller Mode:  Duplex Repeater

    MMDVMHost Configuration
      DMR Mode:  On  (RF Hangtime:  2, Net Hangtime:  20)
      All other modes disabled
      MMDVM Display Type:  None

    General Configuration
      Hostname:  ve2cra
      Node Callsign:  VE2CRA
      CCS7/DMR ID:  302093
      Radio Frequency RX:  449.400000
      Radio Frequncy TX:  444.400000
      Latitude:  45.50
      Longitude:  -75.85
      Town:  Ottawa-Gatineau FN25bm
      Country:  Canada
      URL:  https://oarc.net  (Manual)
      Radio/Modem Type:  STM32-DVM (USB)
      Node Type:  Public
      DMR Access List:  blank
      APRS Host Enable:  Off
      APRS Host:  noam.aprs2.net
      System Time Zone:  UTC
      Dashboard Language:  english_us

    DMR Configuration
      DMR Master:  DMRGateway
      BrandMeister Master:  BM_3021_Canada
      BM Hotspot Security:  blank
      BrandMeister Network ESSID:  None
      BrandMeister Network Enable:  On
      DMR+ Master:  DMR+_IPSC2-Canada
      DMR+ Network:  blank
      DMR+ Network ESSID:  None
      DMR+ Network Enable:  Off
      XLX Master:  196
      XLX Startup Module:  B
      XLX Master Enable:  On
      DMR Color Code:  1
      DMR EmbeddedLCOnly:  Off
      DMR DumpTAData:  Off

    Mobile GPS Configuration
      MobileGPS Enable:  Off
      GPS Port:  /dev/tty/ACM0
      GPS Port Speed:  38400

    Firewall Configuration
      Dashboard Access:  Private
      ircDDBGateway Remote:  Private
      SSH Access:  Private
      Auto AP:  On
      uPNP:  On


Firmware and CPS
----------------

* https://www.farnsworth.org/dale/codeplug/editcp/  main page for Editcp
* https://github.com/DaleFarnsworth-DMR  source code for editcp, dmrRadio, libraries, etc.
* https://dm3mat.darc.de/qdmr/  main page for qdmr
* https://github.com/hmatuschek/qdmr  source code for qdmr
* https://opengd77.com/viewtopic.php?f=18&t=2002  replacement firmware for Retevis RT90 / TYT MD-9600
* https://opengd77.com/viewtopic.php?f=12&t=1486
* https://m17project.org/  main page for M17 Project
* https://openrtx.org/#/  main page for OpenRTX
* https://github.com/OpenRTX  OpenRTX firmware, dmrconfig tool, etc.
* https://github.com/open-ham/OpenGD77  clone of closed-source (ironic) OpenGD77 project
* https://github.com/LibreDMR/OpenGD77_UserGuide/blob/master/OpenGD77_User_Guide.md  user guide for OpenGD77
* http://md380.org/  main page for MD-380 Tools
* https://github.com/travisgoodspeed/md380tools  source code for MD-380 Tools
* https://raw.githubusercontent.com/tylert/pocorgtfo/gh-pages/pocorgtfo10.pdf  reverse-engineering info
* https://www.pistar.uk/index.php  main page for Pi-Star


Other Links
-----------

* https://shapeshed.com/jq-json/
* https://programminghistorian.org/en/lessons/json-and-jq
* https://stackoverflow.com/questions/19529688/how-to-merge-2-json-objects-from-2-files-using-jq


Events
------


Tall Pines Rally / Rally of the Tall Pines
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Happens on the 3rd or 4th weekend in November.

* Volunteer info: TBD
* Official site: `Tall Pines`_

.. _Tall Pines: http://tallpinesrally.com
