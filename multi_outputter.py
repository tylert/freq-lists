#!/usr/bin/env python


# Requires Python 3.10.x or newer (uses match-case)!!!  https://www.python.org/dev/peps/pep-0634/

# XXX FIXME TODO  Use a YAML library that is pure Python??? (To zipapp the "app" maybe?)


import json

# from csv import DictReader

import click
from ruamel.yaml import YAML


retevis_channel_stub = {
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
    "Name": "Channel1",
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
    "Tot": "360",
    "TotRekeyDelay": "0",
    "TxFrequencyOffset": "+0.00000",
    "TxRefFrequency": "Low",
    "TxSignallingSystem": "Off",
    "Vox": "Off",
}


def process_dmr_channels(entries, channel_stub):
    ''' '''
    channels = []
    for entry in entries:
        output = channel_stub

        # Ensure there is always a 'Name', 'RxFrequency' and 'Mode' for each
        # channel.
        if 'Name' not in entry.keys() or entry['Name'] == '':
            raise ValueError('Missing Name for entry!')
        if 'RxFrequency' not in entry.keys() or entry['RxFrequency'] == '':
            raise ValueError('Missing RxFrequency for entry!')
        if 'Mode' not in entry.keys() or entry['Mode'] == '':
            raise ValueError('Missing Mode for entry!')

        # Use 'Mode' to determine 'Bandwidth' and 'ChannelMode'.  Do this
        # before merging the new channel entry into the expected output in case
        # we are using a different bandwidth, say.
        match entry['Mode']:
            case 'DMR':
                output['Bandwidth'] = '12.5'
                output['ChannelMode'] = 'Digital'
                del entry['Mode']
            case 'NFM':
                output['Bandwidth'] = '12.5'
                output['ChannelMode'] = 'Analog'
                del entry['Mode']
            case 'FM':
                output['Bandwidth'] = '25'
                output['ChannelMode'] = 'Analog'
                del entry['Mode']
            case _:
                # AM?  DV?  Something else?
                raise ValueError('Unknown mode encountered!')

        # Merge the new channel entry into the expected output.
        output.update(entry)

        # XXX FIXME TODO  Force TalkGroup to turn into ContactName!!!
        if 'TalkGroup' in output.keys():
            del output['TalkGroup']

        # Ensure we don't try to send info about the location of repeater sites
        # to radios.
        if 'Notes' in output.keys():
            del output['Notes']

        # Force things that might be integers/floats to be strings (for JSON)
        output['RxFrequency'] = f"{entry['RxFrequency']:.5f}"
        if 'Bandwidth' in entry.keys():
            output['Bandwidth'] = f"{str(entry['Bandwidth'])}"
        if 'ColorCode' in entry.keys():
            output['ColorCode'] = f"{str(entry['ColorCode'])}"
        if 'CtcssDecode' in entry.keys():
            output['CtcssDecode'] = f"{str(entry['CtcssDecode'])}"
        if 'CtcssEncode' in entry.keys():
            output['CtcssEncode'] = f"{str(entry['CtcssEncode'])}"
        if 'RepeaterSlot' in entry.keys():
            output['RepeaterSlot'] = f"{str(entry['RepeaterSlot'])}"

        # Set 'AdmitCriteria' to 'Always' for simplex and analog or 'Color
        # code' when using DMR repeaters.
        if output['ChannelMode'] == 'Digital':
            if (
                'TxFrequencyOffset' in entry.keys()
                and entry['TxFrequencyOffset'] is not None
                and entry['TxFrequencyOffset'] != 'None'
                and entry['TxFrequencyOffset'] != ''
                and entry['TxFrequencyOffset'] != '+0.0'
            ):
                output['AdmitCriteria'] = 'Color code'

        # XXX FIXME TODO  Pad the TxFrequencyOffset out to 5 decimal places!!!
        #     output['TxFrequencyOffset'] = '{}{:.5f}'.format(
        #         item['Duplex'], float(item['Offset'])

        channels.append(json.loads(json.dumps(output)))

    return channels


