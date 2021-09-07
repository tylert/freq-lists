#!/usr/bin/env python


# XXX FIXME TODO CSV output???
# XXX FIXME TODO RT Systems output???

import json

from ruamel.yaml import YAML
import click


def output_retevis_channels(channels):
    for channel in channels:
        output = {
            "AdmitCriteria": "Always",
            "AllowTalkaround": "Off",
            "Autoscan": "Off",
            "Bandwidth": "12.5",
            "ChannelMode": "Digital",
            "ColorCode": "1",
            "ContactName": "Contact1",
            "CtcssDecode": "None",
            "CtcssEncode": "None",
            "DCDMSwitch": "Off",
            "DataCallConfirmed": "Off",
            "Decode1": "Off",
            "Decode2": "Off",
            "Decode3": "Off",
            "Decode4": "Off",
            "Decode5": "Off",
            "Decode6": "Off",
            "Decode7": "Off",
            "Decode8": "Off",
            "DisplayPTTID": "Off",
            "EmergencyAlarmAck": "Off",
            "EmergencySystem": "None",
            "GPSSystem": "None",
            "GroupList": "GroupList1",
            "InCallCriteria": "Follow Admit Criteria",
            "LeaderMS": "Off",
            "LoneWorker": "Off",
            "Name": "SUPERCALIFRAGILISTICEXPIALIDOCIOUS",
            "Power": "High",
            "Privacy": "None",
            "PrivacyNumber": "1",
            "PrivateCallConfirmed": "Off",
            "QtReverse": "180",
            "ReceiveGPSInfo": "Off",
            "RepeaterSlot": "1",
            "ReverseBurst": "On",
            "RxFrequency": "144.00000",
            "RxOnly": "Off",
            "RxRefFrequency": "Low",
            "RxSignallingSystem": "Off",
            "ScanList": "ScanList1",
            "SendGPSInfo": "Off",
            "Squelch": "1",
            "Talkaround": "Off",
            "Tot": "60",
            "TotRekeyDelay": "0",
            "TxFrequencyOffset": "+0.00000",
            "TxRefFrequency": "Low",
            "TxSignallingSystem": "Off",
            "Vox": "Off",
        }

        # Ensure there is always a 'Name', 'RxFrequency' and 'Mode' for each channel
        if 'Name' not in channel.keys() or channel['Name'] == '':
            raise ValueError('Missing Name for entry!')
        if 'RxFrequency' not in channel.keys() or channel['RxFrequency'] == '':
            raise ValueError('Missing RxFrequency for entry!')
        if 'Mode' not in channel.keys() or channel['Mode'] == '':
            raise ValueError('Missing Mode for entry!')

        # Use 'Mode' to determine 'Bandwidth' and 'ChannelMode'.
        if channel['Mode'] == 'DMR':
            output['Bandwidth'] = '12.5'
            output['ChannelMode'] = 'Digital'
            del channel['Mode']
        elif channel['Mode'] == 'NFM':
            output['Bandwidth'] = '12.5'
            output['ChannelMode'] = 'Analog'
            del channel['Mode']
        elif channel['Mode'] == 'FM':
            output['Bandwidth'] = '25'
            output['ChannelMode'] = 'Analog'
            del channel['Mode']
        else:
            raise ValueError('Unknown mode encountered!')

        # Merge channel into expected output
        output.update(channel)

        # XXX FIXME TODO Force TalkGroup to turn into ContactName!!!
        if 'TalkGroup' in output.keys():
            del output['TalkGroup']

        # Force things that might be integers/floats to be strings (for JSON)
        output['RxFrequency'] = f"{channel['RxFrequency']:.5f}"
        if 'Bandwidth' in channel.keys():
            output['Bandwidth'] = f"{str(channel['Bandwidth'])}"
        if 'ColorCode' in channel.keys():
            output['ColorCode'] = f"{str(channel['ColorCode'])}"
        if 'CtcssDecode' in channel.keys():
            output['CtcssDecode'] = f"{str(channel['CtcssDecode'])}"
        if 'CtcssEncode' in channel.keys():
            output['CtcssEncode'] = f"{str(channel['CtcssEncode'])}"
        if 'RepeaterSlot' in channel.keys():
            output['RepeaterSlot'] = f"{str(channel['RepeaterSlot'])}"

        # Set 'AdmitCriteria' to 'Always' for simplex and analog or 'Color
        # code' when using DMR repeaters.
        if output['ChannelMode'] == 'Digital':
            if (
                'TxFrequencyOffset' in channel.keys()
                and channel['TxFrequencyOffset'] is not None
                and channel['TxFrequencyOffset'] != 'None'
                and channel['TxFrequencyOffset'] != ''
                and channel['TxFrequencyOffset'] != '+0.0'
            ):
                output['AdmitCriteria'] = 'Color Code'

        #     output['TxFrequencyOffset'] = '{}{:.5f}'.format(
        #         item['Duplex'], float(item['Offset'])

        print(json.dumps(output, indent=2, sort_keys=True))


