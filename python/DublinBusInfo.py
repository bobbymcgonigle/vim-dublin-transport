import json

def usingPython3():
    if sys.version_info >= ( 3,0 ):
        return True
    else:
        return False

# Helper function that returns the raw JSON info from a particular bus stop
# Example of its return can be viewed here in browser:
# https://data.smartdublin.ie/cgi-bin/rtpi/realtimebusinformation?stopid=46&format=json
def getStopJSON( stopNumber ):
    httpUrl = "https://data.smartdublin.ie/cgi-bin/rtpi/realtimebusinformation?stopid={}&format=json".format( stopNumber )
    if usingPython3:
        # Note: Against conventions to import here
        #       but not willing to spend more time with another workaround for Python2.x & Python3.x support
        import urllib.request
        httpResponse = urllib.request.urlopen( httpUrl ).read()
    else:
        # Same as note above
        import urllib2
        httpResponse = urllib2.urlopen( httpUrl ).read()
    return json.loads( httpResponse.decode( 'utf-8' ) )

# List all the different routes at a certain stop number
# Prints the bus number and the minutes due in
# Useful if you can take any bus home at a certain stop
def listNextBuses( stopNumber, busNumber=None ):
    stopJSON = getStopJSON( stopNumber )
    realTimeResults = stopJSON[ 'results' ]

    print( "Next buses at stop: {}".format( stopJSON[ 'stopid' ] ) )
    for bus in realTimeResults:
        busInfo = "{} in {} minutes".format( bus[ 'route' ], bus[ 'duetime' ] )
        if bus[ 'route' ] == busNumber or busNumber is None:
            print( busInfo )
