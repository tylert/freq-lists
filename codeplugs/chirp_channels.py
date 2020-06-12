#!/usr/bin/env python

# Convert a CHIRP CSV file into a DMR codeplug channel payload


import csv
import json

import click


def plop_channel(item, contact_name=None, group_list=None, scan_list=None):
    '''
    '''

    channel = {
        "AdmitCriteria": "Always",
        "AllowTalkaround": "Off",
        "Autoscan": "Off",
        "ColorCode": "1",
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
        "InCallCriteria": "Always",
        "LeaderMS": "Off",
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
        "SendGPSInfo": "Off",
        "Squelch": "2",
        "Talkaround": "Off",
        "Tot": "300",
        "TotRekeyDelay": "0",
        "TxRefFrequency": "Low",
        "TxSignallingSystem": "Off",
        "Vox": "Off"
    }

    if scan_list is not None:
        channel['ScanList'] = scan_list
    else:
        channel['ScanList'] = 'None'

    if item['Mode'] == 'FM':
        channel['Bandwidth'] = '25'
        channel['ChannelMode'] = 'Analog'
        channel['ContactName'] = 'None'
        channel['GroupList'] = 'None'
    elif item['Mode'] == 'DMR':
        channel['Bandwidth'] = '12.5'
        channel['ChannelMode'] = 'Digital'

        if contact_name is not None:
            channel['ContactName'] = contact_name
        else:
            channel['ContactName'] = 'None'

        if group_list is not None:
            channel['GroupList'] = group_list
        else:
            channel['GroupList'] = 'None'


    channel['Name'] = item['Name']
    channel['RxFrequency'] = item['Frequency']

    if item['Tone'] == 'TSQL':
        channel['CtcssDecode'] = item['rToneFreq']
        channel['CtcssEncode'] = item['cToneFreq']
    elif item['Tone'] == 'Tone':
        channel['CtcssDecode'] = 'None'
        channel['CtcssEncode'] = item['cToneFreq']
    else:
        channel['CtcssDecode'] = 'None'
        channel['CtcssEncode'] = 'None'

    if item['Duplex'] == '':
        channel['TxFrequencyOffset'] = '+0.00000'
    else:
        channel['TxFrequencyOffset'] = '{}{:.5f}'.format(item['Duplex'],
                                                         float(item['Offset']))

    return json.dumps(channel, indent=2, sort_keys=True)


@click.command()
@click.option('--contact_name', '-c', default=None, help='ContactName value')
@click.option('--input_filename', '-i', help='Input CHIRP filename')
@click.option('--group_list', '-g', default=None, help='GroupList value')
@click.option('--scan_list', '-s', default=None, help='ScanList value')
def main(contact_name, input_filename, group_list, scan_list):
    '''
    '''

    dict_list = []
    with open(input_filename, 'r') as input_file:
        reader = csv.DictReader(input_file)
        for item in reader:
            dict_list.append(plop_channel(item,
                                          contact_name=contact_name,
                                          group_list=group_list,
                                          scan_list=scan_list))

    for thing in dict_list:
        print('{},'.format(thing))


if __name__ == '__main__':
    main()
