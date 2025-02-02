#!/usr/bin/env bash

# Output new binary codeplugs for each radio containing the desired channels
# Required tools:  bash, chmod, date, dmrRadio, gojq, mkdir, python (3.10.x+), rm, sed

# set -x
mkdir -p tmp
date="$(date +%Y-%m-%d)"

input_files='
repeaters/Lanark_AARC.yaml
repeaters/Lanark_LNLARES.yaml
repeaters/Lanark_RLARC.yaml
repeaters/Ottawa-Gatineau_EMRG.yaml
repeaters/Ottawa-Gatineau_KARG.yaml
repeaters/Ottawa-Gatineau_OARC.yaml
repeaters/Ottawa-Gatineau_OVMRC.yaml
repeaters/Renfrew_CRRA.yaml
repeaters/Renfrew_RCARC.yaml
info/RLCT_FM_VHF.yaml
info/Simplex_DMR_VHF_UHF.yaml
info/Simplex_FM_VHF_UHF.yaml
info/GMRS_FRS_FM_UHF.yaml
info/Weather_FM_VHF.yaml
'

mobile_rdt_file="tmp/Retevis_RT90-${date}.rdt"
mobile_json_file="tmp/Retevis_RT90-${date}.json"
handheld_rdt_file="tmp/Retevis_RT3S-${date}.rdt"
handheld_json_file="tmp/Retevis_RT3S-${date}.json"

#  ____ _____ ___   ___
# |  _ \_   _/ _ \ / _ \
# | |_) || || (_) | | | |
# |  _ < | | \__, | |_| |
# |_| \_\|_|   /_/ \___/

# XXX FIXME TODO  Use 'RT90' model instead of 'MD-2017' after fixing crashy crashy!!!
# XXX FIXME TODO  Finish the porting work for the P3/P4 buttons!!!

# Generate a blank codeplug and convert it to JSON
# XXX FIXME TODO  Remove this sed hack after fixing the UUID bug!!!
dmrRadio newCodeplug -model 'MD-2017' -freq '400-480_136-174' ${mobile_rdt_file}
dmrRadio codeplugToJSON ${mobile_rdt_file} ${mobile_json_file}
sed -i 's/_.*"/"/' ${mobile_json_file}

# Fix the default settings and fill in contact stubs and zone stubs
gojq --from-file radios/Retevis_RT90.jq ${mobile_json_file} > tmp/0.json
gojq --yaml-input '.' < radios/stubs.yaml > tmp/stubs.json
gojq --slurp '.[0] * .[1]' tmp/0.json tmp/stubs.json > tmp/1.json

# Populate the codeplug channels from the input data files
index=1
for input_file in ${input_files}; do
    ./scripts/multi_outputter.py      \
        --format DMR                  \
        --input_file ${input_file}    \
        --modes_allowed DMR           \
        --json_file tmp/${index}.json \
        > tmp/$((${index} + 1)).json
    index=$((${index} + 1))
done
for input_file in ${input_files}; do
    ./scripts/multi_outputter.py      \
        --format DMR                  \
        --input_file ${input_file}    \
        --modes_allowed FM,NFM        \
        --json_file tmp/${index}.json \
        > tmp/$((${index} + 1)).json
    index=$((${index} + 1))
done

# Convert it back to a binary codeplug
dmrRadio jsonToCodeplug tmp/${index}.json ${mobile_rdt_file}

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
dmrRadio newCodeplug -model 'RT3S' -freq '400-480_136-174' ${handheld_rdt_file}
dmrRadio codeplugToJSON ${handheld_rdt_file} ${handheld_json_file}
sed -i 's/_.*"/"/' ${handheld_json_file}

# Fix the default settings and fill in contact stubs and zone stubs
gojq --from-file radios/Retevis_RT3S.jq ${handheld_json_file} > tmp/0.json
gojq --yaml-input '.' < radios/stubs.yaml > tmp/stubs.json
gojq --slurp '.[0] * .[1]' tmp/0.json tmp/stubs.json > tmp/1.json

# Populate the codeplug channels from the input data files
index=1
for input_file in ${input_files}; do
    ./scripts/multi_outputter.py      \
        --format DMR                  \
        --input_file ${input_file}    \
        --modes_allowed DMR           \
        --json_file tmp/${index}.json \
        > tmp/$((${index} + 1)).json
    index=$((${index} + 1))
done
for input_file in ${input_files}; do
    ./scripts/multi_outputter.py      \
        --format DMR                  \
        --input_file ${input_file}    \
        --modes_allowed FM,NFM        \
        --json_file tmp/${index}.json \
        > tmp/$((${index} + 1)).json
    index=$((${index} + 1))
done

# Convert it back to a binary codeplug
dmrRadio jsonToCodeplug tmp/${index}.json ${handheld_rdt_file}

# Clean up intermediate and generated files
rm -f tmp/*.json
chmod 0644 tmp/*.rdt
