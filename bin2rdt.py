#!/usr/bin/env python3

# Convert a md380tools bin file into an rdt file that can be read with the
# Tytera MD-380/MD-390 CPS software.  Must have an existing rdt file to provide
# a suitable header and footer portion.

# Tested with CPS software version 1.36 on Debian Jessie 8.x under Wine.


header_size = 549
# body_size = 262144
footer_size = 16

rdt_file_name = 'default1.rdt'
bin_file_name = 'out.bin'
out_file_name = 'foo.rdt'

EOF = 2

with open(rdt_file_name, 'rb') as rdt_file, \
        open(bin_file_name, 'rb') as bin_file:

    # Get size of body to overwrite
    rdt_file.seek(0, EOF)
    rdt_body_size = rdt_file.tell() - header_size - footer_size
    rdt_file.seek(0, 0)

    # Get size of body we are replacing it with
    bin_file.seek(0, EOF)
    bin_size = bin_file.tell()
    bin_file.seek(0, 0)

    # We found something stupid/rare maybe
    if rdt_body_size != bin_size:
        print('Sizes {} and {} don\'t match!'.format(rdt_body_size, bin_size))

    # Build the desired header, body and footer to output
    header = rdt_file.read(header_size)
    body = bin_file.read(bin_size)
    rdt_file.seek(-footer_size, EOF)
    footer = rdt_file.read(footer_size)

with open(out_file_name, 'wb') as out_file:

    out_file.write(header)
    out_file.write(body)
    out_file.write(footer)
