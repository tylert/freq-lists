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
        if channel['TxFrequencyOffset'] is None \
                or channel['TxFrequencyOffset'] == '' \
                or channel['TxFrequencyOffset'] == '+0.0':
            duplex = ''
            offset = 0

        # Figure out a "good" TStep value
        if frequency > 30:  # VHF and up
            if frequency > 300:  # UHF and up
                tstep = 6.25  # kHz
            else:
                tstep = 5.00  # kHz
        # else:
        #     tstep = 1.00  # kHz
        # XXX FIXME TODO find out what tstep to use for HF

        # Send CTCSS???
        if 'CtcssDecode' in channel.keys():
            if channel['CtcssDecode'] is None \
                    or channel['CtcssDecode'] == '':
                r_tone_freq = '88.5'
        else:
            r_tone_freq = '88.5'

        # Expect CTCSS???
        if 'CtcssEncode' in channel.keys():
            if channel['CtcssEncode'] is not None \
                    or channel['CtcssEncode'] == '':
                c_tone_freq = '88.5'
        else:
            c_tone_freq = '88.5'

        # XXX FIXME TODO Get DCS/DTCS stuff working!!!
        dtcs_code = '023'
        dtcs_polarity = 'NN'

        print(f"{count},{name[:max_name_length]},{frequency:.6f},{duplex},{offset:.6f},,{r_tone_freq},{c_tone_freq},{dtcs_code},{dtcs_polarity},{mode},{tstep:.2f},,,,,,")
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
