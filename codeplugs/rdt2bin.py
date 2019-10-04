#!/usr/bin/env python

# Convert an rdt file output from the Tytera MD-380/MD-390 CPS software into a
# bin file similar to one that would be output from the md380tools md380-dfu
# read wrapper.

# Tested with CPS software version 1.36 on Debian Jessie 8.x under Wine.


import click


HEAD_SIZE = 549
BODY_SIZE = 262144
FOOT_SIZE = 16

EOF = 2


@click.command()
@click.option('--rdt_file_name', '-r', help='Input rdt "donor" file')
@click.option('--out_file_name', '-o', help='Output rdt file')
def main(rdt_file_name, out_file_name):
    '''
    '''

    with open(rdt_file_name, 'rb') as rdt_file:

        # Get size of body to extract
        rdt_file.seek(0, EOF)
        rdt_body_size = rdt_file.tell() - HEAD_SIZE - FOOT_SIZE
        rdt_file.seek(0, 0)

        # Make extra sure it's the right size
        if rdt_body_size != BODY_SIZE:
            print('Body size {} doesn\'t match expected size {}'
                  .format(rdt_body_size, BODY_SIZE))

        # Build the desired body to output
        rdt_file.seek(HEAD_SIZE, 0)
        body = rdt_file.read(rdt_body_size)

    with open(out_file_name, 'wb') as out_file:

        out_file.write(body)


if __name__ == '__main__':
    main()
