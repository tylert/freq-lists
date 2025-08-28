freq-lists
==========

This information is intended purely for educational purposes.  It is your
responsibility to ensure that you and your equipment are behaving themselves
properly.


Requirements
------------

You must have the following tools installed:

* (REQUIRED) Python 3.10.x or newer;  for using the "multi_outputter.py" script for processing the input data files
* (REQUIRED) gojq_;  for working with JSON and YAML payloads
* (OPTIONAL) yq_;  for working with JSON and YAML payloads
* (REQUIRED) dmrRadio_ binary 1.0.23 or newer;  for exporting/importing codeplugs to/from JSON and generating blank codeplugs
* (SUGGESTED) editcp_ 1.0.23 or newer;  for further editing codeplugs
* (SUGGESTED) LibreOffice_;  for creating PDF handouts to accompany the programmed data

.. _gojq: https://github.com/itchyny/gojq
.. _yq: https://mikefarah.gitbook.io/yq
.. _dmrRadio: https://github.com/dalefarnsworth-dmr/dmrRadio
.. _editcp: https://github.com/dalefarnsworth-dmr/editcp
.. _LibreOffice: https://libreoffice.org


Running Things
--------------

::

    # Initial setup
    make && source .venv/bin/activate

    # Create and upload new codeplugs
    ./scripts/generate_rdt.sh     # create generic codeplugs for anybody
    ./scripts/personalize_rdt.sh  # create specific codeplugs for my radios
    dmrRadio writeCodeplug tmp/foo.rdt          # upload a single codeplug

    # Fetch and upload new contacts
    ./scripts/fetch_db.sh         # download a bunch of fresh contacts
    dmrRadio writeMD2017Users tmp/filtered.csv  # if radio is Retevis RT90
    dmrRadio writeUV380Users tmp/filtered.csv   # if radio is Retevis RT3S

    # Produce data in a format useful for analog radios
    ./scripts/generate_csv.sh  # create programming data for analog radios


Radio Programming Kiosks
------------------------

Arch-based distros (Arch Linux, EndeavourOS, etc.), on x86 and ARM::

    sudo pacman --no-confirm --sync gcc git go libusb pkgconf
    git clone https://github.com/dalefarnsworth-dmr/dmrRadio && cd dmrRadio
    go build

Debian-based distros (Debian, Ubuntu, Raspberry Pi OS, etc.), on x86 and ARM::

    # Don't use the go provided by the OS as it is super old
    # Fetch an appropriate tarball from https://go.dev/dl
    # Install the contents of the tarball somewhere convenient
    sudo tar -C /usr/local -xvfz ${GO_TARBALL}

    sudo apt-get --yes install git libusb-1.0-0-dev
    git clone https://github.com/dalefarnsworth-dmr/dmrRadio && cd dmrRadio
    go build

macOS, on x86 and ARM::

    brew install git go libusb
    git clone https://github.com/dalefarnsworth-dmr/dmrRadio && cd dmrRadio
    go build

Windows users should probably just go fetch the pre-built (x86) binaries
directly from
https://farnsworth.org/dale/codeplug/dmrRadio/downloads/windows and
https://farnsworth.org/dale/codeplug/editcp/downloads/windows.


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
    cat << EOF > VA3DGN.json
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
    dmrRadio newCodeplug -model RT3S -freq '400-480_136-174' new.rdt

    # Make it even emptier still
    dmrRadio codeplugToJSON new.rdt new.json
    cat new.json \
        | gojq 'del(.Contacts[])' \
        | gojq 'del(.Channels[])' \
        | gojq 'del(.GroupLists[])' \
        | gojq 'del(.ScanLists[])' \
        | gojq 'del(.Zones[])' > empty.json


Radio Specific Info
-------------------

Retevis RT90 DFU mode uses orange emergency button + P1 + plug-in "hard" power
(ignore "soft" power button).

Retevis RT3S DFU mode uses top side key + PTT + twist power knob.

