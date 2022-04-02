#!/usr/bin/env python


from csv import reader

import click
from openpyxl.workbook import Workbook
# from openpyxl.styles import Font


def drop_a_deuce(csv_filename=None, xlsx_filename=None):
    ''' '''
    workbook = Workbook()
    sheet = workbook.active

    sheet.title = 'Handout'

    sheet.page_setup.orientation = sheet.ORIENTATION_LANDSCAPE
    sheet.page_setup.paperSize = sheet.PAPERSIZE_LETTER
    sheet.page_setup.fitToHeight = 0
    sheet.page_setup.fitToWidth = 1

    with open(csv_filename, 'r') as csv_file:
        rows = reader(csv_file)
        for row in rows:
            sheet.append(row)

    # for
            # sheet.column_dimensions['A']
            # sheet.font = Font(name='Lato', size=8)

    workbook.save(filename=xlsx_filename)


@click.command()
@click.option(
    '--input_file',
    '-i',
    default=None,
    help='Input file',
)
@click.option(
    '--output_file',
    '-o',
    default=None,
    help='Output file',
)
def main(input_file, output_file):
    ''' '''
    drop_a_deuce(csv_filename=input_file, xlsx_filename=output_file)


if __name__ == '__main__':
    main()
