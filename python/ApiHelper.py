import json
import sys

# Helper methods for support of different Python versions
def usingPython3():
    if sys.version_info[0] > 2:
        return True
    else:
        return False

# Helper function that returns the raw JSON info from a particular bus stop
# Or XML data for a train station
# As Irish rail's api only returns XML, we know that if useXML is true we're requesting train info
# Example of returns can be viewed here in browser:
# https://data.smartdublin.ie/cgi-bin/rtpi/realtimebusinformation?stopid=46&format=json or
# http://api.irishrail.ie/realtime/realtime.asmx/getStationDataByNameXML?StationDesc=Bayside

def getHttpResponse( stopOrStation, useXML=None ):
    # If we're not using XML we're using Dublin Bus
    if useXML is None:
        httpUrl = "https://data.smartdublin.ie/cgi-bin/rtpi/realtimebusinformation?stopid={}&format=json".format( stopOrStation )
    else:
        httpUrl = "http://api.irishrail.ie/realtime/realtime.asmx/getStationDataByNameXML?StationDesc={}".format( stopOrStation ) 
    if usingPython3() is True:
    # Note: Against conventions to import here
    #       but not willing to spend more time with another workaround for Python2.x & Python3.x support
        import urllib.request
        httpResponse = urllib.request.urlopen( httpUrl )
    else:
    # Same as note above
        import urllib2
        httpResponse = urllib2.urlopen( httpUrl )
    if useXML is None:
        return json.loads( httpResponse.read().decode( 'utf-8' ) )
    return httpResponse