* https://retevissolutions.com/rt90-dmr-radio
* https://retevissolutions.com/rt3s-dmr-radio#A9110F
* https://miklor.com/COM/Review_MD9600.php
* https://miklor.com/COM/Review_UV380.php
* https://amateurradio.com/mobile-dc-power-one-fuse-or-two
* http://emrg.ca/EMRG-412_12VDC_for_the_Radio_Amateur.pdf
* https://forum.digirig.net/t/tyt-md-380uv-cable-and-support/2708/7  cable info for RT90 and RT3S
* https://github.com/M17-Project/LinHT-hw  possible replacement mainboard for Retevis C62 handheld (dual-band, non-waterproof)
* https://m17project.org/2025/07/26/an-update-on-linht-openht-v2-development-process
* https://retevis.com/products/retevis-c62-5-w-long-range-uv-dual-band-ai-noise-reducation-business-radio-us
* https://trull.org/alex/pubmirror/robrobinette.com/Ham_VHF-UHF_Digital_Modes.htm


Talkgroups
----------

* https://wiki.brandmeister.network/index.php/TalkGroup/98638  WVNET = DMR 98638
* https://rfhackers.com  WVNET = DMR 98638
* http://farc.ysfreflector.ca  FRG = YSF 43567


Hotspots and Tuning
-------------------

* https://ailunce.com/blog/Set-up-MMDVM-DMR-Hotspot-to-work-with-Ailunce-HD1
* https://ailunce.com/blog/How-to-set-Rx-Tx-Offset
* https://github.com/VR2VYE/MMDVM_HS_firmware
* https://github.com/g4klx/MMDVMHost/pull/90
* https://amateurradionotes.com/pi-star.htm
* https://riku.titanix.net/wordpress/dmr/mmdvm-ber-error-rate-tuning
* https://f5uii.net/en/installation-calibration-adjustment-tunning-mmdvm-mmdvmhost-raspberry-motorola-gm360/5
* https://dl6fz.info/digital-modes-vhf-uhf/m17-analog-hotspot-gateway
* https://lyonscomputer.com.au/Digital-Modes/M17/M17-Analog-Hotpot-Gateway/M17-Analog-Hotpot-Gateway.html
* https://github.com/n7tae/ham-dht-tools  make-m17-host-file CLI tool, among others
* https://m17project.org/2025/07/27/web-interface-for-the-cc1200-hotspot
* https://github.com/jancona/m17  M17Gateway in Go
* https://bradmc.com/articles/life-with-dmr-talker-alias
* https://mrickey.com/2018/02/07/talker-alias-on-brandmeister
* https://wiki.brandmeister.network/index.php/Talker_Alias

::

    Admit Criteria determines when your radio is allowed to transmit.  The
    recommended setting for repeater channels is Color Code Free; this configures
    your radio to be polite to your own digital system.  You should configure your
    In Call Criteria to Follow Admit Criteria.  Simplex channels should be
    configured as Always for both Admit Criteria and Always or Follow TX for In
    Call Criteria.


Dual Capacity Direct Mode / Single Frequency Repeater
-----------------------------------------------------

* https://docdroid.com/hlxgIXh/hrivol30125-pdf#page=18  article explaining DMR DCDM and DMO SFR modes
* https://www.zeroretries.org  loads of articles relating to "TDD SFR" (mandatory "www" in URL here)
* https://cwh050.mywikis.wiki/wiki/Dual_Capacity_Direct_Mode
* https://forum.pistar.uk/viewtopic.php?t=4718
* https://k5rwk.org/2025/03/23/how-to-program-your-dmr-radio-for-the-balloon-single-frequency-repeater
* https://techwholesale.com/what-is-dual-capacity-direct-mode
* https://mojaverepeater.com/blog/portable-dmr-single-frequency-repeater


Linking and Transcoding and Repeater Building
---------------------------------------------

