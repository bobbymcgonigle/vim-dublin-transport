import ApiHelper
import xml.etree.ElementTree as ET

#-------------------------------------------------------------------------------
# TODO: Add Description
#-------------------------------------------------------------------------------

def getStation( stationDesc, direction=None ):
    httpResponse = ApiHelper.getHttpResponse( stationDesc, useXML=True )
    tree = ET.parse( httpResponse )
    root = tree.getroot()
    print( "The next trains at {} are:".format( stationDesc ) )
    for child in root:
        if direction is None or child[ 18 ].text == direction:
            print( "Train {} towards {} in {} minutes".format( child[ 18 ].text,child[ 7 ].text, child[ 12 ].text ) )

