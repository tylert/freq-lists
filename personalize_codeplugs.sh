#!/usr/bin/env bash

# set -x

# Convert binary codeplugs back into JSON for intermediate processing
# XXX FIXME TODO  Remove these sed hacks after fixing the UUID bug!!!
dmrRadio codeplugToJSON tmp/Retevis_RT90.rdt tmp/Retevis_RT90.json
dmrRadio codeplugToJSON tmp/Retevis_RT3S.rdt tmp/Retevis_RT3S.json
sed -i 's/_.*"/"/' tmp/Retevis_RT90.json
sed -i 's/_.*"/"/' tmp/Retevis_RT3S.json

# __     ___    _____ ____   ____ _   _
# \ \   / / \  |___ /|  _ \ / ___| \ | |
#  \ \ / / _ \   |_ \| | | | |  _|  \| |
#   \ V / ___ \ ___) | |_| | |_| | |\  |
#    \_/_/   \_\____/|____/ \____|_| \_|

# Personalize mobiles:  Primary, secondary (-9, -8)
jq --slurp '.[0] * .[1]' tmp/Retevis_RT90.json codeplugs/VA3DGN-A.conf \
    | jq '.GeneralSettings.IntroScreenLine1 |= "VA3DGN-9"' \
    | jq '.GeneralSettings.RadioName |= "VA3DGN-9"' > tmp/VA3DGN-9.json
jq --slurp '.[0] * .[1]' tmp/Retevis_RT90.json codeplugs/VA3DGN-B.conf \
    | jq '.GeneralSettings.IntroScreenLine1 |= "VA3DGN-8"' \
    | jq '.GeneralSettings.RadioName |= "VA3DGN-8"' > tmp/VA3DGN-8.json

# Personalize handhelds:  Primary, secondary, tertiary (-7, -6, -5)
jq --slurp '.[0] * .[1]' tmp/Retevis_RT3S.json codeplugs/VA3DGN-A.conf \
    | jq '.GeneralSettings.IntroScreenLine1 |= "VA3DGN-7"' \
    | jq '.GeneralSettings.RadioName |= "VA3DGN-7"' > tmp/VA3DGN-7.json
jq --slurp '.[0] * .[1]' tmp/Retevis_RT3S.json codeplugs/VA3DGN-B.conf \
    | jq '.GeneralSettings.IntroScreenLine1 |= "VA3DGN-6"' \
    | jq '.GeneralSettings.RadioName |= "VA3DGN-6"' > tmp/VA3DGN-6.json
jq --slurp '.[0] * .[1]' tmp/Retevis_RT3S.json codeplugs/VA3DGN-A.conf \
    | jq '.GeneralSettings.IntroScreenLine1 |= "VA3DGN-5"' \
    | jq '.GeneralSettings.RadioName |= "VA3DGN-5"' > tmp/VA3DGN-5.json

# Generate a binary codeplug for each radio
dmrRadio jsonToCodeplug tmp/VA3DGN-9.json tmp/VA3DGN-9.rdt
dmrRadio jsonToCodeplug tmp/VA3DGN-8.json tmp/VA3DGN-8.rdt
dmrRadio jsonToCodeplug tmp/VA3DGN-7.json tmp/VA3DGN-7.rdt
dmrRadio jsonToCodeplug tmp/VA3DGN-6.json tmp/VA3DGN-6.rdt
dmrRadio jsonToCodeplug tmp/VA3DGN-5.json tmp/VA3DGN-5.rdt

# __     ___    _______     ____  ___   _
# \ \   / / \  |___ /\ \   / /\ \/ / \ | |
#  \ \ / / _ \   |_ \ \ \ / /  \  /|  \| |
#   \ V / ___ \ ___) | \ V /   /  \| |\  |
#    \_/_/   \_\____/   \_/   /_/\_\_| \_|

# Personalize mobiles:  Primary, secondary (-9, -8)
jq --slurp '.[0] * .[1]' tmp/Retevis_RT90.json codeplugs/VA3VXN-A.conf \
    | jq '.GeneralSettings.IntroScreenLine1 |= "VA3VXN-9"' \
    | jq '.GeneralSettings.RadioName |= "VA3VXN-9"' > tmp/VA3VXN-9.json
jq --slurp '.[0] * .[1]' tmp/Retevis_RT90.json codeplugs/VA3VXN-B.conf \
    | jq '.GeneralSettings.IntroScreenLine1 |= "VA3VXN-8"' \
    | jq '.GeneralSettings.RadioName |= "VA3VXN-8"' > tmp/VA3VXN-8.json

# Personalize handhelds:  Primary, secondary, tertiary (-7, -6, -5)
jq --slurp '.[0] * .[1]' tmp/Retevis_RT3S.json codeplugs/VA3VXN-A.conf \
    | jq '.GeneralSettings.IntroScreenLine1 |= "VA3VXN-7"' \
    | jq '.GeneralSettings.RadioName |= "VA3VXN-7"' > tmp/VA3VXN-7.json
jq --slurp '.[0] * .[1]' tmp/Retevis_RT3S.json codeplugs/VA3VXN-B.conf \
    | jq '.GeneralSettings.IntroScreenLine1 |= "VA3VXN-6"' \
    | jq '.GeneralSettings.RadioName |= "VA3VXN-6"' > tmp/VA3VXN-6.json
jq --slurp '.[0] * .[1]' tmp/Retevis_RT3S.json codeplugs/VA3VXN-A.conf \
    | jq '.GeneralSettings.IntroScreenLine1 |= "VA3VXN-5"' \
    | jq '.GeneralSettings.RadioName |= "VA3VXN-5"' > tmp/VA3VXN-5.json

# Generate a binary codeplug for each radio
dmrRadio jsonToCodeplug tmp/VA3VXN-9.json tmp/VA3VXN-9.rdt
dmrRadio jsonToCodeplug tmp/VA3VXN-8.json tmp/VA3VXN-8.rdt
dmrRadio jsonToCodeplug tmp/VA3VXN-7.json tmp/VA3VXN-7.rdt
dmrRadio jsonToCodeplug tmp/VA3VXN-6.json tmp/VA3VXN-6.rdt
dmrRadio jsonToCodeplug tmp/VA3VXN-5.json tmp/VA3VXN-5.rdt

# Clean up intermediate and generated files
rm -f tmp/*.json
chmod 0644 tmp/*.rdt
