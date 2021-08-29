#!/usr/bin/env python


# XXX FIXME TODO CSV output???
# XXX FIXME TODO RT Systems output???


from ruamel.yaml import YAML
import click


def output_chirp_channels(channels, max_name_length=16):
    print('Location,Name,Frequency,Duplex,Offset,Tone,rToneFreq,cToneFreq,DtcsCode,DtcsPolarity,Mode,TStep,Skip,Comment,URCALL,RPT1CALL,RPT2CALL,DVCODE')

    location = 1
    for channel in channels:
        name = channel['Name'][:max_name_length]  # XXX FIXME TODO Sanitize names!!!
        frequency = channel['RxFrequency']
        mode = channel['Mode']

        # Find out the duplex and offset
        if 'TxFrequencyOffset' in channel.keys():
            if channel['TxFrequencyOffset'] is None \
                    or channel['TxFrequencyOffset'] == '' \
                    or channel['TxFrequencyOffset'] == '+0.0':
                duplex = ''
                offset = 0
            else:
                duplex = channel['TxFrequencyOffset'][0:1]
                offset = float(channel['TxFrequencyOffset'][1:])
        else:
            duplex = ''
            offset = 0

        # Offer CTCSS???
        if 'CtcssDecode' in channel.keys():
            if channel['CtcssDecode'] is None \
                    or channel['CtcssDecode'] == 'None' \
                    or channel['CtcssDecode'] == '':
                r_tone_freq = '88.5'
            else:
                r_tone_freq = channel['CtcssDecode']
        else:
            r_tone_freq = '88.5'

        # Demand CTCSS???
        if 'CtcssEncode' in channel.keys():
            if channel['CtcssEncode'] is None \
                    or channel['CtcssEncode'] == 'None' \
                    or channel['CtcssEncode'] == '':
                c_tone_freq = '88.5'
            else:
                c_tone_freq = channel['CtcssEncode']
        else:
            c_tone_freq = '88.5'

        # XXX FIXME TODO Get the tone field working properly!!!

        # XXX FIXME TODO Get DCS/DTCS stuff working!!!
        dtcs_code = '023'
        dtcs_polarity = 'NN'

        # Figure out a "good" TStep value
        if frequency > 30:  # VHF and up
            if frequency > 300:  # UHF and up
                tstep = 6.25
            else:
                tstep = 5.00
        else:
            tstep = 5.00

        print(f"{location},{name},{frequency:.6f},{duplex},{offset:.6f},,{r_tone_freq},{c_tone_freq},{dtcs_code},{dtcs_polarity},{mode},{tstep:.2f},,,,,,")
        location += 1


# XXX FIXME TODO length switch

@click.command()
@click.option('--input_file', '-i', default=None, help='input')
def main(input_file):
    with open(input_file) as f:
        yaml = YAML(typ='safe')
        payload = yaml.load(f)

    output_chirp_channels(payload['channels'], max_name_length=6)


if __name__ == '__main__':
    main()
