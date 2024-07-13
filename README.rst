freq-lists
==========

This information is intended purely for educational purposes.  It is your
responsibility to ensure that you and your equipment are behaving themselves
properly.


Requirements
------------

You must have the following tools installed:

* (REQUIRED) Python 3.10.x or newer;  for using the "multi_outputter.py" script for processing the input data files
* (REQUIRED) gojq_;  for working with JSON payloads
* (REQUIRED) dmrRadio_ binary 1.0.23 or newer;  for exporting/importing codeplugs to/from JSON and generating blank codeplugs
* (SUGGESTED) editcp_ 1.0.23 or newer;  for further editing codeplugs
* (SUGGESTED) LibreOffice_;  for creating PDF handouts to accompany the programmed data

.. _gojq: https://github.com/itchyny/gojq
.. _dmrRadio: https://github.com/dalefarnsworth-dmr/dmrRadio
.. _editcp: https://github.com/dalefarnsworth-dmr/editcp
.. _LibreOffice: https://www.libreoffice.org/

There are some really good programming tutorials at
https://youtu.be/VExx628R0DM and https://youtu.be/Lw0Y-jQZMZ0 which are useful
for learning about the digital side of things.


Running Things
--------------

::

    # Initial setup
    make && source .venv/bin/activate

    # Create data in a format that might be useful to other folks
    ./scripts/generate_csv.sh

    # Create new codeplugs for mobile and handheld radios
    ./scripts/fetch_db.sh
    ./scripts/generate_rdt.sh
    ./scripts/personalize_rdt.sh

    # Write data to the radios
    # dmrRadio writeMD2017Users tmp/filtered.csv  # if radio is Retevis RT90
    # dmrRadio writeUV380Users tmp/filtered.csv   # if radio is Retevis RT3S
    # dmrRadio writeCodeplug tmp/foo.rdt


Radio Programming Kiosks
------------------------

Debian-based distros (Debian, Ubuntu, Raspberry Pi OS, etc.), on x86 and ARM::

    # Don't use the go provided by the OS as it is super old and crappy!!!
    # Fetch an appropriate tarball from https://go.dev/dl/
    sudo tar -C /usr/local -xvfz ${GO_TARBALL}

    sudo apt-get --yes install git libusb-1.0-0-dev
    git clone https://github.com/dalefarnsworth-dmr/dmrRadio && cd dmrRadio
    go build

Arch-based distros (Arch Linux, etc.), on x86 and ARM::

    sudo pacman --no-confirm --sync gcc git go libusb pkgconf
    git clone https://github.com/dalefarnsworth-dmr/dmrRadio && cd dmrRadio
    go build

macOS, on x86 and ARM::

    brew install go git libusb
    git clone https://github.com/dalefarnsworth-dmr/dmrRadio && cd dmrRadio
    go build

Windows users should probably just go fetch the pre-built (x86) binaries
directly from
https://www.farnsworth.org/dale/codeplug/dmrRadio/downloads/windows/ and
https://www.farnsworth.org/dale/codeplug/editcp/downloads/windows/.


Converting Existing Codeplugs To Templates
------------------------------------------

::

    # Export the binary codeplug as JSON and fix some values
    dmrRadio codeplugToJSON codeplug.rdt before.json
    gojq --from-file Retevis_RT3S.jq before.json > after.json


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


Starting a New Codeplug
-----------------------

::

    # Create a brand new, empty codeplug
    dmrRadio newCodeplug -model RT3S -freq "400-480_136-174" new.rdt

    # Make it even emptier still
    dmrRadio codeplugToJSON new.rdt new.json
    cat new.json \
        | gojq 'del(.Contacts[])' \
        | gojq 'del(.Channels[])' \
        | gojq 'del(.GroupLists[])' \
        | gojq 'del(.ScanLists[])' \
        | gojq 'del(.Zones[])' > empty.json


DFU Mode
--------

Retevis RT90 DFU mode uses orange emergency button + P1 + plug-in "hard" power
(ignore "soft" power button).

Retevis RT3S DFU mode uses top side key + PTT + twist power knob.

* https://www.retevissolutions.com/rt90-dmr-radio
* https://www.retevissolutions.com/rt3s-dmr-radio#A9110F
* http://miklor.com/COM/Review_MD9600.php
* http://miklor.com/COM/Review_UV380.php
* https://www.amateurradio.com/mobile-dc-power-one-fuse-or-two/
* http://www.emrg.ca/EMRG-412_12VDC_for_the_Radio_Amateur.pdf


Talkgroups
----------

* https://wiki.brandmeister.network/index.php/TalkGroup/98638  WVNET
* https://wirelessvillage.ninja
* https://rfhackers.com


Hotspots and Tuning
-------------------

::

    VE3YXY -> 445.225

* https://www.ailunce.com/blog/Set-up-MMDVM-DMR-Hotspot-to-work-with-Ailunce-HD1
* https://www.ailunce.com/blog/How-to-set-Rx-Tx-Offset
* https://github.com/VR2VYE/MMDVM_HS_firmware
* https://github.com/g4klx/MMDVMHost/pull/90
* https://amateurradionotes.com/pi-star.htm
* https://riku.titanix.net/wordpress/dmr/mmdvm-ber-error-rate-tuning/
* https://www.f5uii.net/en/installation-calibration-adjustment-tunning-mmdvm-mmdvmhost-raspberry-motorola-gm360/5/


