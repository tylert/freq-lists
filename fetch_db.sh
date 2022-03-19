#!/usr/bin/env bash

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

# Retevis RT90 storage is limited to 100,000
# Retevis RT3S storage is limited to 120,000

# Download CCS7 DMR ID database and try to ensure it still fits in the radio
# Force all rows to have 7 columns, sort by ID, drop lines that don't start with an ID
wget --continue --output-document=tmp/user.csv https://database.radioid.net/static/user.csv
cat tmp/user.csv | cut -d',' -f1-7 | sort -g | egrep '^[0-9]' > tmp/scrubbed.csv
# echo -e "Canada\nUnited States" > tmp/countries.txt  # too big!!!
echo -e "Australia\nCanada\nFrance\nUnited Kingdom\nNew Zealand" > tmp/countries.txt
dmrRadio filterUsers tmp/countries.txt tmp/scrubbed.csv tmp/filtered.csv
