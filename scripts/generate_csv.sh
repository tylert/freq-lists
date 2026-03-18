#!/usr/bin/env bash

# Output CSV files suitable for CHIRP and RT Systems radio programming

# Tools required:  bash, GNU coreutils (cut, date, dirname, mkdir, tail, wc), python 3.10+, typst, zip

# set -x
mkdir -p tmp
date="$(date +%Y-%m-%d)"

input_files='
repeaters/Lanark_AARC.yaml
repeaters/Lanark_LNLARES_RLARC.yaml
repeaters/Ottawa-Gatineau_OARC.yaml
repeaters/Renfrew_CRRA.yaml
repeaters/Renfrew_RCARC.yaml
info/Simplex_FM_VHF_UHF.yaml
info/Packet_FM_VHF_UHF.yaml
info/GMRS_FRS_FM_UHF.yaml
'

chirp_csv_file="tmp/CHIRP-${date}.csv"
rt_systems_csv_file="tmp/RTSYS-${date}.csv"
human_csv_file="tmp/HUMAN-${date}.csv"
human_typ_file="tmp/HUMAN-${date}.typ"
human_pdf_file="tmp/HUMAN-${date}.pdf"
map_csv_file="tmp/MAP-${date}.csv"
archive_file="tmp/DATA-${date}.zip"

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
            > "${chirp_csv_file}"
    else
        ./scripts/multi_outputter.py   \
            --format CHIRP             \
            --input_file ${input_file} \
            --modes_allowed AM,FM,NFM  \
            --start_index $(wc -l "${chirp_csv_file}" | cut -d' ' -f1) \
            | tail -n '+2' >> "${chirp_csv_file}"
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
            --format RTSYS             \
            --input_file ${input_file} \
            --modes_allowed AM,FM,NFM  \
            > "${rt_systems_csv_file}"
    else
        ./scripts/multi_outputter.py   \
            --format RTSYS             \
            --input_file ${input_file} \
            --modes_allowed AM,FM,NFM  \
            | tail -n '+2' >> "${rt_systems_csv_file}"
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
            > "${human_csv_file}"
    else
        ./scripts/multi_outputter.py   \
            --format HUMAN             \
            --input_file ${input_file} \
            --modes_allowed AM,FM,NFM  \
            --start_index $(wc -l "${human_csv_file}" | cut -d' ' -f1) \
            | tail -n '+2' >> "${human_csv_file}"
    fi
    index=$((${index} + 1))
done

#  __  __    _    ____
# |  \/  |  / \  |  _ \
# | |\/| | / _ \ | |_) |
# | |  | |/ ___ \|  __/
# |_|  |_/_/   \_\_|

# Spit out some map data
index=1
for input_file in ${input_files}; do
    if [[ 1 == ${index} ]]; then
        ./scripts/multi_outputter.py   \
            --format MAP               \
            --input_file ${input_file} \
            --modes_allowed AM,FM,NFM  \
            > "${map_csv_file}"
    else
        ./scripts/multi_outputter.py   \
            --format MAP               \
            --input_file ${input_file} \
            --modes_allowed AM,FM,NFM  \
            --start_index $(wc -l "${map_csv_file}" | cut -d' ' -f1) \
            | tail -n '+2' >> "${map_csv_file}"
    fi
    index=$((${index} + 1))
done

# Produce pretty PDF handout sheets as a companion to the CSV output files
cat << EOF > "${human_typ_file}"
#set page(
  "us-letter",  // ca-letter
  margin: (
    top: 1.25cm,
    bottom: 1.25cm,
    left: 1.25cm,
    right: 1.25cm,
  ),
)

#show table.cell.where(y: 0): strong
#set table(
  fill: (_, y) => if calc.odd(y) { rgb("EAF2F5") },
  stroke: (x, y) => if y == 0 {
    (bottom: 0.7pt + black)
  },
)

#set text(10pt)
#let results = csv("${human_csv_file/tmp\//}")
#table(
  columns: 7,
  ..results.flatten(),
)
EOF
typst compile "${human_typ_file}" - > "${human_pdf_file}"

# Staple all the files together so they won't get misplaced
zip --junk-paths "${archive_file}" \
    "${chirp_csv_file}"            \
    "${rt_systems_csv_file}"       \
    "${human_csv_file}"            \
    "${human_typ_file}"            \
    "${human_pdf_file}"            \
    "${map_csv_file}"
