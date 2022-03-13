#!/usr/bin/env bash

# set -x
mkdir -p tmp

channel_data_files='
repeaters/RLARC_LNL_ARES_AARC.yaml
repeaters/OARC_OVMRC_EMRG.yaml
repeaters/CRRA_RCARC.yaml
info/Simplex_FM_VHF.yaml
info/Simplex_FM_UHF.yaml
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
            --start_index 1 > tmp/CHIRP.csv
    else
        ./multi_outputter.py --format CHIRP --input_file ${input_file} \
            --start_index $(wc -l tmp/CHIRP.csv | cut -d' ' -f1) \
            | tail -n '+2' >> tmp/CHIRP.csv
    fi
    index=$((${index} + 1))
done

#  ____ _____   ____            _
# |  _ \_   _| / ___| _   _ ___| |_ ___ _ __ ___  ___
# | |_) || |   \___ \| | | / __| __/ _ \ '_ ` _ \/ __|
# |  _ < | |    ___) | |_| \__ \ ||  __/ | | | | \__ \
# |_| \_\|_|   |____/ \__, |___/\__\___|_| |_| |_|___/
#                     |___/

index=1
for input_file in ${channel_data_files}; do
    if [[ 1 == ${index} ]]; then
        ./multi_outputter.py --format RT --input_file ${input_file} \
            > tmp/RT.csv
    else
        ./multi_outputter.py --format RT --input_file ${input_file} \
            | tail -n '+2' >> tmp/RT.csv
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

index=1
for input_file in ${channel_data_files}; do
    if [[ 1 == ${index} ]]; then
        ./multi_outputter.py --format HUMAN --input_file ${input_file} \
            --start_index 1 > tmp/HUMAN_csv_files.csv
    else
        ./multi_outputter.py --format HUMAN --input_file ${input_file} \
            --start_index $(wc -l tmp/HUMAN_csv_files.csv | cut -d' ' -f1) \
            | tail -n '+2' >> tmp/HUMAN_csv_files.csv
    fi
    index=$((${index} + 1))
done
