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


def haversine(latlong1: tuple[float, float], latlong2: tuple[float, float]) -> tuple[float, float]:
    '''Calculate the distance in kilometers between 2 LatLong values.'''
    latitude1, longitude1 = latlong1
    latitude2, longitude2 = latlong2

    φ1 = radians(latitude1)
    φ2 = radians(latitude2)
    λ1 = radians(longitude1)
    λ2 = radians(longitude2)

    Δφ = φ2 - φ1
    Δλ = λ2 - λ1

    havθ = sin(Δφ / 2) ** 2 + cos(φ1) * cos(φ2) * sin(Δλ / 2) ** 2
    R = 6371  # radius of Earth in kilometers
    distance = 2 * R * asin(sqrt(min(1, havθ)))

    θ = atan2(sin(Δλ) * cos(φ2), cos(φ1) * sin(φ2) - sin(φ1) * cos(φ2) * cos(Δλ))
    bearing = (degrees(θ) + 360) % 360

    return distance, bearing