* https://w0chp.radio/wpsd
* https://n5amd.com/digital-radio-how-tos/build-digital-voice-transcoding-server
* https://g0wcz.nodestone.io/building-a-transcoder-for-dmr-d-star
* https://ad6dm.net/log/wp-content/uploads/2019/05/How-to-Create-a-Multimode-Digital-Voice-Reflector.pdf
* https://sin.groups.io/g/main/message/355
* https://blog.rosenberg-watt.com/2018/08/14/towards-better-global-dmr-ham-radio-id-generation
* https://tgifnetwork.createaforum.com/hotspot-configurartion/adding-second-hotspot-do-i-need-a-second-dmr-id
* https://dxcanada.ca/dvstick33-by-dvmega-3-channel-transcoding-for-xlx-systems
* https://dvmega.nl/dvstick30
* https://github.com/formatc1702/WireViz
* https://maxonamerica.com/product-category/mobile-radios  MDM-4000 series (supports SFR too), TM-8000 series, etc.
* https://masterscommunications.com/products/radio-adapter/ra-features.html  differences between the boards
* https://masterscommunications.com/products/radio-adapter/ra42.html  amplified Tx audio
* https://masterscommunications.com/products/radio-adapter/ra33.html  not amplified Tx audio
* https://masterscommunications.com/products/mux/mux25.html
* https://repeater-builder.com/products/stm32-dvm.html
* https://repeater-builder.com/products/usb-rim.html
* https://repeater-builder.com/products/usb-rim-lite.html
* https://repeater-builder.com/voip/pdf/allstar-newbie-guide.pdf
* https://repeater-builder.com/projects/fob/startech-syba-fob.html  WB2EDV pinouts (STM32-DVM, RA-33, RA-42, etc.)
* https://arkcorporation.us/blogs/news/48712645-cool-diy-battery-box-on-reddit
* https://amazon.ca/Pyramid-PSV300-Heavy-duty-Switching-Supply/dp/B000NPT4TK
* https://amazon.com/Universal-Regulated-Benchtop-Converter-Terminals/dp/B09Y1H6C25
* https://themodernham.com/host-a-ysf-dmr-dstar-c4fm-multi-mode-reflector-on-ubuntu-22-04-or-debian-12-with-xlx
* https://ad6dm.net/log/2019/02/how-to-create-a-multi-mode-xreflector
* https://github.com/USA-RedDragon/DMRHub  self-hosted DMR master server?
* https://n3emc.com/hblink-dmr-server-how-to-set-it-up-for-a-private-dmr-server
* https://github.com/juribeparada/MMDVM_CM
* https://qsl.net/w2ymm/cdm_rim_maxtrac_rm.html  programming notes for CDM, Maxtrac radios
* https://dvmproject.io
* https://dvmproject.readthedocs.io
* https://github.com/DVMProject
* https://store.w3axl.com/products/dvm-v1-duplex-modem
* https://store.w3axl.com/products/dvm-v24-v2-usb-converter-for-v-24-equipment
* https://wp.hamoperator.com/fusion/yaesu-repeater-lockup  DR-2X fixes?
* https://www.arcomcontrollers.com/index.php/adr-interface  DR-2X fixes?
* https://arcomcontrollers.com/documents/rc210/dr2x_adr_interface.pdf  DR-2X fixes?
* http://scomcontrollers.com/downloads/SCOM7330_Interface_DR2X.pdf  DR-2X fixes?  (mandatory "http" here)
* https://github.com/phastmike/IDx_hardware  DR-2X fixes?
* https://github.com/phastmike/IDx  DR-2X fixes?

::

    # CDM 750
    TxInvert=1
    RXInvert=0

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

* https://farnsworth.org/dale/codeplug/editcp  main page for Editcp
* https://github.com/dalefarnsworth-dmr  source code for editcp, dmrRadio, libraries, etc.
* https://dm3mat.darc.de/qdmr  main page for qdmr
* https://github.com/hmatuschek/qdmr  source code for qdmr
* https://github.com/g4eml/OpenMD9600_Remote_Head
* https://m17project.org  main page for M17 Project
* https://openrtx.org/#  main page for OpenRTX
* https://github.com/OpenRTX  OpenRTX firmware, dmrconfig tool, etc.
* https://github.com/open-ham/OpenGD77  clone of closed-source (ironic) OpenGD77 project
* https://github.com/LibreDMR/OpenGD77_UserGuide/blob/master/OpenGD77_User_Guide.md  user guide for OpenGD77
* https://twitter.com/m17_project/status/1535977213111242753  FM and M17 living together like cats and dogs
* http://md380.org  main page for MD-380 Tools
* https://github.com/travisgoodspeed/md380tools  source code for MD-380 Tools
* https://raw.githubusercontent.com/tylert/pocorgtfo/gh-pages/pocorgtfo10.pdf  reverse-engineering info
* https://pistar.uk/index.php  main page for Pi-Star
* https://github.com/M17-Project/Module_17  M17 smart mic
* https://www.randomwire.us/p/random-wire-review-issue-130  lots of good M17 discussions (mandatory "www" in URL here)