def process_human_channels_csv(entries, max_name_length=8, start_index=1):
    ''' '''
    print('Channel,Name,Mode,Output,Input,Access,Notes')

    channel = start_index
    for entry in entries:
        name = entry['Name']
        rx_frequency = entry['RxFrequency']
        mode = entry['Mode']

        if 'Notes' in entry.keys():
            notes = entry['Notes']
        else:
            notes = ''

        if 'TxFrequencyOffset' in entry.keys():
            tx_frequency = round(
                float(rx_frequency) + float(entry['TxFrequencyOffset']), 4
            )
        else:
            tx_frequency = float(rx_frequency)

        # If there's a tone, it's usually for a good reason (e.g. "AMS mode" on YSF).
        if (
            'CtcssEncode' in entry.keys()
            and entry['CtcssEncode'] is not None
            and entry['CtcssEncode'] != 'None'
        ):
            access = f"{entry['CtcssEncode']} Hz"
        elif (
            'ColorCode' in entry.keys()
            and entry['ColorCode'] is not None
            and entry['ColorCode'] != 'None'
        ):
            access = f"CC={entry['ColorCode']}"
        else:
            access = ''

        print(f'{channel},{name},{mode},{rx_frequency},{tx_frequency},{access},{notes}')
        channel += 1


def sanitize_chirp_channel_name(name, length=8):
    ''' '''
    # XXX FIXME TODO  Round up when truncating numerical channel names!!!

    # Make sure nobody tries to ask for a negative number
    if length < 0:
        raise ValueError('Invalid name length!')

    # Truncate name to the specified length and cull any trailing whitespace
    # Force names to not have strange, chopped-off stuff at the end
    new_name = name[:length].strip()
    if ' ' in new_name:
        new_name = name[:length].strip().split()[0]

    # Provide the sanitized name
    return new_name


def process_chirp_channels_csv(entries, max_name_length=8, start_index=1):
    ''' '''
    # WARNING:  The CHIRP GUI has different column header names than its CSV files do

    # https://chirp.danplanet.com/projects/chirp/wiki/Home  # Supported radios
    # https://chirp.danplanet.com/projects/chirp/wiki/MemoryEditorColumns  # Column descriptions
    # https://trac.chirp.danplanet.com/chirp_daily/LATEST/Model_Support.html  # Allowed characters, lengths, memories, etc.

    print(
        'Location,Name,Frequency,Duplex,Offset,Tone,rToneFreq,cToneFreq,DtcsCode,DtcsPolarity,Mode,TStep,Skip,Comment,URCALL,RPT1CALL,RPT2CALL,DVCODE'
    )

    location = start_index
    for entry in entries:
        name = sanitize_chirp_channel_name(entry['Name'], max_name_length)
        frequency = entry['RxFrequency']
        mode = entry['Mode']

        # Do we have any alternate names for the location of a repeater site?
        if 'Notes' in entry.keys():
            comment = entry['Notes']
        else:
            comment = ''

        # Duplex and offset?
        if (
            'TxFrequencyOffset' in entry.keys()
            and entry['TxFrequencyOffset'] is not None
            and entry['TxFrequencyOffset'] != 'None'
            and entry['TxFrequencyOffset'] != ''
            and entry['TxFrequencyOffset'] != '+0.0'
        ):
            duplex = entry['TxFrequencyOffset'][0:1]
            offset = float(entry['TxFrequencyOffset'][1:])
            signed_offset = float(f'{duplex}{offset}')
        else:
            duplex = ''
            offset = 0
            signed_offset = float('+0.0')

        # Send CTCSS tones?
        if (
            'CtcssEncode' in entry.keys()
            and entry['CtcssEncode'] is not None
            and entry['CtcssEncode'] != 'None'
            and entry['CtcssEncode'] != ''
        ):
            c_tone_freq = entry['CtcssEncode']
        else:
            c_tone_freq = '88.5'

        # Expect CTCSS tones?
        if (
            'CtcssDecode' in entry.keys()
            and entry['CtcssDecode'] is not None
            and entry['CtcssDecode'] != 'None'
            and entry['CtcssDecode'] != ''
        ):
            r_tone_freq = entry['CtcssDecode']
        else:
            r_tone_freq = '88.5'

        # CTCSS tone type?
        if (
            'CtcssEncode' in entry.keys()
            and 'CtcssDecode' in entry.keys()
            and entry['CtcssEncode'] is not None
            and entry['CtcssDecode'] is not None
            and entry['CtcssEncode'] != 'None'
            and entry['CtcssDecode'] != 'None'
            and entry['CtcssEncode'] != ''
            and entry['CtcssDecode'] != ''
        ):
            tone = 'TSQL'
        elif (
            'CtcssEncode' in entry.keys()
            and entry['CtcssEncode'] is not None
            and entry['CtcssEncode'] != 'None'
            and entry['CtcssEncode'] != ''
        ):
            tone = 'Tone'
            r_tone_freq = c_tone_freq
        else:
            tone = ''

        # XXX FIXME TODO  Get DCS/DTCS stuff working!!!
        # D023N, D023I, D754N, D754I, ...
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
            f'{location},{name},{frequency:.6f},{duplex},{offset:.6f},{tone},{r_tone_freq},{c_tone_freq},{dtcs_code},{dtcs_polarity},{mode},{tstep:.2f},,{comment},,,,'
        )
        location += 1


