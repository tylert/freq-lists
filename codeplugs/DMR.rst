DMR Repeaters
=============


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
    VA3DGN -> 434.100+
    VA3VXN -> 434.200+

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


Repeaters and Transcoding
-------------------------

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
