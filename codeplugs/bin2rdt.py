#!/usr/bin/env python3

# Convert a md380tools bin file into an rdt file that can be read with the
# Tytera MD-380/MD-390 CPS software.  Must have an existing donor rdt file to
# provide a suitable header and footer portion.

# Tested with CPS software version 1.36 on Debian Jessie 8.x under Wine.


import click


HEAD_SIZE = 549
BODY_SIZE = 262144
FOOT_SIZE = 16

EOF = 2


@click.command()
@click.option('--bin_file_name', '-b', help='Input bin file')
@click.option('--rdt_file_name', '-r', help='Input rdt "donor" file')
@click.option('--out_file_name', '-o', help='Output rdt file')
def main(bin_file_name, rdt_file_name, out_file_name):
    '''
    '''

    with open(rdt_file_name, 'rb') as rdt_file, \
            open(bin_file_name, 'rb') as bin_file:

        # Get size of body to overwrite
        rdt_file.seek(0, EOF)
        rdt_body_size = rdt_file.tell() - HEAD_SIZE - FOOT_SIZE
        rdt_file.seek(0, 0)

        # Make extra sure it's the right size
        if rdt_body_size != BODY_SIZE:
            print('Body size {} doesn\'t match expected size {}'
                  .format(rdt_body_size, BODY_SIZE))

        # Get size of body we are replacing it with
        bin_file.seek(0, EOF)
        bin_size = bin_file.tell()
        bin_file.seek(0, 0)

        # We found something stupid/rare maybe
        if rdt_body_size != bin_size:
            print('Sizes {} and {} don\'t match!'.format(rdt_body_size,
                                                         bin_size))

        # Build the desired head, body and foot to output
        head = rdt_file.read(HEAD_SIZE)
        body = bin_file.read(bin_size)
        rdt_file.seek(-FOOT_SIZE, EOF)
        foot = rdt_file.read(FOOT_SIZE)
        # foot_bytes are likely 00 02 11 df 83 04 1a 01 55 46 44 10 12 71 65 8e

    with open(out_file_name, 'wb') as out_file:

        out_file.write(head)
        out_file.write(body)
        out_file.write(foot)


if __name__ == '__main__':
    main()