def process_rt_systems_channels_csv(entries, max_name_length=8):
    ''' '''
    print(
        'Receive Frequency,Transmit Frequency,Offset Frequency,Offset Direction,Repeater Use,Operating Mode,Name,Sub Name,Tone Mode,CTCSS,Rx CTCSS,DCS,DCS Polarity,Skip,Step,Digital Squelch,Digital Code,Your Callsign,Rpt-1 CallSign,Rpt-2 CallSign,LatLng,Latitude,Longitude,UTC Offset,Bank,Bank Channel Number,Comment'
    )

    for entry in entries:
        name = sanitize_chirp_channel_name(entry['Name'], max_name_length)
        rx_frequency = entry['RxFrequency']
        mode = entry['Mode']

        if 'Notes' in entry.keys():
            comment = entry['Notes']
        else:
            comment = ''

        # Duplex and offset?
        if (
            'TxFrequencyOffset' in entry.keys()
            and entry['TxFrequencyOffset'] is not None
            and entry['TxFrequencyOffset'] != 'None'
            and entry['TxFrequencyOffset'] != ''
            and entry['TxFrequencyOffset'] != '+0.0'
        ):
            sign = entry['TxFrequencyOffset'][0:1]
            duplex = f'{sign}DUP'
            offset = entry['TxFrequencyOffset'][1:]
            if entry['TxFrequencyOffset'][1:] == '0.6':
                offset_frequency = '600 kHz'
            elif entry['TxFrequencyOffset'][1:] == '5.0':
                offset_frequency = '5.00 MHz'
            if sign == '+':
                tx_frequency = round(float(rx_frequency) + float(offset), 4)
            elif sign == '-':
                tx_frequency = round(float(rx_frequency) - float(offset), 4)
        else:
            sign = '+'
            duplex = 'Simplex'
            offset_frequency = ' '
            tx_frequency = rx_frequency

        # Send CTCSS tones?
        if (
            'CtcssEncode' in entry.keys()
            and entry['CtcssEncode'] is not None
            and entry['CtcssEncode'] != 'None'
            and entry['CtcssEncode'] != ''
        ):
            c_tone_freq = f"{entry['CtcssEncode']} Hz"
        else:
            c_tone_freq = '88.5 Hz'

        # Expect CTCSS tones?
        if (
            'CtcssDecode' in entry.keys()
            and entry['CtcssDecode'] is not None
            and entry['CtcssDecode'] != 'None'
            and entry['CtcssDecode'] != ''
        ):
            r_tone_freq = f"{entry['CtcssDecode']} Hz"
        else:
            r_tone_freq = '88.5 Hz'

        # CTCSS tone type?
        if (
            'CtcssEncode' in entry.keys()
            and 'CtcssDecode' in entry.keys()
            and entry['CtcssEncode'] is not None
            and entry['CtcssDecode'] is not None
            and entry['CtcssEncode'] != 'None'
            and entry['CtcssDecode'] != 'None'
            and entry['CtcssEncode'] != ''
            and entry['CtcssDecode'] != ''
        ):
            tone = 'T Sql'
        elif (
            'CtcssEncode' in entry.keys()
            and entry['CtcssEncode'] is not None
            and entry['CtcssEncode'] != 'None'
            and entry['CtcssEncode'] != ''
        ):
            tone = 'Tone'
            r_tone_freq = c_tone_freq
        else:
            tone = 'None'

        # XXX FIXME TODO  Get DCS/DTCS stuff working!!!
        # D023N, D023I, D754N, D754I, ...
        dtcs_code = '23'
        dtcs_polarity = 'Both N'

        # Tstep?
        if rx_frequency > 30:  # VHF and up
            if rx_frequency > 300:  # UHF and up
                tstep = '10 kHz'
            else:
                tstep = '5 kHz'
        else:
            tstep = '5 kHz'

        print(
            f'{rx_frequency},{tx_frequency},{offset_frequency},{duplex},,{mode},{name},,{tone},{c_tone_freq},{r_tone_freq},{dtcs_code},{dtcs_polarity},Off,{tstep},Off,0,,,,,,,, ,,{comment}'
        )


