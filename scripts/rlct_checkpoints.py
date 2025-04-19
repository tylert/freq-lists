#!/usr/bin/env python


# /// script
# requires-python = '>=3.10'
# dependencies = [
#   'click',
#   'openlocationcode',
# ]
# ///


from math import asin, atan2, cos, degrees, radians, sin, sqrt

# import urllib.parse

import click
from openlocationcode import openlocationcode as olc


def decode_olc(plus_code: str = None) -> tuple[float, float]:
    ''' '''
    return tuple(olc.decode(plus_code).latlng())


# def link(plus_code: str = None) -> str:
# ''' '''
# XXX FIXME TODO  Put in a match/case statement here and a selector!!!
#   https://plus.codes/${PLUS_CODE}
#   https://www.google.com/maps/place/${PLUS_CODE_URL_ENCODED}
#   https://duckduckgo.com/?ia=web&iaxm=maps&q=${LAT_LONG_URL_ENCODED}
#   https://www.openstreetmap.org/search/?query=${LAT_LONG_URL_ENCODED}
#   https://k7fry.com/grid/?qth=${MAIDENHEAD_GRID_SQUARE}
#   Bing too???
# urllib.parse.quote(whatever)

# lat_long = f'{decode_olc(plus_code)[0]}, {decode_olc(plus_code)[1]}'
# return f'https://{lat_long}'


def haversine(coord1: tuple[float, float], coord2: tuple[float, float]) -> float:
    '''Calculate the distance in kilometers between 2 LatLong values.'''
    lat1, lon1 = coord1
    lat2, lon2 = coord2

    R = 6372.8  # Earth radius in kilometers
    # R = 3959.87433  # Earth radius in miles

    d_lat = radians(lat2 - lat1)
    d_lon = radians(lon2 - lon1)
    lat1 = radians(lat1)
    lat2 = radians(lat2)

    a = sin(d_lat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(d_lon / 2) ** 2
    c = 2 * asin(sqrt(a))

    return R * c


def bearing(coord1: tuple[float, float], coord2: tuple[float, float]) -> float:
    '''Calculate the direction in degrees between 2 LatLong values.'''
    lat1, lon1 = coord1
    lat2, lon2 = coord2

    bearing = degrees(
        atan2(
            sin(lon2 - lon1) * cos(lat2),
            cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon2 - lon1),
        )
    )

    return (bearing + 360) % 360


repeater = {
    'VE2CRA': '87Q6G532+239',
    'VE3OCE': '87Q698MQ+CCC',
    'VA3OFS': '87Q677G2+8HV',
    'VA3EMV/W': '87Q6733M+RV2',
    'VA3UHR': '87Q55P64+RR',
    'VA3AAR': '87Q56Q9V+Q6',
    'VA3ARE': '87Q55Q89+29',
    'VE3KJG': '87Q528WJ+CHM',
    'VA3TEL': '87P5RH98+P3W',
    'VE3REX': '87P5RVPV+55V',
    'VE3RLR': '87P5WX2C+MJ',
    'VE3HOZ': '87Q57W5M+R5',
    'VA3RRD': '87P5RRP6+9VJ',
    'VE3FRG': '87P57FWC+Q3X',
    'VE3KBR': '87P57GPC+JC4',
}
checkpoint_classic = {
    'Algonquin': '87Q686XW+Q3',
    'Knoxdale': '87Q686FH+92',
    'Stoney Swamp': '87Q6854M+P73',
    'Hope Side': '87Q675G6+FP8',
    'Eagleson': '87Q674CV+22',
    'Huntley': '87Q663MV+X8',
    'Conley': '87Q66329+J7W',
    'Munster': '87Q652VG+9H',
    'Dwyer Hill': '87Q55XFW+WGH',
    'Ashton': '87Q55X5C+86M',
    'Cemetery': '87Q54WJJ+5X',
    'Blacks Corners': '87Q54V5V+3X',
    'Loon Lane': '87Q52RVM+6F9',
    'Concession 4D': '87P5XRJC+8CX',
    'Ebert': '87P5WQMX+49P',
    'Last Duel': '87P5VQX6+FCX',
    'Christie Lake': '87P5RJH5+36F',
    '6 & 36': '87P5PFQX+QR',
    'Westport Hill': '87P5MHVJ+HP',
    'Shillington': '87P5MH6V+H8',
    'Pine Haven': '87P5HH77+5HH',
    # 'Perth Road': '87P5',
    'Inverary': '87P59GMG+Q2',
    'Glenburnie': '87P58F9W+XRF',
    'MacAdoo\'s': '87P57FGX+FQQ',
    'Queen\'s': '87P56GF2+C4R',
}
checkpoint_century = {
    'Conlon Farm': '87P5VPRW+8P5',
    'Elmgrove': '87P5VR54+6QH',
    'Narrows Lock': '87P5PP33+4PJ',
    'Crosby': '87P5MP3V+M3C',
    'Delta': '87P5JV4H+MVC',
    'Lyndhurst': '87P5FRV6+MX6',
    # 'Perth Road': '87P5',
    'Inverary': '87P59GMG+Q2',
    'Glenburnie': '87P58F9W+XRF',
    'MacAdoo\'s': '87P57FGX+FQQ',
    'Queen\'s': '87P56GF2+C4R',
}


# @click.option(
#     '--name',
#     '-n',
#     default='',
#     help='Name assigned to location (default "").',
# )
@click.command()
@click.option(
    '--location',
    '-l',
    default='',
    help='Coordinates of location in OLC format (default "").',
)
def main(location: str = None) -> None:
    '''Calculate distance and direction to repeaters and checkpoints from a single location.'''

    # Show distance and bearing to all repeaters from your chosen location
    print(f'From {decode_olc(location)} {location}')
    for name, plus_code in repeater.items():
        print(
            f'{decode_olc(plus_code)} {name} is {haversine(decode_olc(location), decode_olc(plus_code)):.1f} km away at {bearing(decode_olc(location), decode_olc(plus_code)):.0f}°'
        )

    # Show distance and bearing from each checkpoint to the next one
    print('')
    print('Classic Route')
    next_one = ('Algonquin', checkpoint_classic['Algonquin'])
    for name, plus_code in checkpoint_classic.items():
        print(
            f'{decode_olc(plus_code)} {name} is {haversine(decode_olc(next_one[1]), decode_olc(plus_code)):.1f} km from {next_one[0]} at {bearing(decode_olc(next_one[1]), decode_olc(plus_code)):.0f}°'
        )
        next_one = (name, plus_code)

    # Show the same thing but on the alternate route
    print('')
    print('Century Route')
    next_one = ('Conlon Farm', checkpoint_century['Conlon Farm'])
    for name, plus_code in checkpoint_century.items():
        print(
            f'{decode_olc(plus_code)} {name} is {haversine(decode_olc(next_one[1]), decode_olc(plus_code)):.1f} km from {next_one[0]} at {bearing(decode_olc(next_one[1]), decode_olc(plus_code)):.0f}°'
        )
        next_one = (name, plus_code)


if __name__ == '__main__':
    main()


#   https://stackoverflow.com/questions/4913349/haversine-formula-in-python-bearing-and-distance-between-two-gps-points
#   https://plus.codes/map
#   https://github.com/google/open-location-code
#   https://en.wikipedia.org/wiki/Open_Location_Code
#   https://en.wikipedia.org/wiki/Haversine_formula
