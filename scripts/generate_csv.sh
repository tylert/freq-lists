#!/usr/bin/env bash

# Output CSV files suitable for CHIRP and RT Systems radio programming
# Required tools:  bash, cut, date, mkdir, python (3.10.x+), tail, wc

# set -x
mkdir -p tmp
date="$(date +%Y-%m-%d)"

input_files='
repeaters/Lanark_AARC.yaml
repeaters/Lanark_LNL_ARES.yaml
repeaters/Lanark_RLARC.yaml
repeaters/Leeds_and_Grenville_BARC.yaml
repeaters/Ottawa-Gatineau_EMRG.yaml
repeaters/Ottawa-Gatineau_KARG.yaml
repeaters/Ottawa-Gatineau_OARC.yaml
repeaters/Ottawa-Gatineau_OVMRC.yaml
repeaters/Ottawa-Gatineau_VE3ORF.yaml
repeaters/Renfrew_CRRA.yaml
repeaters/Renfrew_RCARC.yaml
info/RLCT_FM.yaml
info/Packet_FM_VHF_UHF.yaml
subtastic/Simplex_FM.yaml
subtastic/Lanark_County_VHF.yaml
'

chirp_csv_file="tmp/CHIRP-${date}.csv"
rt_systems_csv_file="tmp/RT-${date}.csv"
human_csv_file="tmp/HUMAN-${date}.csv"
human_xlsx_file="tmp/HUMAN-${date}.xlsx"

#   ____ _   _ ___ ____  ____
#  / ___| | | |_ _|  _ \|  _ \
# | |   | |_| || || |_) | |_) |
# | |___|  _  || ||  _ <|  __/
#  \____|_| |_|___|_| \_\_|

# Populate the CHIRP data file from the input data files
index=1
for input_file in ${input_files}; do
    if [[ 1 == ${index} ]]; then
        ./scripts/multi_outputter.py   \
            --format CHIRP             \
            --input_file ${input_file} \
            --modes_allowed AM,FM,NFM  \
            --name_max_length 8        \
            --start_index 1            \
            > ${chirp_csv_file}
    else
        ./scripts/multi_outputter.py   \
            --format CHIRP             \
            --input_file ${input_file} \
            --modes_allowed AM,FM,NFM  \
            --name_max_length 8        \
            --start_index $(wc -l ${chirp_csv_file} | cut -d' ' -f1) \
            | tail -n '+2' >> ${chirp_csv_file}
    fi
    index=$((${index} + 1))
done

#  ____ _____   ____            _
# |  _ \_   _| / ___| _   _ ___| |_ ___ _ __ ___  ___
# | |_) || |   \___ \| | | / __| __/ _ \ '_ ` _ \/ __|
# |  _ < | |    ___) | |_| \__ \ ||  __/ | | | | \__ \
# |_| \_\|_|   |____/ \__, |___/\__\___|_| |_| |_|___/
#                     |___/

# Populate the RT Systems data file from the input data files
index=1
for input_file in ${input_files}; do
    if [[ 1 == ${index} ]]; then
        ./scripts/multi_outputter.py   \
            --format RT                \
            --input_file ${input_file} \
            --modes_allowed AM,FM,NFM  \
            --name_max_length 8        \
            > ${rt_systems_csv_file}
    else
        ./scripts/multi_outputter.py   \
            --format RT                \
            --input_file ${input_file} \
            --modes_allowed AM,FM,NFM  \
            --name_max_length 8        \
            | tail -n '+2' >> ${rt_systems_csv_file}
    fi
    index=$((${index} + 1))
done

#  _   _ _   _ __  __    _    _   _
# | | | | | | |  \/  |  / \  | \ | |
# | |_| | | | | |\/| | / _ \ |  \| |
# |  _  | |_| | |  | |/ ___ \| |\  |
# |_| |_|\___/|_|  |_/_/   \_\_| \_|

# Populate the HUMAN data file from the input data files
index=1
for input_file in ${input_files}; do
    if [[ 1 == ${index} ]]; then
        ./scripts/multi_outputter.py   \
            --format HUMAN             \
            --input_file ${input_file} \
            --modes_allowed AM,FM,NFM  \
            --name_max_length 8        \
            --start_index 1 > ${human_csv_file}
    else
        ./scripts/multi_outputter.py   \
            --format HUMAN             \
            --input_file ${input_file} \
            --modes_allowed AM,FM,NFM  \
            --name_max_length 8        \
            --start_index $(wc -l ${human_csv_file} | cut -d' ' -f1) \
            | tail -n '+2' >> ${human_csv_file}
    fi
    index=$((${index} + 1))
done
# Tack on all the digital mode channels at the end
for input_file in ${input_files}; do
    if [[ 1 == ${index} ]]; then
        ./scripts/multi_outputter.py      \
            --format HUMAN                \
            --input_file ${input_file}    \
            --modes_allowed DMR,DSTAR,YSF \
            --name_max_length 8           \
            --start_index 1 > ${human_csv_file}
    else
        ./scripts/multi_outputter.py      \
            --format HUMAN                \
            --input_file ${input_file}    \
            --modes_allowed DMR,DSTAR,YSF \
            --name_max_length 8           \
            --start_index $(wc -l ${human_csv_file} | cut -d' ' -f1) \
            | tail -n '+2' >> ${human_csv_file}
    fi
    index=$((${index} + 1))
done

# Produce pretty PDF handout sheets as a companion to the CSV output files
./scripts/handouts.py --input_file ${human_csv_file} \
    --output_file ${human_xlsx_file}
libreoffice --headless --convert-to pdf:writer_pdf_Export \
    --outdir $(dirname ${human_xlsx_file}) ${human_xlsx_file}
