#!/usr/bin/env python3

# Convert a CHIRP CSV file into a codeplug channel payload


import csv
import json

import click


def plop_channel(item):
    '''
    '''

    channel = {
        "AdmitCriteria": "Always",
        "AllowTalkaround": "Off",
        "Autoscan": "Off",
        "ColorCode": "1",
        "CompressedUdpDataHeader": "On",
        "ContactName": "None",
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
        "GroupList": "None",
        "InCallCriteria": "Always",
        "LoneWorker": "Off",
        "Power": "High",
        "Privacy": "None",
        "PrivacyNumber": "1",
        "PrivateCallConfirmed": "Off",
        "QtReverse": "180",
        "ReceiveGPSInfo": "Off",
        "RepeaterSlot": "1",
        "ReverseBurst": "On",
        "RxOnly": "Off",
        "RxRefFrequency": "Low",
        "RxSignallingSystem": "Off",
        "ScanList": "None",
        "SendGPSInfo": "Off",
        "Squelch": "Normal",
        "Talkaround": "Off",
        "Tot": "300",
        "TotRekeyDelay": "0",
        "TxRefFrequency": "Low",
        "TxSignallingSystem": "Off",
        "Vox": "Off"
    }

    if item['Mode'] == 'FM':
        channel['ChannelMode'] = 'Analog'
        channel['Bandwidth'] = '25'
    # Assuming mode 'DIG' means 'DMR'
    elif item['Mode'] == 'DIG':
        channel['ChannelMode'] = 'Digital'
        channel['Bandwidth'] = '12.5'

    channel['Name'] = item['Name']
    channel['RxFrequency'] = item['Frequency']

    if item['Tone'] == 'TSQL':
        channel['CtcssEncode'] = item['cToneFreq']
        channel['CtcssDecode'] = item['rToneFreq']
    elif item['Tone'] == 'Tone':
        channel['CtcssEncode'] = item['cToneFreq']
        channel['CtcssDecode'] = 'None'
    else:
        channel['CtcssEncode'] = 'None'
        channel['CtcssDecode'] = 'None'

    if item['Duplex'] == '':
        channel['TxFrequencyOffset'] = '+0.00000'
    else:
        # XXX FIXME Force the offset to have 5 decimal places
        channel['TxFrequencyOffset'] = '{}{}'.format(item['Duplex'],
                                                     item['Offset'])

    return json.dumps(channel, indent=2, sort_keys=True)


@click.command()
@click.option('--channels', '-c', help='Input file')
def main(channels):
    '''
    '''

    dict_list = []
    with open(channels, 'r') as channels_file:
        reader = csv.DictReader(channels_file)
        for item in reader:
            dict_list.append(plop_channel(item))

    for thing in dict_list:
        print(thing)


if __name__ == '__main__':
    main()
