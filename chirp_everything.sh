#!/usr/bin/env bash

set -x
mkdir -p tmp
rm -f tmp/chirp.csv
rm -f tmp/print.csv
touch tmp/chirp.csv
touch tmp/print.csv

# Produce a fresh CSV file suitable for sending to CHIRP
./multi_outputter.py --format CHIRP --input_file repeaters/RLARC_LNL_ARES_AARC.yaml >> tmp/chirp.csv
./multi_outputter.py --format CHIRP --input_file repeaters/CRRA_RCARC.yaml >> tmp/chirp.csv
./multi_outputter.py --format CHIRP --input_file repeaters/OARC_OVMRC_EMRG.yaml >> tmp/chirp.csv
./multi_outputter.py --format CHIRP --input_file info/Simplex_FM_VHF.yaml >> tmp/chirp.csv
./multi_outputter.py --format CHIRP --input_file info/Simplex_FM_UHF.yaml >> tmp/chirp.csv
./multi_outputter.py --format CHIRP --input_file info/GMRS_and_FRS_UHF.yaml >> tmp/chirp.csv
./multi_outputter.py --format CHIRP --input_file info/Weather_info_VHF.yaml >> tmp/chirp.csv

# Produce a fresh nearly ready-to-print channel memory listing containing the same data
./multi_outputter.py --format human --input_file repeaters/RLARC_LNL_ARES_AARC.yaml >> tmp/print.csv
./multi_outputter.py --format human --input_file repeaters/CRRA_RCARC.yaml >> tmp/print.csv
./multi_outputter.py --format human --input_file repeaters/OARC_OVMRC_EMRG.yaml >> tmp/print.csv
./multi_outputter.py --format human --input_file info/Simplex_FM_VHF.yaml >> tmp/print.csv
./multi_outputter.py --format human --input_file info/Simplex_FM_UHF.yaml >> tmp/print.csv
./multi_outputter.py --format human --input_file info/GMRS_and_FRS_UHF.yaml >> tmp/print.csv
./multi_outputter.py --format human --input_file info/Weather_info_VHF.yaml >> tmp/print.csv
