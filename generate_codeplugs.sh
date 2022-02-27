#!/usr/bin/env bash

set -x
mkdir -p tmp

#  ____ _____ ___   ___
# |  _ \_   _/ _ \ / _ \
# | |_) || || (_) | | | |
# |  _ < | | \__, | |_| |
# |_| \_\|_|   /_/ \___/

# XXX FIXME TODO  Use 'RT90' model instead of 'MD-2017' after fixing crashy crashy!!!
# XXX FIXME TODO  Finish the porting work for the P3/P4 buttons!!!

# Generate a blank codeplug and convert it to JSON
dmrRadio newCodeplug -model 'MD-2017' -freq '400-480_136-174' tmp/Retevis_RT90.rdt
dmrRadio codeplugToJSON tmp/Retevis_RT90.rdt tmp/Retevis_RT90.json
sed -i 's/_.*"/"/' tmp/Retevis_RT90.json
# XXX FIXME TODO  Remove this ^^^ hack after fixing the UUID bug!!!

# Fix the default settings and fill in contact stubs and zone stubs
cat tmp/Retevis_RT90.json | jq --from-file codeplugs/Retevis_RT90.jq > tmp/00.json
jq --slurp '.[0] * .[1]' tmp/00.json codeplugs/stubs.json > tmp/01.json

# Populate the channel data
./multi_outputter.py --format DMR --input_file repeaters/DMR.yaml \
    --json_file tmp/01.json > tmp/02.json
./multi_outputter.py --format DMR --input_file repeaters/RLARC_LNL_ARES_AARC.yaml \
    --json_file tmp/02.json > tmp/03.json
./multi_outputter.py --format DMR --input_file repeaters/OARC_OVMRC_EMRG.yaml \
    --json_file tmp/03.json > tmp/04.json
./multi_outputter.py --format DMR --input_file repeaters/CRRA_RCARC.yaml \
    --json_file tmp/04.json > tmp/05.json
./multi_outputter.py --format DMR --input_file info/Simplex_DMR_VHF.yaml \
    --json_file tmp/05.json > tmp/06.json
./multi_outputter.py --format DMR --input_file info/Simplex_DMR_UHF.yaml \
    --json_file tmp/06.json > tmp/07.json
./multi_outputter.py --format DMR --input_file info/Simplex_FM_VHF.yaml \
    --json_file tmp/07.json > tmp/08.json
./multi_outputter.py --format DMR --input_file info/Simplex_FM_UHF.yaml \
    --json_file tmp/08.json > tmp/09.json
./multi_outputter.py --format DMR --input_file info/GMRS_and_FRS_UHF.yaml \
    --json_file tmp/09.json > tmp/10.json
./multi_outputter.py --format DMR --input_file info/Weather_info_VHF.yaml \
    --json_file tmp/10.json > tmp/11.json
./multi_outputter.py --format DMR --input_file info/RLCT.yaml \
    --json_file tmp/11.json > tmp/12.json

# Convert it back to a binary codeplug
dmrRadio jsonToCodeplug tmp/12.json tmp/Retevis_RT90.rdt

#  ____ _____ _________
# |  _ \_   _|___ / ___|
# | |_) || |   |_ \___ \
# |  _ < | |  ___) |__) |
# |_| \_\|_| |____/____/

# Generate a blank codeplug and convert it to JSON
dmrRadio newCodeplug -model 'RT3S' -freq '400-480_136-174' tmp/Retevis_RT3S.rdt
dmrRadio codeplugToJSON tmp/Retevis_RT3S.rdt tmp/Retevis_RT3S.json
sed -i 's/_.*"/"/' tmp/Retevis_RT3S.json
# XXX FIXME TODO  Remove this ^^^ hack after fixing the UUID bug!!!

# Fix the default settings and fill in contact stubs and zone stubs
cat tmp/Retevis_RT3S.json | jq --from-file codeplugs/Retevis_RT3S.jq > tmp/00.json
jq --slurp '.[0] * .[1]' tmp/00.json codeplugs/stubs.json > tmp/01.json

# Populate the channel data
./multi_outputter.py --format DMR --input_file repeaters/DMR.yaml \
    --json_file tmp/01.json > tmp/02.json
./multi_outputter.py --format DMR --input_file repeaters/RLARC_LNL_ARES_AARC.yaml \
    --json_file tmp/02.json > tmp/03.json
./multi_outputter.py --format DMR --input_file repeaters/OARC_OVMRC_EMRG.yaml \
    --json_file tmp/03.json > tmp/04.json
./multi_outputter.py --format DMR --input_file repeaters/CRRA_RCARC.yaml \
    --json_file tmp/04.json > tmp/05.json
./multi_outputter.py --format DMR --input_file info/Simplex_DMR_VHF.yaml \
    --json_file tmp/05.json > tmp/06.json
./multi_outputter.py --format DMR --input_file info/Simplex_DMR_UHF.yaml \
    --json_file tmp/06.json > tmp/07.json
./multi_outputter.py --format DMR --input_file info/Simplex_FM_VHF.yaml \
    --json_file tmp/07.json > tmp/08.json
./multi_outputter.py --format DMR --input_file info/Simplex_FM_UHF.yaml \
    --json_file tmp/08.json > tmp/09.json
./multi_outputter.py --format DMR --input_file info/GMRS_and_FRS_UHF.yaml \
    --json_file tmp/09.json > tmp/10.json
./multi_outputter.py --format DMR --input_file info/Weather_info_VHF.yaml \
    --json_file tmp/10.json > tmp/11.json
./multi_outputter.py --format DMR --input_file info/RLCT.yaml \
    --json_file tmp/11.json > tmp/12.json

# Convert it back to a binary codeplug
dmrRadio jsonToCodeplug tmp/12.json tmp/Retevis_RT3S.rdt

# Clean up intermediate and generated files
rm tmp/*.json
chmod 0644 tmp/*.rdt
