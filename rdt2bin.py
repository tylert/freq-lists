#!/usr/bin/env python3

# Convert an rdt file output from the Tytera MD-380/MD-390 CPS software into a
# bin file similar to one that would be output from the md380tools md380-dfu
# read wrapper.

# Tested with CPS software version 1.36 on Debian Jessie 8.x under Wine.


head_size = 549
body_size = 262144
foot_size = 16

rdt_file_name = 'out.rdt'
out_file_name = 'out.bin'

EOF = 2

with open(rdt_file_name, 'rb') as rdt_file:

    # Get size of body to extract
    rdt_file.seek(0, EOF)
    rdt_body_size = rdt_file.tell() - head_size - foot_size
    rdt_file.seek(0, 0)

    # Make extra sure it's the right size
    if rdt_body_size != body_size:
        print('Body size {} doesn\'t match expected size {}'
              .format(rdt_body_size, body_size))

    # Build the desired body to output
    rdt_file.seek(head_size, 0)
    body = rdt_file.read(rdt_body_size)

with open(out_file_name, 'wb') as out_file:

    out_file.write(body)
