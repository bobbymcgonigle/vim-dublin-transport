import ApiHelper

#-------------------------------------------------------------------------------
# List all the different routes at a certain stop number
# Prints the bus number and the minutes due in
# Useful if you can take any bus home at a certain stop
#-------------------------------------------------------------------------------

def listNextBuses( stopNumber, busNumber=None ):
    stopJSON = ApiHelper.getHttpResponse( stopNumber )
    realTimeResults = stopJSON[ 'results' ]

    print( "Next buses at stop: {}".format( stopJSON[ 'stopid' ] ) )
    for bus in realTimeResults:
        busInfo = "{} in {} minutes".format( bus[ 'route' ], bus[ 'duetime' ] )
        if bus[ 'route' ] == busNumber or busNumber is None:
            print( busInfo )
