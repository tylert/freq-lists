#!/usr/bin/env bash

set -x
mkdir -p tmp

channel_data_files='
repeaters/RLARC_LNL_ARES_AARC.yaml
repeaters/OARC_OVMRC_EMRG.yaml
repeaters/CRRA_RCARC.yaml
info/Simplex_FM_VHF.yaml
info/Simplex_FM_UHF.yaml
info/GMRS_FRS_UHF.yaml
info/RLCT.yaml
'

#   ____ _   _ ___ ____  ____
#  / ___| | | |_ _|  _ \|  _ \
# | |   | |_| || || |_) | |_) |
# | |___|  _  || ||  _ <|  __/
#  \____|_| |_|___|_| \_\_|

index=1
for input_file in ${channel_data_files}; do
    if [[ 1 == ${index} ]]; then
        ./multi_outputter.py --format CHIRP --input_file ${input_file} \
            > tmp/CHIRP.csv
    else
        ./multi_outputter.py --format CHIRP --input_file ${input_file} \
            | tail -n '+2' >> tmp/CHIRP.csv
    fi
    index=$((${index} + 1))
done

#  _   _ _   _ __  __    _    _   _
# | | | | | | |  \/  |  / \  | \ | |
# | |_| | | | | |\/| | / _ \ |  \| |
# |  _  | |_| | |  | |/ ___ \| |\  |
# |_| |_|\___/|_|  |_/_/   \_\_| \_|

# XXX FIXME TODO  https://realpython.com/openpyxl-excel-spreadsheets-python/
# XXX FIXME TODO  https://openpyxl.readthedocs.io/en/stable/styles.html#edit-page-setup

# XXX FIXME TODO  Fix the left-most column so the count is sequential starting
#                 from 1 to n!!!

index=1
for input_file in ${channel_data_files}; do
    if [[ 1 == ${index} ]]; then
        ./multi_outputter.py --format HUMAN --input_file ${input_file} \
            > tmp/HUMAN_analog.csv
    else
        ./multi_outputter.py --format HUMAN --input_file ${input_file} \
            | tail -n '+2' >> tmp/HUMAN_analog.csv
    fi
    index=$((${index} + 1))
done
