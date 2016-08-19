GMRS/FRS
========

In Canada, using GMRS-FRS_ does not require a license.

Designated GMRS-only and GMRS-hybrid frequencies use a +/-5 ppm frequency
deviation while designated FRS-only frequencies use +/-2.5 ppm deviation.  A 25
kHz channel width translates to a +/-5 ppm frequency deviation.  A 12.5 kHz
channel width translates to a +/-2.5 ppm frequency deviation.

.. _GMRS-FRS: https://en.wikipedia.org/wiki/General_Mobile_Radio_Service

Frequencies
-----------

The following is a list of possible channel values for interoperability with
other brands of radios (scheme A is the most common one)::

    Channel             Freq      Pwr  Bw  Notes
    A    B    C    D    MHz       W    kHz
    01   01   09   01   462.5625  2.0  25  FRS/GMRS Calling Channel
    02   02   10   02   462.5875  2.0  25  FRS/GMRS Geocaching Channel
    03   03   11   03   462.6125  2.0  25  FRS/GMRS
    04   04   12   04   462.6375  2.0  25  FRS/GMRS
    05   05   13   05   462.6625  2.0  25  FRS/GMRS
    06   06   14   06   462.6875  2.0  25  FRS/GMRS
    07   07   15   07   462.7125  2.0  25  FRS/GMRS
    08   08   --   08   467.5625  0.5  12  FRS
    09   09   --   09   467.5875  0.5  12  FRS
    10   10   --   10   467.6125  0.5  12  FRS
    11   11   --   11   467.6375  0.5  12  FRS
    12   12   --   12   467.6625  0.5  12  FRS
    13   13   --   13   467.6875  0.5  12  FRS
    14   14   --   14   467.7125  0.5  12  FRS
    15   15   01   15   462.5500  2.0  25  GMRS
    16   16   02   16   462.5750  2.0  25  GMRS
    17   17   03   17   462.6000  2.0  25  GMRS
    18   18   04   18   462.6250  2.0  25  GMRS
    19   19   05   19   462.6500  2.0  25  GMRS Do not use near Canada/USA border
    20   20   06   20   462.6750  2.0  25  GMRS Distress Channel (141.3Hz)
    21   21   07   21   462.7000  2.0  25  GMRS Do not use near Canada/USA border
    22   22   08   22   462.7250  2.0  25  GMRS
    --   15R  --   --   467.5500  5.0  25  US GMRS Ch 15 Repeater Input
    --   16R  --   --   467.5750  5.0  25  US GMRS Ch 16 Repeater Input
    --   17R  --   --   467.6000  5.0  25  US GMRS Ch 17 Repeater Input
    --   18R  --   --   467.6250  5.0  25  US GMRS Ch 18 Repeater Input
    --   19R  --   --   467.6500  5.0  25  US GMRS Ch 19 Repeater Input
    --   20R  --   --   467.6750  5.0  25  US GMRS Ch 20 Repeater Input Distress Channel
    --   21R  --   --   467.7000  5.0  25  US GMRS Ch 21 Repeater Input
    --   22R  --   --   467.7250  5.0  25  US GMRS Ch 22 Repeater Input
    --   --   --   23   462.5625  5.0  25  Proprietary pseudo-channel Ch 01 + Fixed CTCSS 250.3Hz (038)
    --   --   --   24   462.6125  5.0  25  Proprietary pseudo-channel Ch 03 + Fixed CTCSS 225.7Hz (035)
    --   --   --   25   462.6625  5.0  25  Proprietary pseudo-channel Ch 05 + Fixed CTCSS 203.5Hz (032)
    --   --   --   26   462.7125  5.0  25  Proprietary pseudo-channel Ch 07 + Fixed CTCSS 179.9Hz (029)
    --   --   --   27   462.5500  5.0  25  Proprietary pseudo-channel Ch 15 + Fixed CTCSS 162.2Hz (026)
    --   --   --   28   462.6000  5.0  25  Proprietary pseudo-channel Ch 17 + Fixed CTCSS 146.2Hz (023)
    --   --   --   29   462.6500  5.0  25  Proprietary pseudo-channel Ch 19 + Fixed CTCSS 131.8Hz (020)
    --   --   --   30   462.7000  5.0  25  Proprietary pseudo-channel Ch 21 + Fixed CTCSS 118.9Hz (017)
    --   --   --   31   462.5875  5.0  25  Proprietary pseudo-channel Ch 02 + Fixed DCS 023 (001)
    --   --   --   32   462.6375  5.0  25  Proprietary pseudo-channel Ch 04 + Fixed DCS 031 (004)
    --   --   --   33   462.6875  5.0  25  Proprietary pseudo-channel Ch 06 + Fixed DCS 047 (007)
    --   --   --   34   467.5625  0.5  12  Proprietary pseudo-channel Ch 08 + Fixed DCS 065 (010)
    --   --   --   35   467.6125  0.5  12  Proprietary pseudo-channel Ch 10 + Fixed DCS 073 (013)
    --   --   --   36   467.6625  0.5  12  Proprietary pseudo-channel Ch 12 + Fixed DCS 115 (016)
    --   --   --   37   467.7125  0.5  12  Proprietary pseudo-channel Ch 14 + Fixed DCS 131 (019)
    --   --   --   38   462.5750  5.0  25  Proprietary pseudo-channel Ch 16 + Fixed DCS 143 (022)
    --   --   --   39   462.6250  5.0  25  Proprietary pseudo-channel Ch 18 + Fixed DCS 156 (025)
    --   --   --   40   462.6750  5.0  25  Proprietary pseudo-channel Ch 20 + Fixed DCS 172 (028)
    --   --   --   41   462.7250  5.0  25  Proprietary pseudo-channel Ch 22 + Fixed DCS 223 (031)
    --   --   --   42   462.5625  5.0  25  Proprietary pseudo-channel Ch 01 + Fixed CTCSS 107.2Hz (014)
    --   --   --   43   46?.????  ?.?  ??  Proprietary pseudo-channel Ch ?? + ??
    --   --   --   44   46?.????  ?.?  ??  Proprietary pseudo-channel Ch ?? + ??
    --   --   --   45   46?.????  ?.?  ??  Proprietary pseudo-channel Ch ?? + ??
    --   --   --   46   46?.????  ?.?  ??  Proprietary pseudo-channel Ch ?? + ??
    --   --   --   47   46?.????  ?.?  ??  Proprietary pseudo-channel Ch ?? + ??
    --   --   --   48   46?.????  ?.?  ??  Proprietary pseudo-channel Ch ?? + ??
    --   --   --   49   46?.????  ?.?  ??  Proprietary pseudo-channel Ch ?? + ??
    --   --   --   50   46?.????  ?.?  ??  Proprietary pseudo-channel Ch ?? + ??

