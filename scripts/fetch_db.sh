#!/usr/bin/env bash

# Fetch the latest DMR ID database and prepare it to be uploaded to the radios
# Required tools:  bash, cut, dmrRadio, grep, mkdir, printf, sort, wget

# set -x
mkdir -p tmp

#   ____            _             _         ____  ____
#  / ___|___  _ __ | |_ __ _  ___| |_ ___  |  _ \| __ )
# | |   / _ \| '_ \| __/ _` |/ __| __/ __| | | | |  _ \
# | |__| (_) | | | | || (_| | (__| |_\__ \ | |_| | |_) |
#  \____\___/|_| |_|\__\__,_|\___|\__|___/ |____/|____/

# CCSS7 = Common Channel Signalling System 7 (not related to ham radio)
# CCS7 = Callsign Communications System 7
#   https://sites.google.com/site/darathursdaynite/d-star/d-star-ccs7-whats-that

# Retevis RT90 contacts DB storage is limited to 100,000 entries
# Retevis RT3S contactd DB storage is limited to 120,000 entries

# Download CCS7 DMR ID database and try to ensure it still fits in the radio
# Force all rows to have 7 columns, sort by ID, drop lines that don't start with an ID
wget --continue --output-document=tmp/user.csv https://database.radioid.net/static/user.csv
cut -d',' -f1-7 tmp/user.csv | sort -g | grep -E '^[0-9]' > tmp/scrubbed.csv
# printf 'Canada\nUnited States\n' > tmp/countries.txt  # too big!!!
printf 'Australia\nCanada\nFrance\nUnited Kingdom\nNew Zealand\n' > tmp/countries.txt
dmrRadio filterUsers tmp/countries.txt tmp/scrubbed.csv tmp/filtered.csv

# Clean up intermediate and generated files
# rm -f tmp/*.txt
chmod 0644 tmp/*.csv