DMR SMS
-------

::

    Send a SMS message to the APRS destination (310999 in North America) with the following body...

    SMSGTE @<phone number> <message content>

    After a few moments you will receive an ACK message and the recipient will get a text message.

    To have someone reply to you, send a text message to the number that sent you the text with the body...

    @<callsign> <message content>

    After a few moments you should receive a message on your radio!


Emission Designators
--------------------

::

    General format
    --------------

    BBBB12345
               BBBB = bandwidth (letters "H", "K", "M", "G" take the place of the decimal)
               1 = type of modulation used for the main carrier, not including sub-carriers
               2 = type of modulating signal of the main carrier
               3 = type of information transmitted
               4 = (OPTIONAL) practical details of the transmitted information
               5 = (OPTIONAL) method of multiplexing

    Decoded meanings
    ----------------

    4K00.....  4.0 kHz bandwidth
    6K00.....  6.0 kHz bandwidth
    7K34.....  7.34 kHz bandwidth
    7K60.....  7.6 kHz bandwidth
    8K00.....  8.0 kHz bandwidth
    8K10.....  8.1 kHz bandwidth
    8K30.....  8.3 kHz bandwidth
    8K40.....  8.4 kHz bandwidth
    9K00.....  9.0 kHz bandwidth
    9K36.....  9.36 kHz bandwidth
    10K1.....  10.1 kHz bandwidth
    11K2.....  11.2 kHz bandwidth
    11K3.....  11.3 kHz bandwidth
    12K5.....  12.5 kHz bandwidth
    13K6.....  13.6 kHz bandwidth
    14K0.....  14.0 kHz bandwidth
    16K0.....  16.0 kHz bandwidth
    20K0.....  20.0 kHz bandwidth
    ..H......  some number of Hz bandwidth
    .H.......  some number of Hz bandwidth
    ..K......  some number of kHz bandwidth
    .K.......  some number of kHz bandwidth
    ..M......  some number of MHz bandwidth
    .M.......  some number of MHz bandwidth
    ..G......  some number of GHz bandwidth
    .G.......  some number of GHz bandwidth
    ....A....  Double-sideband amplitude modulation (e.g. AM broadcast radio)
    ....D....  Combination of AM and FM or PM
    ....F....  Frequency modulation (e.g. FM broadcast radio)
    ....G....  Phase modulation
    ....H....  Single-sideband modulation with full carrier (e.g. as used by CHU)
    ....J....  Single-sideband with suppressed carrier (e.g. Shortwave utility and amateur stations)
    ....W....  Combination of any of the above (for "Type of modulation")
    ....X....  None of the above (for "Type of modulation")
    .....1...  One channel containing digital information, no subcarrier
    .....2...  One channel containing digital information, using a subcarrier
    .....3...  One channel containing analog information
    .....7...  More than one channel containing digital information
    .....X...  None of the above (for "Type of modulating signal")
    ......A..  Aural telegraphy, intended to be decoded by ear, such as Morse code
    ......D..  Data transmission, telemetry or telecommand (remote control)
    ......E..  Telephony (voice or music intended to be listened to by a human)
    ......W..  Combination of any of the above (for "Type of transmitted information")
    ......X..  None of the above (for "Type of transmitted information")
    .......D.  Four-condition code, one condition per signal element
    .......J.  Commercial-quality sound (non-broadcast)
    .......X.  None of the above (for "Details of information")
    ........N  None used / Not multiplexed
    ........T  Time-division
    ........X  None of the above (for "Multiplexing")

    Actual examples
    ---------------

    6K00A3E    AM voice
    8K00F3E    FM voice           +-2.5 ppm stability;  fits in 12.5 kHz
    10K1F3E    FM voice           +-2.5 kHz deviation;  fits in 12.5 kHz
    11K2F3E    FM voice           +-2.5 kHz deviation;  fits in 12.5 kHz
    13K6F3E    FM voice           +-3.8 kHz deviation;  fits in 20 kHz
    16K0F3A    FM CW ID           +-4.0 kHz deviation;  fits in 20 kHz
    16K0F3E    FM voice           +-4.0 kHz deviation;  fits in 20 kHz
    20K0F3D    FM voice           +-5.0 kHz deviation;  fits in 25 kHz
    11K3F1D    POCSAG
    20K0F1D    POCSAG
    7K34FXDJN  DMR Tier2
    7K60FXD    DMR Tier2
    7K60FXDJN  DMR Tier2
    7K60FXE    DMR Tier2
    7K60FXW    DMR Tier2
    7K60F7W    DMR Tier3
    7K60F7WDT  DMR Tier3
    6K00F7W    DSTAR
    6K00F2A    DSTAR CW ID
    9K00F..    M17                4FSK;  9600 bps;  fits in 12.5 kHz
    4K00F1D    NXDN
    4K00F1E    NXDN
    4K00F1W    NXDN
    4K00F2D    NXDN
    4K00F7W    NXDN
    8K30F1D    NXDN
    8K30F1E    NXDN
    8K30F7W    NXDN
    8K00F1D    P25 Phase1 C4FM
    8K10F1D    P25 Phase1 C4FM
    8K10F1E    P25 Phase1 C4FM
    8K30F1W    P25 Phase1 C4FM
    8K40F1D    P25 Phase1 C4FM
    8K40F1E    P25 Phase1 C4FM
    9K80F1D    P25 Phase2 TDMA
    9K80F1E    P25 Phase2 TDMA
    9K36F1E    YSF C4FM
    9K36F7W    YSF C4FM
    11K2F7W    YSF C4FM
    12K5F7W    YSF C4FM
    16K0F1D    YSF C4FM
    16K0F2D    YSF C4FM
    20K0F7W    YSF C4FM