Admit Criteria determines when your radio is allowed to transmit.  The
recommended setting for repeater channels is Color Code Free; this configures
your radio to be polite to your own digital system.  You should configure your
In Call Criteria to Follow Admit Criteria.  Simplex channels should be
configured as Always for both Admit Criteria and Always or Follow TX for In
Call Criteria.


Linking and Transcoding and Repeater Building
---------------------------------------------

* https://n5amd.com/digital-radio-how-tos/build-digital-voice-transcoding-server/
* https://g0wcz.nodestone.io/building-a-transcoder-for-dmr-d-star/
* https://ad6dm.net/log/wp-content/uploads/2019/05/How-to-Create-a-Multimode-Digital-Voice-Reflector.pdf
* https://www.chrishoodblog.com/building-a-dmr-repeater-using-bridgecom-mobiles-pt1/
* https://www.chrishoodblog.com/make-your-own-dmr-server/
* https://sin.groups.io/g/main/message/355
* https://blog.rosenberg-watt.com/2018/08/14/towards-better-global-dmr-ham-radio-id-generation/
* https://tgifnetwork.createaforum.com/hotspot-configurartion/adding-second-hotspot-do-i-need-a-second-dmr-id/
* https://dxcanada.ca/dvstick33-by-dvmega-3-channel-transcoding-for-xlx-systems/
* https://www.dvmega.nl/dvstick30/
* https://github.com/formatc1702/WireViz
* https://maxonamerica.com/download/tm-8000-spec-sheet
* https://maxonamerica.com/product/tm-8000-series-mobile-radio
* https://www.fleetwooddp.com
* https://www.repeater-builder.com/products/stm32-dvm.html
* http://www.masterscommunications.com/products/radio-adapter/ra-index.html
* http://www.masterscommunications.com/products/radio-adapter/ra42.html
* http://www.masterscommunications.com/products/radio-adapter/ra40.html
* http://www.masterscommunications.com/products/radio-adapter/ra35.html
* https://www.repeater-builder.com/products/usb-rim.html
* https://www.repeater-builder.com/products/usb-rim-lite.html
* https://www.arkcorporation.us/blogs/news/48712645-cool-diy-battery-box-on-reddit
* https://www.amazon.ca/Pyramid-PSV300-Heavy-duty-Switching-Supply/dp/B000NPT4TK
* https://www.amazon.com/Universal-Regulated-Benchtop-Converter-Terminals/dp/B09Y1H6C25

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
      XLX Master:  197
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
* https://github.com/dalefarnsworth-dmr  source code for editcp, dmrRadio, libraries, etc.
* https://dm3mat.darc.de/qdmr/  main page for qdmr
* https://github.com/hmatuschek/qdmr  source code for qdmr
* https://opengd77.com/viewtopic.php?f=18&t=2002  replacement firmware for Retevis RT90 / TYT MD-9600
* https://opengd77.com/viewtopic.php?f=19&t=2380  replacement firmware for the Retevis RT3S / TYT MD-UV380
* https://opengd77.com/viewtopic.php?f=12&t=1486  new firmware can't use the same CPS
* https://opengd77.com/viewtopic.php?f=18&t=3040  RT90 remote head
* https://m17project.org/  main page for M17 Project
* https://openrtx.org/#/  main page for OpenRTX
* https://github.com/OpenRTX  OpenRTX firmware, dmrconfig tool, etc.
* https://github.com/open-ham/OpenGD77  clone of closed-source (ironic) OpenGD77 project
* https://github.com/LibreDMR/OpenGD77_UserGuide/blob/master/OpenGD77_User_Guide.md  user guide for OpenGD77
* https://twitter.com/m17_project/status/1535977213111242753  FM and M17 living together like cats and dogs
* http://md380.org/  main page for MD-380 Tools
* https://github.com/travisgoodspeed/md380tools  source code for MD-380 Tools
* https://raw.githubusercontent.com/tylert/pocorgtfo/gh-pages/pocorgtfo10.pdf  reverse-engineering info
* https://www.pistar.uk/index.php  main page for Pi-Star
* https://github.com/M17-Project/Module_17  M17 smart mic


DMR SMS
-------

::

    Send a SMS message to the APRS destination (310999 in North America) with the following body...

    SMSGTE @<phone number> <message content>

    After a few moments you will receive an ACK message and the recipient will get a text message.

    To have someone reply to you, send a text message to the number that sent you the text with the body...

    @<callsign> <message content>

    After a few moments you should receive a message on your radio!


Other Links
-----------

* https://www.dmrfordummies.com/library/  what is DMR?


Maps
----

* https://plus.codes/map
* https://en.wikipedia.org/wiki/Open_Location_Code
* https://github.com/google/open-location-code
* https://github.com/google/open-location-code/wiki/Evaluation-of-Location-Encoding-Systems
* https://www.kschaul.com/post/2023/02/16/how-the-post-is-replacing-mapbox-with-open-source-solutions/


Tall Pines Rally / Rally of the Tall Pines
------------------------------------------

Happens on the 3rd or 4th weekend in November.

* Volunteer info: TBD
* Official site: `Tall Pines`_

.. _Tall Pines: http://tallpinesrally.com
