DMR Repeaters
=============

You can join XLX196_ using TS=2, TG=6 via the linked repeaters.

* 302064, VE3STP, 443.600+, CC=1
* 302065, VA3ODG_, 444.850+, CC=1
* 302070, VA3AAR_, 145.550-, CC=1
* 302093, VE2CRA, 444.400+, CC=1
* 302096, VE3STP, 147.060-, CC=1
* 302108, VE3HOZ, 442.300+, CC=1
* 302117, VE3RAM_, 443.700+, CC=1

.. _XLX196: https://xrf196.spdns.org/
.. _VA3AAR: http://va3aar.dyndns.org:3026/
.. _VA3ODG: http://va3odg.ddns.net:380/
.. _VE3RAM: http://ve3ram.ddns.net:380/


Talkgroups
----------

* 302;  Canada
* 3023;  Ontario
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


Hotspots
--------

::

    VE3YXY -> 445.225
    VA3DGN -> 434.100+
    VA3VXN -> 434.200+

* https://www.ailunce.com/blog/Set-up-MMDVM-DMR-Hotspot-to-work-with-Ailunce-HD1
* https://www.ailunce.com/blog/How-to-set-Rx-Tx-Offset
* https://github.com/VR2VYE/MMDVM_HS_firmware


Admit Criteria The  Admit  Criteria  determines  when  your  radio  is  allowed
to  transmit.  The recommended setting for repeater channels is Color Code
Free; this configures  your  radio  to  be  polite  to  your  own  digital
system.    You  should configure your In Call Criteria to Follow Admit
Criteria. Simplex channels  should  be  configured  as  Always  for  both
Admit  Criteria  and  Always or Follow TX for In Call Criteria.


Repeaters and Transcoding
-------------------------

* https://www.chrishoodblog.com/building-a-dmr-repeater-using-bridgecom-mobiles-pt1/
* https://www.alibaba.com/product-detail/VHF-UHF-FM-Repeater-Base-Units_592290636.html?spm=a2700.details.maylikeexp.6.37a168cdQOVPda
* https://www.chrishoodblog.com/make-your-own-dmr-server/
