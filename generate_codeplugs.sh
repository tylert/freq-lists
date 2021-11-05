#!/usr/bin/env bash

set -e
mkdir -p tmp

#  ____ _____ _________
# |  _ \_   _|___ / ___|
# | |_) || |   |_ \___ \
# |  _ < | |  ___) |__) |
# |_| \_\|_| |____/____/

# Generate a blank codeplug and convert it to JSON
dmrRadio newCodeplug -model 'RT3S' -freq '400-480_136-174' tmp/RT3S.rdt
dmrRadio codeplugToJSON tmp/RT3S.rdt tmp/RT3S.json
sed -i 's/_.*"/"/' tmp/RT3S.json  # XXX FIXME TODO  Remove this hack after fixing the UUID bug!!!

# Fix the default settings and fill in channel data, contact stubs and zone stubs
cat tmp/RT3S.json | jq --from-file codeplugs/Retevis_RT3S.jq > tmp/00.json
jq --slurp '.[0] * .[1]' tmp/00.json codeplugs/stubs.json > tmp/01.json
./multi_outputter.py --input_file repeaters/DMR.yaml --json_file tmp/01.json > tmp/02.json
./multi_outputter.py --input_file repeaters/RLARC_LNL_ARES_AARC.yaml --json_file tmp/02.json > tmp/03.json
./multi_outputter.py --input_file repeaters/CRRA_RCARC.yaml --json_file tmp/03.json > tmp/04.json
./multi_outputter.py --input_file repeaters/OARC_EMRG.yaml --json_file tmp/04.json > tmp/05.json
./multi_outputter.py --input_file info/Simplex_VHF.yaml --json_file tmp/05.json > tmp/06.json
./multi_outputter.py --input_file info/Simplex_UHF.yaml --json_file tmp/06.json > tmp/07.json
./multi_outputter.py --input_file info/GMRS_and_FRS_UHF.yaml --json_file tmp/07.json > tmp/08.json
./multi_outputter.py --input_file info/Weather_info_VHF.yaml --json_file tmp/08.json > tmp/09.json

# Convert it back to a codeplug and update the JSON export
dmrRadio jsonToCodeplug tmp/09.json tmp/RT3S.rdt
dmrRadio codeplugToJSON tmp/RT3S.rdt tmp/RT3S.json
sed -i 's/_.*"/"/' tmp/RT3S.json  # XXX FIXME TODO  Remove this hack after fixing the UUID bug!!!

#  ____ _____ ___   ___
# |  _ \_   _/ _ \ / _ \
# | |_) || || (_) | | | |
# |  _ < | | \__, | |_| |
# |_| \_\|_|   /_/ \___/

# XXX FIXME TODO  Finish the porting work for the P3/P4 buttons!!!

# Generate a blank codeplug and convert it to JSON
dmrRadio newCodeplug -model 'MD-2017' -freq '400-480_136-174' tmp/RT90.rdt  # XXX FIXME TODO  Use 'RT90' model after fixing more bugs!!!
dmrRadio codeplugToJSON tmp/RT90.rdt tmp/RT90.json
sed -i 's/_.*"/"/' tmp/RT90.json  # XXX FIXME TODO  Remove this hack after fixing the UUID bug!!!

# Fix the default settings and fill in channel data, contact stubs and zone stubs
cat tmp/RT90.json | jq --from-file codeplugs/Retevis_RT90.jq > tmp/10.json
jq --slurp '.[0] * .[1]' tmp/10.json codeplugs/stubs.json > tmp/11.json
./multi_outputter.py --input_file repeaters/DMR.yaml --json_file tmp/11.json > tmp/12.json
./multi_outputter.py --input_file repeaters/RLARC_LNL_ARES_AARC.yaml --json_file tmp/12.json > tmp/13.json
./multi_outputter.py --input_file repeaters/CRRA_RCARC.yaml --json_file tmp/13.json > tmp/14.json
./multi_outputter.py --input_file repeaters/OARC_EMRG.yaml --json_file tmp/14.json > tmp/15.json
./multi_outputter.py --input_file info/Simplex_VHF.yaml --json_file tmp/15.json > tmp/16.json
./multi_outputter.py --input_file info/Simplex_UHF.yaml --json_file tmp/16.json > tmp/17.json
./multi_outputter.py --input_file info/GMRS_and_FRS_UHF.yaml --json_file tmp/17.json > tmp/18.json
./multi_outputter.py --input_file info/Weather_info_VHF.yaml --json_file tmp/18.json > tmp/19.json

# Convert it back to a codeplug and update the JSON export
dmrRadio jsonToCodeplug tmp/19.json tmp/RT90.rdt
dmrRadio codeplugToJSON tmp/RT90.rdt tmp/RT90.json
sed -i 's/_.*"/"/' tmp/RT90.json  # XXX FIXME TODO  Remove this hack after fixing the UUID bug!!!
