#!/usr/bin/env bash

# Output new binary codeplugs for each radio containing the desired channels
# Required tools:  bash, chmod, dmrRadio, jq, mkdir, python (3.10.x+), rm, sed

# set -x
mkdir -p tmp

input_files='
repeaters/Lanark_DMR.yaml
repeaters/Ottawa_DMR.yaml
repeaters/Renfrew_DMR.yaml
repeaters/Lanark_FM.yaml
repeaters/Ottawa_FM.yaml
repeaters/Renfrew_FM.yaml
repeaters/Lanark_inputs.yaml
repeaters/Ottawa_inputs.yaml
repeaters/Renfrew_inputs.yaml
info/RLCT_FM.yaml
info/RLCT_inputs.yaml
info/Simplex_DMR_VHF.yaml
info/Simplex_DMR_UHF.yaml
info/Simplex_FM_VHF.yaml
info/Simplex_FM_UHF.yaml
info/GMRS_FRS_FM_UHF.yaml
info/WX_FM_VHF.yaml
'

#  ____ _____ ___   ___
# |  _ \_   _/ _ \ / _ \
# | |_) || || (_) | | | |
# |  _ < | | \__, | |_| |
# |_| \_\|_|   /_/ \___/

# XXX FIXME TODO  Use 'RT90' model instead of 'MD-2017' after fixing crashy crashy!!!
# XXX FIXME TODO  Finish the porting work for the P3/P4 buttons!!!

# Generate a blank codeplug and convert it to JSON
# XXX FIXME TODO  Remove this sed hack after fixing the UUID bug!!!
dmrRadio newCodeplug -model 'MD-2017' -freq '400-480_136-174' tmp/Retevis_RT90.rdt
dmrRadio codeplugToJSON tmp/Retevis_RT90.rdt tmp/Retevis_RT90.json
sed -i 's/_.*"/"/' tmp/Retevis_RT90.json

# Fix the default settings and fill in contact stubs and zone stubs
jq --from-file radios/Retevis_RT90.jq tmp/Retevis_RT90.json > tmp/0.json
jq --slurp '.[0] * .[1]' tmp/0.json radios/stubs.json > tmp/1.json

# Populate the codeplug channels from the input data files
index=1
for input_file in ${input_files}; do
    ./multi_outputter.py --format DMR --input_file ${input_file} \
        --json_file tmp/${index}.json > tmp/$((${index} + 1)).json
    index=$((${index} + 1))
done

# Convert it back to a binary codeplug
dmrRadio jsonToCodeplug tmp/${index}.json tmp/Retevis_RT90.rdt

# Clean up intermediate and generated files
rm -f tmp/*.json
chmod 0644 tmp/*.rdt

#  ____ _____ _________
# |  _ \_   _|___ / ___|
# | |_) || |   |_ \___ \
# |  _ < | |  ___) |__) |
# |_| \_\|_| |____/____/

# Generate a blank codeplug and convert it to JSON
# XXX FIXME TODO  Remove this sed hack after fixing the UUID bug!!!
dmrRadio newCodeplug -model 'RT3S' -freq '400-480_136-174' tmp/Retevis_RT3S.rdt
dmrRadio codeplugToJSON tmp/Retevis_RT3S.rdt tmp/Retevis_RT3S.json
sed -i 's/_.*"/"/' tmp/Retevis_RT3S.json

# Fix the default settings and fill in contact stubs and zone stubs
jq --from-file radios/Retevis_RT3S.jq tmp/Retevis_RT3S.json > tmp/0.json
jq --slurp '.[0] * .[1]' tmp/0.json radios/stubs.json > tmp/1.json

# Populate the codeplug channels from the input data files
index=1
for input_file in ${input_files}; do
    ./multi_outputter.py --format DMR --input_file ${input_file} \
        --json_file tmp/${index}.json > tmp/$((${index} + 1)).json
    index=$((${index} + 1))
done

# Convert it back to a binary codeplug
dmrRadio jsonToCodeplug tmp/${index}.json tmp/Retevis_RT3S.rdt

# Clean up intermediate and generated files
rm -f tmp/*.json
chmod 0644 tmp/*.rdt