@click.command()
@click.option(
    '--format',
    '-f',
    default='CHIRP',
    help='Desired output format for data ("DMR", "HUMAN", "CHIRP", "RT")',
)
@click.option(
    '--input_file',
    '-i',
    default=None,
    help='Input YAML data file to process',
)
@click.option(
    '--json_file',
    '-j',
    default=None,
    help='Input JSON dictionary to merge',
)
@click.option(
    '--max_name_length',
    '-m',
    default=8,
    help='Maximum length of channel names (default 8).',
)
@click.option(
    '--start_index',
    '-s',
    default=1,
    help='Start index counter at specified value (default 1)',
)
def main(format, input_file, json_file, max_name_length, start_index):
    ''' '''
    # XXX FIXME TODO  Allow the use of STDIN as the input "file"!!!
    with open(input_file) as f:
        yaml = YAML(typ='safe')
        payload = yaml.load(f)

    # XXX FIXME TODO  Option to use CSV CHIRP data files as input maybe???
    # with open(chirp_csv, 'r') as csv_file:
    #     reader = DictReader(csv_file)
    #     for item in reader:
    #         print(item)

    match format.upper():
        case 'DMR':
            channels = process_dmr_channels(
                entries=payload['Channels'], channel_stub=retevis_channel_stub
            )

            # Read in the existing codeplug JSON and append new channels to the end of
            # the list.
            codeplug = {}
            with open(json_file, 'r') as f:
                codeplug = json.load(f)
            codeplug['Channels'].extend(channels)

            print(json.dumps(codeplug, indent=2, sort_keys=True))
        case 'HUMAN':
            process_human_channels_csv(
                entries=payload['Channels'],
                max_name_length=max_name_length,
                start_index=start_index,
            )
        case 'CHIRP':
            process_chirp_channels_csv(
                entries=payload['Channels'],
                max_name_length=max_name_length,
                start_index=start_index,
            )
        case 'RT':
            # XXX FIXME TODO  Test the RT Systems output!!!
            process_rt_systems_channels_csv(entries=payload['Channels'])
        case _:
            print(
                f'Format "{format_output}" is invalid.  Allowed values are:  "DMR", "HUMAN", "CHIRP", "RT"'
            )


if __name__ == '__main__':
    main()
