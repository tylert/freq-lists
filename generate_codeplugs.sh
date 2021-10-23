#!/usr/bin/env bash

set -e
mkdir -p tmp

dmrRadio newCodeplug -model 'RT3S' -freq '400-480_136-174' tmp/RT3S.rdt
dmrRadio codeplugToJSON tmp/RT3S.rdt tmp/RT3S.json
cat tmp/RT3S.json | jq --from-file codeplugs/Retevis_RT3S.jq > tmp/10.json
./multi_outputter.py --input_file repeaters/DMR.yaml --json_file tmp/10.json > tmp/11.json
./multi_outputter.py --input_file repeaters/RLARC_LNL_ARES_AARC.yaml --json_file tmp/11.json > tmp/10.json
./multi_outputter.py --input_file repeaters/CRRA_RCARC.yaml --json_file tmp/10.json > tmp/11.json
./multi_outputter.py --input_file repeaters/OARC_EMRG.yaml --json_file tmp/11.json > tmp/10.json
./multi_outputter.py --input_file info/Simplex_VHF.yaml --json_file tmp/10.json > tmp/11.json
./multi_outputter.py --input_file info/Simplex_UHF.yaml --json_file tmp/11.json > tmp/10.json
./multi_outputter.py --input_file info/GMRS_and_FRS_UHF.yaml --json_file tmp/10.json > tmp/11.json
./multi_outputter.py --input_file info/Weather_info_VHF.yaml --json_file tmp/11.json > tmp/10.json
dmrRadio jsonToCodeplug tmp/10.json tmp/RT3S.rdt
# XXX FIXME TODO  Remove regex hack after contacts UUID bug gets fixed!!!
dmrRadio codeplugToJSON tmp/RT3S.rdt tmp/RT3S.json
sed -i 's/Contact1.*"/Contact1"/' tmp/RT3S.json
rm tmp/10.json tmp/11.json

# XXX FIXME TODO  Change this model to 'RT90' after more bugs get fixed!!!
dmrRadio newCodeplug -model 'MD-2017' -freq '400-480_136-174' tmp/RT90.rdt
dmrRadio codeplugToJSON tmp/RT90.rdt tmp/RT90.json
cat tmp/RT90.json | jq --from-file codeplugs/Retevis_RT90.jq > tmp/00.json
./multi_outputter.py --input_file repeaters/DMR.yaml --json_file tmp/00.json > tmp/01.json
./multi_outputter.py --input_file repeaters/RLARC_LNL_ARES_AARC.yaml --json_file tmp/01.json > tmp/00.json
./multi_outputter.py --input_file repeaters/CRRA_RCARC.yaml --json_file tmp/00.json > tmp/01.json
./multi_outputter.py --input_file repeaters/OARC_EMRG.yaml --json_file tmp/01.json > tmp/00.json
./multi_outputter.py --input_file info/Simplex_VHF.yaml --json_file tmp/00.json > tmp/01.json
./multi_outputter.py --input_file info/Simplex_UHF.yaml --json_file tmp/01.json > tmp/00.json
./multi_outputter.py --input_file info/GMRS_and_FRS_UHF.yaml --json_file tmp/00.json > tmp/01.json
./multi_outputter.py --input_file info/Weather_info_VHF.yaml --json_file tmp/01.json > tmp/00.json
dmrRadio jsonToCodeplug tmp/00.json tmp/RT90.rdt
# XXX FIXME TODO  Remove regex hack after contacts UUID bug gets fixed!!!
dmrRadio codeplugToJSON tmp/RT90.rdt tmp/RT90.json
sed -i 's/Contact1.*"/Contact1"/' tmp/RT90.json
rm tmp/00.json tmp/01.json
