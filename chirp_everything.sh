#!/usr/bin/env bash

set -x
mkdir -p tmp

rm -f tmp/CHIRP.csv
rm -f tmp/Printout.csv
touch tmp/CHIRP.csv
touch tmp/Printout.csv

# Produce a fresh CSV file suitable for sending to CHIRP
./multi_outputter.py --format CHIRP --input_file repeaters/RLARC_LNL_ARES_AARC.yaml \
    >> tmp/CHIRP.csv
./multi_outputter.py --format CHIRP --input_file repeaters/CRRA_RCARC.yaml \
    | tail --lines='+2' >> tmp/CHIRP.csv
./multi_outputter.py --format CHIRP --input_file repeaters/OARC_OVMRC_EMRG.yaml \
    | tail --lines='+2' >> tmp/CHIRP.csv
./multi_outputter.py --format CHIRP --input_file info/Simplex_FM_VHF.yaml \
    | tail --lines='+2' >> tmp/CHIRP.csv
./multi_outputter.py --format CHIRP --input_file info/Simplex_FM_UHF.yaml \
    | tail --lines='+2' >> tmp/CHIRP.csv
./multi_outputter.py --format CHIRP --input_file info/GMRS_and_FRS_UHF.yaml \
    | tail --lines='+2' >> tmp/CHIRP.csv
./multi_outputter.py --format CHIRP --input_file info/Weather_info_VHF.yaml \
    | tail --lines='+2' >> tmp/CHIRP.csv

# Produce a fresh nearly ready-to-print channel memory listing containing the same data
./multi_outputter.py --format HUMAN --input_file repeaters/RLARC_LNL_ARES_AARC.yaml \
    >> tmp/Printout.csv
./multi_outputter.py --format HUMAN --input_file repeaters/CRRA_RCARC.yaml \
    | tail --lines='+2' >> tmp/Printout.csv
./multi_outputter.py --format HUMAN --input_file repeaters/OARC_OVMRC_EMRG.yaml \
    | tail --lines='+2' >> tmp/Printout.csv
./multi_outputter.py --format HUMAN --input_file info/Simplex_FM_VHF.yaml \
    | tail --lines='+2' >> tmp/Printout.csv
./multi_outputter.py --format HUMAN --input_file info/Simplex_FM_UHF.yaml \
    | tail --lines='+2' >> tmp/Printout.csv
./multi_outputter.py --format HUMAN --input_file info/GMRS_and_FRS_UHF.yaml \
    | tail --lines='+2' >> tmp/Printout.csv
./multi_outputter.py --format HUMAN --input_file info/Weather_info_VHF.yaml \
    | tail --lines='+2' >> tmp/Printout.csv