def sanitize_channel_name(name, length=8):
    # XXX FIXME TODO Maybe round up when truncating numerical channel names???

    # Make sure nobody tries to ask for a negative number
    if length < 0:
        raise ValueError('Invalid name length!')

    # Truncate name to the specified length and cull any trailing whitespace
    # Force names to not have strange, chopped-off stuff at the end
    new_name = name[:length].strip()
    if ' ' in new_name:
        new_name = name[:length].strip().split()[0]

    # Provive the sanitized name
    return new_name


def output_chirp_channels(channels, max_name_length=8):
    # For some bizarre reason, the GUI has different column header names than the CSV files do...
    # https://chirp.danplanet.com/projects/chirp/wiki/MemoryEditorColumns

    print(
        'Location,Name,Frequency,Duplex,Offset,Tone,rToneFreq,cToneFreq,DtcsCode,DtcsPolarity,Mode,TStep,Skip,Comment,URCALL,RPT1CALL,RPT2CALL,DVCODE'
    )

    location = 1
    for channel in channels:
        name = sanitize_channel_name(channel['Name'], max_name_length)
        frequency = channel['RxFrequency']
        mode = channel['Mode']

        # Duplex and offset?
        if (
            'TxFrequencyOffset' in channel.keys()
            and channel['TxFrequencyOffset'] is not None
            and channel['TxFrequencyOffset'] != 'None'
            and channel['TxFrequencyOffset'] != ''
            and channel['TxFrequencyOffset'] != '+0.0'
        ):
            duplex = channel['TxFrequencyOffset'][0:1]
            offset = float(channel['TxFrequencyOffset'][1:])
        else:
            duplex = ''
            offset = 0

        # Send CTCSS tones?
        if (
            'CtcssEncode' in channel.keys()
            and channel['CtcssEncode'] is not None
            and channel['CtcssEncode'] != 'None'
            and channel['CtcssEncode'] != ''
        ):
            c_tone_freq = channel['CtcssEncode']
        else:
            c_tone_freq = '88.5'

        # Expect CTCSS tones?
        if (
            'CtcssDecode' in channel.keys()
            and channel['CtcssDecode'] is not None
            and channel['CtcssDecode'] != 'None'
            and channel['CtcssDecode'] != ''
        ):
            r_tone_freq = channel['CtcssDecode']
        else:
            r_tone_freq = '88.5'

        # CTCSS tone type?
        if (
            'CtcssEncode' in channel.keys()
            and 'CtcssDecode' in channel.keys()
            and channel['CtcssEncode'] is not None
            and channel['CtcssDecode'] is not None
            and channel['CtcssEncode'] != 'None'
            and channel['CtcssDecode'] != 'None'
            and channel['CtcssEncode'] != ''
            and channel['CtcssDecode'] != ''
        ):
            tone = 'TSQL'
        elif (
            'CtcssEncode' in channel.keys()
            and channel['CtcssEncode'] is not None
            and channel['CtcssEncode'] != 'None'
            and channel['CtcssEncode'] != ''
        ):
            tone = 'Tone'
            r_tone_freq = c_tone_freq
        else:
            tone = ''

        # XXX FIXME TODO Get DCS/DTCS stuff working!!!
        dtcs_code = '023'
        dtcs_polarity = 'NN'

        # Tstep?
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


@click.command()
@click.option('--input_file', '-i', default=None, help='input')
@click.option(
    '--max_name_length',
    '-m',
    default=8,
    help='Maximum length of channel names (default 8).',
)
def main(input_file, max_name_length):
    # XXX FIXME TODO if input file is none, use stdin
    with open(input_file) as f:
        yaml = YAML(typ='safe')
        payload = yaml.load(f)

    # output_chirp_channels(channels=payload['channels'], max_name_length=max_name_length)
    output_retevis_channels(channels=payload['channels'])


if __name__ == '__main__':
    main()
