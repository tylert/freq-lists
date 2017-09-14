#!/usr/bin/env python3

# Convert a md380tools bin file into an rdt file that can be read with the
# Tytera MD-380/MD-390 CPS software.  Must have an existing donor rdt file to
# provide a suitable header and footer portion.

# Tested with CPS software version 1.36 on Debian Jessie 8.x under Wine.


head_size = 549
body_size = 262144
foot_size = 16

rdt_file_name = 'default1.rdt'
bin_file_name = 'out.bin'
out_file_name = 'foo.rdt'

EOF = 2

with open(rdt_file_name, 'rb') as rdt_file, \
        open(bin_file_name, 'rb') as bin_file:

    # Get size of body to overwrite
    rdt_file.seek(0, EOF)
    rdt_body_size = rdt_file.tell() - head_size - foot_size
    rdt_file.seek(0, 0)

    # Make extra sure it's the right size
    if rdt_body_size != body_size:
        print('Body size {} doesn\'t match expected size {}'
              .format(rdt_body_size, body_size))

    # Get size of body we are replacing it with
    bin_file.seek(0, EOF)
    bin_size = bin_file.tell()
    bin_file.seek(0, 0)

    # We found something stupid/rare maybe
    if rdt_body_size != bin_size:
        print('Sizes {} and {} don\'t match!'.format(rdt_body_size, bin_size))

    # Build the desired head, body and foot to output
    head = rdt_file.read(head_size)
    body = bin_file.read(bin_size)
    rdt_file.seek(-foot_size, EOF)
    foot = rdt_file.read(foot_size)
    # foot_bytes are likely 00 02 11 df 83 04 1a 01 55 46 44 10 12 71 65 8e

with open(out_file_name, 'wb') as out_file:

    out_file.write(head)
    out_file.write(body)
    out_file.write(foot)
