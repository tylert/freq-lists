#!/usr/bin/env python


# XXX FIXME TODO CSV output???
# XXX FIXME TODO RT Systems output???


from ruamel.yaml import YAML
import click


def sanitize_channel_name(name, length=8):
    # XXX FIXME TODO Maybe round up when truncating numerical channel names???

    # If the name is already the right length, just use it
    if len(name) <= length and length > 0:
        return name
    elif length < 0:
        raise ValueError('Invalid name length!')

    # Try to force the name to fix in the specified length and cull trailing whitespace
    new_name = name[:length].strip()

    # Try to force names to not have strange, chopped-off stuff at the end
    if ' ' in new_name:
        new_name = name[:length].strip().split()[0]

    # Provive the sanitized name
    return new_name


def output_chirp_channels(channels, max_name_length=8):
    # https://chirp.danplanet.com/projects/chirp/wiki/MemoryEditorColumns

    # XXX FIXME TODO Check that this is still the current header format for CHIRP!!!
    print(
        'Location,Name,Frequency,Duplex,Offset,Tone,rToneFreq,cToneFreq,DtcsCode,DtcsPolarity,Mode,TStep,Skip,Comment,URCALL,RPT1CALL,RPT2CALL,DVCODE'
    )

    location = 1
    for channel in channels:
        name = sanitize_channel_name(channel['Name'], max_name_length)
        frequency = channel['RxFrequency']
        mode = channel['Mode']

        # Find out the duplex and offset
        if 'TxFrequencyOffset' in channel.keys():
            if (
                channel['TxFrequencyOffset'] is None
                or channel['TxFrequencyOffset'] == ''
                or channel['TxFrequencyOffset'] == '+0.0'
            ):
                duplex = ''
                offset = 0
            else:
                duplex = channel['TxFrequencyOffset'][0:1]
                offset = float(channel['TxFrequencyOffset'][1:])
        else:
            duplex = ''
            offset = 0

        # Send CTCSS tones
        if 'CtcssEncode' in channel.keys():
            if (
                channel['CtcssEncode'] is not None
                and channel['CtcssEncode'] != 'None'
                and channel['CtcssEncode'] != ''
            ):
                c_tone_freq = channel['CtcssEncode']
            else:
                c_tone_freq = '88.5'
        else:
            c_tone_freq = '88.5'

        # Expect CTCSS tones
        if 'CtcssDecode' in channel.keys():
            if (
                channel['CtcssDecode'] is not None
                and channel['CtcssDecode'] != 'None'
                and channel['CtcssDecode'] != ''
            ):
                r_tone_freq = channel['CtcssDecode']
            else:
                r_tone_freq = '88.5'
        else:
            r_tone_freq = '88.5'

        # CTCSS tone type
        if 'CtcssEncode' in channel.keys() and 'CtcssDecode' in channel.keys():
            if (
                channel['CtcssEncode'] is not None
                and channel['CtcssDecode'] is not None
                and channel['CtcssEncode'] != 'None'
                and channel['CtcssDecode'] != 'None'
                and channel['CtcssEncode'] != ''
                and channel['CtcssDecode'] != ''
            ):
                tone = 'TSQL'
            elif (
                channel['CtcssEncode'] is not None
                and channel['CtcssEncode'] != 'None'
                and channel['CtcssEncode'] != ''
            ):
                tone = 'Tone'
            else:
                raise ValueError('Expecting a tone but not sending one!')
        else:
            tone = ''

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

        print(
            f"{location},{name},{frequency:.6f},{duplex},{offset:.6f},{tone},{r_tone_freq},{c_tone_freq},{dtcs_code},{dtcs_polarity},{mode},{tstep:.2f},,,,,,"
        )
        location += 1


def output_rt_systems_1_channels():
    print(
        'Receive Frequency,Transmit Frequency,Offset Frequency,Offset Direction,Repeater Use,Operating Mode,Name,Sub Name,Tone Mode,CTCSS,Rx CTCSS,DCS,DCS Polarity,Skip,Step,Digital Squelch,Digital Code,Your Callsign,Rpt-1 CallSign,Rpt-2 CallSign,LatLng,Latitude,Longitude,UTC Offset,Bank,Bank Channel Number,Comment'
    )


# 145.55,144.95,600 kHz,-DUP,,DV,D-Star VE3AAR C,,None,88.5 Hz,88.5 Hz,23,Both N,Off,10 kHz,Off,0,CQCQCQ,,,,,,, ,,
# 145.55,144.95,600 kHz,-DUP,,DV,D-Star Union V,,None,88.5 Hz,88.5 Hz,23,Both N,Off,10 kHz,Off,0,CQCQCQ,,,,,,, ,,
# 145.6,145.6, ,Simplex,,DV,145.600 Dstar Si,,None,88.5 Hz,88.5 Hz,23,Both N,Off,10 kHz,Off,0,,,,,,,, ,,
# 145.62,145.62, ,Simplex,,DV,145.620 Dstar Si,,None,88.5 Hz,88.5 Hz,23,Both N,Off,10 kHz,Off,0,,,,,,,, ,,
# 444.1,449.1,5.00 MHz,+DUP,,DV,VA3AAR B,,None,88.5 Hz,88.5 Hz,23,Both N,Off,25 kHz,Off,0,,,,,,,, ,,


def output_rt_systems_2_channels():
    print(
        'Channel Number,Receive Frequency,Transmit Frequency,Offset Frequency,Offset Direction,Operating Mode,Name,Tone Mode,CTCSS,Rx CTCSS,DCS,DCS Polarity,Skip,Step,Bank,Bank Channel Number,Comment,Digital Squelch,Digital Code,Your Callsign,Rpt-1 CallSign,Rpt-2 CallSign'
    )


# 19,445.8000,445.8,000 kHz,Simplex,DV,445.800 Dstar Simplex,None,88.5 Hz,88.5 Hz,23,Both N,Off,10 kHz,A: ,,,Off,0,,,


# XXX FIXME TODO length switch


@click.command()
@click.option('--input_file', '-i', default=None, help='input')
@click.option(
    '--max_name_length',
    '-m',
    default=8,
    help='Maximum length of channel names (default 8).',
)
def main(input_file, max_name_length):
    with open(input_file) as f:
        yaml = YAML(typ='safe')
        payload = yaml.load(f)

    output_chirp_channels(payload['channels'], max_name_length=max_name_length)


if __name__ == '__main__':
    main()
