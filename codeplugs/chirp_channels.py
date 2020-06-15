#!/usr/bin/env python

# Append channels from a CHIRP CSV file into a DMR codeplug JSON.
# Codeplug JSON must be in a format exported by Editcp.
# Currently supports codeplugs from Retevis RT3S and TYT MD-UV380 radios.


import csv
import json

import click


def plop_channel(item, contact_name='Contact1', group_list='GroupList1',
                 repeater_slot='1', rx_only='Off', scan_list='ScanList1'):
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
        "ReverseBurst": "On",
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

    if scan_list is not None and scan_list != '':
        channel['ScanList'] = scan_list
    else:
        channel['ScanList'] = 'None'

    if item['Mode'] == 'FM':
        channel['Bandwidth'] = '25'
        channel['ChannelMode'] = 'Analog'
        channel['ContactName'] = 'None'
        channel['GroupList'] = 'None'
        channel["RepeaterSlot"] = '1'
    if item['Mode'] == 'NFM':
        channel['Bandwidth'] = '12.5'
        channel['ChannelMode'] = 'Analog'
        channel['ContactName'] = 'None'
        channel['GroupList'] = 'None'
        channel["RepeaterSlot"] = '1'
    elif item['Mode'] == 'DMR':
        channel['Bandwidth'] = '12.5'
        channel['ChannelMode'] = 'Digital'
        channel['RepeaterSlot'] = repeater_slot

        if contact_name is not None and contact_name != '':
            channel['ContactName'] = contact_name
        else:
            channel['ContactName'] = 'None'

        if group_list is not None and group_list != '':
            channel['GroupList'] = group_list
        else:
            channel['GroupList'] = 'None'

    channel['Name'] = item['Name']
    channel['RxFrequency'] = item['Frequency']
    channel['RxOnly'] = rx_only

    if item['Tone'] == 'TSQL':
        channel['CtcssDecode'] = item['rToneFreq']
        channel['CtcssEncode'] = item['cToneFreq']
    elif item['Tone'] == 'Tone':
        channel['CtcssDecode'] = 'None'
        channel['CtcssEncode'] = item['cToneFreq']
    else:
        channel['CtcssDecode'] = 'None'
        channel['CtcssEncode'] = 'None'

    # XXX FIXME TODO  Add support for DCS
    # D023N, D023I, D754N, D754I, ...
    # elif item['Tone'] == 'DCS':
    #   channel['CtcssDecode'] = 'D{}{}'.format(item['DtcsCode'], item['DtcsPolarity'])
    #   channel['CtcssEncode'] = 'None'

    if item['Duplex'] == '':
        channel['TxFrequencyOffset'] = '+0.00000'
    else:
        channel['TxFrequencyOffset'] = '{}{:.5f}'.format(item['Duplex'],
                                                         float(item['Offset']))

    return json.dumps(channel, indent=2, sort_keys=True)


@click.command()
@click.option('--chirp_csv', '-i', default=None, help='CHIRP CSV input')
@click.option('--codeplug_json', '-j', default=None, help='Codeplug JSON input')
@click.option('--contact_name', '-c', default='Contact1', help='ContactName string')
@click.option('--group_list', '-g', default='GroupList1', help='GroupList string')
@click.option('--repeater_slot', '-r', default='1', help='RepeaterSlot 1 or 2')
@click.option('--rx_only', '-x', default='Off', help='RxOnly Off or On')
@click.option('--scan_list', '-s', default='ScanList1', help='ScanList string')
def main(chirp_csv, codeplug_json, contact_name, group_list, repeater_slot,
         rx_only, scan_list):
    '''
    '''

    # Read in the new channels to append from the CHIRP CSV file
    channels = []
    with open(chirp_csv, 'r') as csv_file:
        reader = csv.DictReader(csv_file)
        for item in reader:
            channels.append(json.loads(plop_channel(item,
                                                    contact_name=contact_name,
                                                    group_list=group_list,
                                                    repeater_slot=repeater_slot,
                                                    rx_only=rx_only,
                                                    scan_list=scan_list)))

    # Read in the existing codeplug JSON
    codeplug = {}
    with open(codeplug_json, 'r') as json_file:
        codeplug = json.load(json_file)

    # Tack on the new channels at the end of the list of existing channels
    codeplug['Channels'].extend(channels)

    # Spit out the updated codeplug JSON
    print(json.dumps(codeplug, indent=2, sort_keys=False))


if __name__ == '__main__':
    main()
