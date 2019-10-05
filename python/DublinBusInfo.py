import urllib.request
import json

def listAllStopTimes( stopNumber ):
    data = urllib.request.urlopen("https://data.smartdublin.ie/cgi-bin/rtpi/realtimebusinformation?stopid=583&format=json").read()
    data = json.loads(data.decode('utf-8'))
    jsonArray = data[ 'results' ]

    print( "Next buses at stop: {}".format( data[ 'stopid' ] ) )
    for item in jsonArray:
        busInfo = "{} in {} minutes".format( item[ 'route' ], item[ 'duetime' ] )
        print( busInfo )

def main():
    # Testing with stop 583
    listAllStopTimes( 583 )
