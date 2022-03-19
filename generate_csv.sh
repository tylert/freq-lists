#!/usr/bin/env bash

# Required tools:  bash, cut, mkdir, python (3.10.x+), tail, wc

# set -x
mkdir -p tmp

input_files='
repeaters/RLARC_LNL_ARES_AARC_normal.yaml
repeaters/OARC_OVMRC_EMRG_normal.yaml
repeaters/CRRA_RCARC_normal.yaml
info/RLCT_normal.yaml
info/Lanark_County_VHF.yaml
info/Packet_FM_VHF_UHF.yaml
'

# Append a few files to the printout sheet that aren't in the other outputs
human_input_files=${input_files}
human_input_files+='
repeaters/DMR.yaml
'

chirp_output_file='tmp/CHIRP.csv'
rt_systems_output_file='tmp/RT.csv'
human_output_file='tmp/HUMAN_csv.csv'

#   ____ _   _ ___ ____  ____
#  / ___| | | |_ _|  _ \|  _ \
# | |   | |_| || || |_) | |_) |
# | |___|  _  || ||  _ <|  __/
#  \____|_| |_|___|_| \_\_|

index=1
for input_file in ${input_files}; do
    if [[ 1 == ${index} ]]; then
        ./multi_outputter.py --format CHIRP --input_file ${input_file} \
            --start_index 1 > ${chirp_output_file}
    else
        ./multi_outputter.py --format CHIRP --input_file ${input_file} \
            --start_index $(wc -l ${chirp_output_file} | cut -d' ' -f1) \
            | tail -n '+2' >> ${chirp_output_file}
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
for input_file in ${input_files}; do
    if [[ 1 == ${index} ]]; then
        ./multi_outputter.py --format RT --input_file ${input_file} \
            > ${rt_systems_output_file}
    else
        ./multi_outputter.py --format RT --input_file ${input_file} \
            | tail -n '+2' >> ${rt_systems_output_file}
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
for input_file in ${human_input_files}; do
    if [[ 1 == ${index} ]]; then
        ./multi_outputter.py --format HUMAN --input_file ${input_file} \
            --start_index 1 > ${human_output_file}
    else
        ./multi_outputter.py --format HUMAN --input_file ${input_file} \
            --start_index $(wc -l ${human_output_file} | cut -d' ' -f1) \
            | tail -n '+2' >> ${human_output_file}
    fi
    index=$((${index} + 1))
done