.. note:: GMRS/FRS radios sold in Canada to not have any channels above 22 and
  are limited to 2.0 W ERP_.

.. _ERP: https://en.wikipedia.org/wiki/Effective_radiated_power


Privacy Codes
-------------

Privacy Codes used on GMRS may have a number of equivalent names.  The lower
numbered codes are typically analog and the higher numbered ones are typically
digital.  Rather than provide any kind of privacy, in reality they are all,
basically, a form of squelch_.  Some other_ forms of squelch are not used on
this service.

.. _squelch: http://www.repeater-builder.com/tech-info/ctcss/ctcss-overview.html
.. _other: https://en.wikipedia.org/wiki/Squelch


Analog
~~~~~~

Some equivalent names for the analog privacy codes:

* Call Guard
* Channel Guard or CG
* Continuous Tone-Coded Squelch or CTCSS_ (RS-220-A EIA)
* Electronic Tone Squelch or ETS, or, simply Tone Squelch
* Privacy Tone
* Private Line or PL (or TPL for "Tone PL")
* Quiet Call
* Quiet Channel or QC
* Quiet Tone

(All trademarks and registred trademarks are the property of their respective
owners.)

.. _CTCSS: https://en.wikipedia.org/wiki/Continuous_Tone-Coded_Squelch_System