* https://en.wikipedia.org/wiki/Types_of_radio_emissions
* https://wiki.radioreference.com/index.php/Emission_Designator
* https://hfunderground.com/wiki/index.php/Emission_Designator
* https://spec.m17project.org/files/M17_spec.pdf
* https://sigidwiki.com/wiki/APRS
* https://sigidwiki.com/wiki/PACKET  AX.25/APRS
* https://sigidwiki.com/wiki/POCSAG
* `https://sigidwiki.com/wiki/Amplitude_Modulation_(AM)`
* https://sigidwiki.com/wiki/NFM_Voice
* `https://sigidwiki.com/wiki/Digital_Mobile_Radio_(DMR)`
* https://sigidwiki.com/wiki/D-STAR
* https://sigidwiki.com/wiki/LoRa
* https://sigidwiki.com/wiki/M17_RF_Protocol
* `https://sigidwiki.com/wiki/Next_Generation_Digital_Narrowband_(NXDN)`
* https://sigidwiki.com/wiki/NXDN
* `https://sigidwiki.com/wiki/Project_25_(P25)`
* https://sigidwiki.com/wiki/P25
* https://sigidwiki.com/wiki/Yaesu_System_Fusion
* https://en.wikipedia.org/wiki/Automatic_Packet_Reporting_System
* https://en.wikipedia.org/wiki/AX.25
* https://en.wikipedia.org/wiki/Digital_mobile_radio
* https://en.wikipedia.org/wiki/D-STAR
* https://en.wikipedia.org/wiki/LoRa
* `https://en.wikipedia.org/wiki/M17_(amateur_radio)`
* https://en.wikipedia.org/wiki/NXDN
* https://en.wikipedia.org/wiki/Project_25
* `https://en.wikipedia.org/wiki/Yaesu_(brand)#Digimode_%22Fusion%22`


Other Links
-----------

* https://dmrfordummies.com/library  what is DMR?
* https://dmrtechnet.net/monday-night-march-31st-the-dmr-tech-net-team-will-go-over-and-discuss-codeplug-best-practices-for-organizing-your-channels-zones-talkgroups
* https://jeffreykopcak.com/2017/05/10/dmr-in-amateur-radio-terminology
* https://youtu.be/VExx628R0DM
* https://youtu.be/Lw0Y-jQZMZ0
* https://en.wikipedia.org/wiki/PACE_(communication_methodology)  "layered" communications strategy?


Maps
----

* https://plus.codes/map
* https://en.wikipedia.org/wiki/Open_Location_Code
* https://github.com/google/open-location-code
* https://github.com/google/open-location-code/wiki/Evaluation-of-Location-Encoding-Systems
* https://kschaul.com/post/2023/02/16/how-the-post-is-replacing-mapbox-with-open-source-solutions
