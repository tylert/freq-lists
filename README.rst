freq-lists
==========

This information is intended purely for educational purposes.  It is your
responsibility to ensure that you and your equipment are behaving themselves
properly.

WVNET_

.. _WVNET: https://wiki.brandmeister.network/index.php/TalkGroup/98638


Events
------


Tall Pines Rally / Rally of the Tall Pines
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Happens on the 3rd or 4th weekend in November.

* Volunteer info: TBD
* Official site: `Tall Pines`_

.. _Tall Pines: http://tallpinesrally.com


Running Things
--------------

::

    # Initial setup
    make && source .venv/bin/activate

    # Create new stock codeplugs for mobile and handheld radios
    ./generate_codeplugs.sh

    # Do some manual stuff in your desired CPS tool(s)
    # ...

    # Stamp a unique CCSS7 DMR ID onto each specific radio
    ./personalize_codeplugs.sh

    # Generate related channel information for our analog-only brethren
    ./chirp_everything.sh
