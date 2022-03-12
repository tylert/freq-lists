#!/usr/bin/env bash

set -x
mkdir -p tmp

channel_data_files='
repeaters/DMR.yaml
repeaters/RLARC_LNL_ARES_AARC.yaml
repeaters/OARC_OVMRC_EMRG.yaml
repeaters/CRRA_RCARC.yaml
info/Simplex_DMR_VHF.yaml
info/Simplex_DMR_UHF.yaml
info/Simplex_FM_VHF.yaml
info/Simplex_FM_UHF.yaml
info/GMRS_FRS_UHF.yaml
info/RLCT.yaml
'

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
cat tmp/Retevis_RT90.json | jq --from-file codeplugs/Retevis_RT90.jq > tmp/0.json
jq --slurp '.[0] * .[1]' tmp/0.json codeplugs/stubs.json > tmp/1.json

# Populate the codeplug channels from the input data files
index=1
for input_file in ${channel_data_files}; do
    ./multi_outputter.py --format DMR --input_file ${input_file} \
        --json_file tmp/${index}.json > tmp/$((${index} + 1)).json
    index=$((${index} + 1))
done

# Convert it back to a binary codeplug
dmrRadio jsonToCodeplug tmp/${index}.json tmp/Retevis_RT90.rdt

# Clean up intermediate and generated files
rm -fv tmp/*.json
chmod 0644 tmp/*.rdt

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
cat tmp/Retevis_RT3S.json | jq --from-file codeplugs/Retevis_RT3S.jq > tmp/0.json
jq --slurp '.[0] * .[1]' tmp/0.json codeplugs/stubs.json > tmp/1.json

# Populate the codeplug channels from the input data files
index=1
for input_file in ${channel_data_files}; do
    ./multi_outputter.py --format DMR --input_file ${input_file} \
        --json_file tmp/${index}.json > tmp/$((${index} + 1)).json
    index=$((${index} + 1))
done

# Convert it back to a binary codeplug
dmrRadio jsonToCodeplug tmp/${index}.json tmp/Retevis_RT3S.rdt

# Clean up intermediate and generated files
rm -fv tmp/*.json
chmod 0644 tmp/*.rdt

#  _   _ _   _ __  __    _    _   _
# | | | | | | |  \/  |  / \  | \ | |
# | |_| | | | | |\/| | / _ \ |  \| |
# |  _  | |_| | |  | |/ ___ \| |\  |
# |_| |_|\___/|_|  |_/_/   \_\_| \_|

index=1
for input_file in ${channel_data_files}; do
    if [[ 1 == ${index} ]]; then
        ./multi_outputter.py --format HUMAN --input_file ${input_file} \
            > tmp/HUMAN_digital.csv
    else
        ./multi_outputter.py --format HUMAN --input_file ${input_file} \
            | tail -n '+2' >> tmp/HUMAN_digital.csv
    fi
    index=$((${index} + 1))
done