CTCSS Encode vs CTCSS Decode
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

TODO


::

    Privacy Code             CTCSS  Notes
    A    B    C    D    E    Hz
    000  ---  000  000  ---  OFF
    ---  ---  ---  ---  ---  033.0
    ---  ---  ---  ---  ---  035.4
    ---  ---  ---  ---  ---  036.6
    ---  ---  ---  ---  ---  037.9
    ---  ---  ---  ---  ---  039.6
    ---  ---  ---  ---  ---  044.4
    ---  ---  ---  ---  ---  047.5
    ---  ---  ---  ---  ---  049.2
    ---  ---  ---  ---  ---  051.2
    ---  ---  ---  ---  ---  053.0
    ---  ---  ---  ---  ---  054.9
    ---  ---  ---  ---  ---  056.8
    ---  ---  ---  ---  ---  058.8
    ---  ---  ---  ---  ---  063.0
    001  001  001  001  ---  067.0  XZ/L1
    ---  ---  ---  ---  ---  067.1  XZ/L1 Alternate
    ---  ---  ---  002  ---  069.3  WZ
    ---  ---  002  ---  ---  069.4  WZ Alternate
    ---  ---  ---  ---  ---  071.0
    002  002  003  003  ---  071.9  XA/L2
    003  003  004  004  ---  074.4  WA
    ---  ---  ---  ---  ---  076.6  CT1
    004  004  005  005  A    077.0  XB/L3
    005  005  006  006  ---  079.7  WB/SP
    006  006  007  007  ---  082.5  YZ/L4
    ---  ---  ---  ---  ---  083.7  CT2
    007  007  008  008  ---  085.4  YA
    008  008  009  009  B    088.5  YB/L4A
    ---  ---  ---  ---  ---  090.0  CT3
    009  009  010  010  ---  091.5  ZZ
    010  010  011  011  ---  094.8  ZA/L5
    ---  ---  ---  ---  ---  096.6
    ---  ---  ---  ---  ---  097.3  CT4
    011  011  012  012  C    097.4  ZB
    ---  ---  ---  ---  ---  098.1
    012  012  013  013  ---  100.0  1Z
    013  013  014  014  ---  103.5  1A
    ---  ---  ---  ---  ---  105.9  CT0
    014  014  015  015  D    107.2  1B
    015  015  016  016  ---  110.9  2Z
    016  016  017  017  ---  114.8  2A
    ---  ---  ---  ---  ---  116.1  CT5
    017  017  018  018  E    118.8  2B
    018  018  019  019  ---  123.0  3Z
    019  019  020  020  F    127.3  3A
    ---  ---  ---  ---  ---  128.6  CT6
    020  020  021  021  ---  131.8  3B
    021  021  022  022  G    136.5  4Z
    ---  ---  ---  ---  ---  138.5  CT7
    022  022  023  023  ---  141.3  4A
    023  023  024  024  ---  146.2  4B
    ---  ---  ---  ---  ---  150.0
    024  024  025  025  ---  151.4  5Z
    025  025  026  026  ---  156.7  5A
    ---  ---  027  027  ---  159.8
    026  026  028  028  ---  162.2  5B
    ---  ---  029  ---  ---  165.5
    027  027  030  029  ---  167.9  6Z
    ---  ---  031  ---  ---  171.3
    028  028  032  030  ---  173.8  6A
    ---  ---  033  ---  ---  177.3
    029  029  034  031  ---  179.9  6B
    ---  ---  035  032  ---  183.5
    030  030  036  033  ---  186.2  7Z
    ---  ---  037  034  ---  189.9
    031  031  038  035  ---  192.8  7A
    ---  ---  ---  036  ---  196.6
    ---  000  ---  037  ---  199.5
    032  032  ---  038  ---  203.5  M1
    ---  ---  ---  039  ---  206.5  8Z
    033  033  ---  040  ---  210.7  M2
    ---  ---  ---  ---  ---  213.8
    034  034  ---  041  ---  218.1  M3
    ---  ---  ---  ---  ---  221.3
    035  035  ---  042  ---  225.7  M4
    ---  ---  ---  043  ---  229.1  9Z
    036  036  ---  044  ---  233.6  M5
    ---  ---  ---  ---  ---  237.1
    037  037  ---  045  ---  241.8  M6
    ---  ---  ---  ---  ---  245.5
    038  038  ---  046  ---  250.3  M7
    ---  ---  ---  047  ---  254.1  0Z/10Z


