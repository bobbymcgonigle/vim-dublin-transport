import json

def usingPython3():
    if sys.version_info >= ( 3,0 ):
        return True
    else:
        return False

# List all the different routes at a certain stop number
# Prints the bus number and the minutes due in
def listAllStopTimes( stopNumber ):
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
    httpResponse = json.loads( httpResponse.decode( 'utf-8' ) )
    realTimeResults = httpResponse[ 'results' ]

    print( "Next buses at stop: {}".format( httpResponse[ 'stopid' ] ) )
    for bus in realTimeResults:
        busInfo = "{} in {} minutes".format( bus[ 'route' ], bus[ 'duetime' ] )
        print( busInfo )

def main():
    # Testing with stop 583
    listAllStopTimes( 583 )
