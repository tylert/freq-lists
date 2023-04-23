#!/usr/bin/env python


#   https://stackoverflow.com/questions/4913349/haversine-formula-in-python-bearing-and-distance-between-two-gps-points
#   https://plus.codes/map
#   https://github.com/google/open-location-code
#   https://en.wikipedia.org/wiki/Open_Location_Code
#   https://en.wikipedia.org/wiki/Haversine_formula


from math import asin, atan2, cos, degrees, radians, sin, sqrt
# import urllib.parse

import click
from openlocationcode import openlocationcode as olc


repeater = {
    'VE2CRA @ Camp Fortune': '87Q6G532+42',
    'VE3OCE @ Alta Vista': '87Q698MQ+CCC',
    'VA3OFS @ Barrhaven': '87Q677G2+8HV',
    'VA3EMV/W @ Stittsville': '87Q6733M+RV2',
    'VE3KJG @ Lavant': '87Q528WJ+CH',
    'VA3TEL @ Christie Lake': '87P5RH98+P3',
    'VE3REX @ Rideau Ferry': '87P5RVPV+54',
    'VE3WPO @ Westport': '87P5MJ93+FG',
    'VE3RLR @ Railway Museum': '87P5WX2C+MJ',
    # 'VA3AAR': '',
    # 'VA3ARE': '',
    'VE3HOZ @ Carp': '87Q57W5M+R5',
    'VA3RRD @ McVeety\'s Bay': '87P5RRP6+9VJ',
    'VE3FRG @ South Frontenac': '87P57FWC+Q4',
}
checkpoint = {
    # 'Algonquin': '',
    # 'Knoxdale': '',
    # 'Stoney Swamp': '',
    # 'Hope Side': '',
    # 'Eagleson': '',
    # 'Huntley': '',
    # 'Dwyer Hill': '',
    'Ashton': '87Q55X5C+86M',
    # 'Cemetery': '',
    'Blacks Corners': '87Q54V5V+3X',
    'Loon Lane': '87Q52RVM+6G',
    'Concession 4D': '87P5XRJC+9F',
    'Ebert': '87P5WQMX+49P',
    'Last Duel': '87P5VQX6+CH',
    # 'Christie Lake': '',
    '6 & 36': '87P5PFQX+QR',
    # 'Westport Hill': '',
    'Shillington': '87P5MH6V+H8',
    'Pine Haven': '87P5HH77+5HH',
    'Conlon Farm': '87P5VPQW+VJV',
    # 'Elmgrove': '',
    # 'Narrows Lock': '',
    # 'Crosby': '',
    # 'Delta': '',
    # 'Lyndhurst', '',
    # 'Perth Road': '',
    'Inverary': '87P59GMG+Q2',
    'Glenburnie': '87P58F9W+XRF',
    'MacAdoo\'s': '87P57FGX+FQQ',
    'Queen\'s': '87P56GF2+C4R',
}


def decode(plus_code: str = None) -> tuple[float, float]:
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
    # Don't even bother with Bing, it doesn't work on Firefox!!!
    # urllib.parse.quote(whatever)

    # lat_long = f'{decode(plus_code)[0]}, {decode(plus_code)[1]}'
    # return f'https://{lat_long}'


def haversine(coord1: tuple[float, float], coord2: tuple[float, float]) -> float:
    ''' '''
    lat1, lon1 = coord1
    lat2, lon2 = coord2

    R = 6372.8  # Earth radius in kilometers
    # R = 3959.87433  # Earth radius in miles

    dLat = radians(lat2 - lat1)
    dLon = radians(lon2 - lon1)
    lat1 = radians(lat1)
    lat2 = radians(lat2)

    a = sin(dLat / 2) ** 2 + cos(lat1) * cos(lat2) * sin(dLon / 2) ** 2
    c = 2 * asin(sqrt(a))

    return R * c


def bearing(coord1: tuple[float, float], coord2: tuple[float, float]) -> float:
    ''' '''
    lat1, lon1 = coord1
    lat2, lon2 = coord2

    bearing = degrees(
        atan2(
            sin(lon2 - lon1) * cos(lat2),
            cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(lon2 - lon1),
        )
    )

    return (bearing + 360) % 360


@click.command()
@click.option(
    '--location',
    '-l',
    default='87P5VQX6+CH',  # checkpoint['Last Duel']
    help='OLC point (default "87P5VQX6+CH").',
)
def main(location):
    '''Calculate distance and bearing to repeaters and checkpoints.'''

    print(f'From {decode(location)} {location}')
    print('')

    # Show distance and bearing to all repeaters from your chosen location
    for name, plus_code in repeater.items():
        print(
            f'{decode(plus_code)} {name} is {haversine(decode(location), decode(plus_code)):.1f} km from your location at {bearing(decode(location), decode(plus_code)):.0f}°'
        )

    # Show distance and bearing from each checkpoint to the next one
    print('')
    # XXX FIXME TODO  Use 'Algonquin' as the startpoint!!!
    next_one = ('Ashton', checkpoint['Ashton'])
    for name, plus_code in checkpoint.items():
        print(
            f'{decode(plus_code)} {name} is {haversine(decode(next_one[1]), decode(plus_code)):.1f} km from {next_one[0]} at {bearing(decode(next_one[1]), decode(plus_code)):.0f}°'
        )
        next_one = (name, plus_code)


if __name__ == '__main__':
    main()