Digital
~~~~~~~

Some equivalent names for the digital privacy codes:

* Continuous Digital Coded Squelch System or CDCSS_
* Digital Channel Guard or DCG
* Digital Coded Squelch or DCS_
* Digital Private Line or DPL
* Digital Tone Coded Squelch or DTCS

(All trademarks and registred trademarks are the property of their respective
owners.)

.. _DCS: http://wiki.radioreference.com/index.php/DCS
.. _CDCSS: http://mmi-comm.tripod.com/dcs.html

::

    Privacy Code   DCS
    A    B    C    Value/Polarity
    000  000  000  OFF
    ---  ---  ---  006N
    ---  ---  ---  007N
    ---  ---  ---  015N
    ---  ---  ---  017N
    ---  ---  ---  021N
    039  039  001  023N
    040  040  002  025N
    041  041  003  026N
    042  042  004  031N
    043  043  005  032N
    ---  122  084  036N
    044  044  006  043N
    045  045  007  047N
    ---  ---  ---  050N
    046  046  008  051N
    ---  123  085  053N
    047  047  009  054N
    048  048  010  065N
    049  049  011  071N
    050  050  012  072N
    051  051  013  073N
    052  052  014  074N
    053  053  015  114N
    054  054  016  115N
    055  055  017  116N
    ---  124  086  122N
    056  056  018  125N
    057  057  019  131N
    058  058  020  132N
    059  059  021  134N
    ---  ---  ---  141N
    060  060  022  143N
    ---  125  087  145N
    061  061  023  152N
    062  062  024  155N
    063  063  025  156N
    064  064  026  162N
    065  065  027  165N
    066  066  028  172N
    067  067  029  174N
    068  068  030  205N
    ---  126  088  212N
    ---  ---  ---  214N
    069  069  031  223N
    ---  127  089  225N
    070  070  032  226N
    071  071  033  243N
    072  072  034  244N
    073  073  035  245N
    ---  128  090  246N
    074  074  036  251N
    ---  129  091  252N
    ---  130  092  255N
    075  075  037  261N
    076  076  038  263N
    077  077  039  265N
    ---  131  093  266N
    078  078  040  271N
    ---  132  094  274N
    079  079  041  306N
    080  080  042  311N
    081  081  043  315N
    ---  133  095  325N
    082  082  044  331N
    ---  134  096  332N
    083  083  045  343N
    084  084  046  346N
    085  085  047  351N
    ---  135  097  356N
    086  086  048  364N
    087  087  049  365N
    088  088  050  371N
    089  089  051  411N
    090  090  052  412N
    091  091  053  413N
    092  092  054  423N
    093  093  055  431N
    094  094  056  432N
    095  095  057  445N
    ---  136  098  446N
    ---  137  099  452N
    ---  138  100  454N
    ---  139  101  455N
    ---  140  102  462N
    096  096  058  464N
    097  097  059  465N
    098  098  060  466N
    099  099  061  503N
    100  100  062  506N
    101  101  063  516N
    ---  141  103  523N
    ---  142  104  526N
    102  102  064  532N
    103  103  065  546N
    104  104  066  565N
    105  105  067  606N
    106  106  068  612N
    107  107  069  624N
    108  108  070  627N
    109  109  071  631N
    110  110  072  632N
    111  111  073  654N
    112  112  074  662N
    113  113  075  664N
    114  114  076  703N
    115  115  077  712N
    116  116  078  723N
    117  117  079  731N
    118  118  080  732N
    119  119  081  734N
    120  120  082  743N
    121  121  083  754N
