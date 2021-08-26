#!/usr/bin/env python


from ruamel.yaml import YAML
import click


def output_chirp(channels, max_name_length=16):
    print('Location,Name,Frequency,Duplex,Offset,Tone,rToneFreq,cToneFreq,DtcsCode,DtcsPolarity,Mode,TStep,Skip,Comment,URCALL,RPT1CALL,RPT2CALL,DVCODE')

    count = 1
    for channel in channels:
        name = channel['Name'].split(' ')[0]
        frequency = channel['RxFrequency']
        mode = channel['Mode']

        # Find out the duplex and offset
        if channel['TxFrequencyOffset'] == '+0.0' \
                or channel['TxFrequencyOffset'] is None \
                or channel['TxFrequencyOffset'] == '':
            duplex = ''
            offset = 0

        print(f"{count},{name[:max_name_length]},{frequency:.6f},{duplex},{offset:.6f},,,,,,{mode}")
        count += 1


@click.command()
@click.option('--input_file', '-i', default=None, help='input')
def main(input_file):
    with open(input_file) as f:
        yaml = YAML(typ='safe')
        payload = yaml.load(f)

    output_chirp(payload['channels'], 7)


if __name__ == '__main__':
    main()
