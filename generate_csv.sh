#!/usr/bin/env bash

# Output CSV files suitable for CHIRP and RT Systems radio programming
# Required tools:  bash, cut, mkdir, python (3.10.x+), tail, wc

# set -x
mkdir -p tmp

input_files='
repeaters/Lanark_AARC.yaml
repeaters/Lanark_LNL_ARES.yaml
repeaters/Lanark_RLARC.yaml
repeaters/Ottawa_EMRG.yaml
repeaters/Ottawa_OARC.yaml
repeaters/Ottawa_OARDG.yaml
repeaters/Ottawa_OVMRC.yaml
repeaters/Renfrew_CRRA.yaml
repeaters/Renfrew_RCARC.yaml
info/RLCT_FM.yaml
info/Packet_FM_VHF_UHF.yaml
subtastic/Simplex_FM.yaml
subtastic/Lanark_County_VHF.yaml
'

chirp_output_file='tmp/CHIRP.csv'
rt_systems_output_file='tmp/RT.csv'
human_output_file='tmp/HUMAN.csv'

#   ____ _   _ ___ ____  ____
#  / ___| | | |_ _|  _ \|  _ \
# | |   | |_| || || |_) | |_) |
# | |___|  _  || ||  _ <|  __/
#  \____|_| |_|___|_| \_\_|

index=1
for input_file in ${input_files}; do
    if [[ 1 == ${index} ]]; then
        ./multi_outputter.py --format CHIRP --input_file ${input_file} \
            --max_name_length 8 --only_modes AM,FM,NFM \
            --start_index 1 > ${chirp_output_file}
    else
        ./multi_outputter.py --format CHIRP --input_file ${input_file} \
            --max_name_length 8 --only_modes AM,FM,NFM \
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
            --max_name_length 8 --only_modes AM,FM,NFM \
            > ${rt_systems_output_file}
    else
        ./multi_outputter.py --format RT --input_file ${input_file} \
            --max_name_length 8 --only_modes AM,FM,NFM \
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
for input_file in ${input_files}; do
    if [[ 1 == ${index} ]]; then
        ./multi_outputter.py --format HUMAN --input_file ${input_file} \
            --max_name_length 8 --only_modes AM,FM,NFM \
            --start_index 1 > ${human_output_file}
    else
        ./multi_outputter.py --format HUMAN --input_file ${input_file} \
            --max_name_length 8 --only_modes AM,FM,NFM \
            --start_index $(wc -l ${human_output_file} | cut -d' ' -f1) \
            | tail -n '+2' >> ${human_output_file}
    fi
    index=$((${index} + 1))
done
for input_file in ${input_files}; do
    if [[ 1 == ${index} ]]; then
        ./multi_outputter.py --format HUMAN --input_file ${input_file} \
            --max_name_length 8 --only_modes DSTAR,DMR,YSF \
            --start_index 1 > ${human_output_file}
    else
        ./multi_outputter.py --format HUMAN --input_file ${input_file} \
            --max_name_length 8 --only_modes DSTAR,DMR,YSF \
            --start_index $(wc -l ${human_output_file} | cut -d' ' -f1) \
            | tail -n '+2' >> ${human_output_file}
    fi
    index=$((${index} + 1))
done
