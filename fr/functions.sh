#!/bin/bash
# Here you can create functions which will be available from the commands file
# You can also use here user variables defined in your config file
# To avoid conflicts, name your function like this
# jv_pg_XX_myfunction () { }
# jv for JarVis
# pg for PluGin
# XX can be a two letters code for your plugin, ex: ww for Weather Wunderground
jv_pg_wz_check_traffic() {
local json=$(curl -s "https://www.waze.com/row-RoutingManager/routingRequest?from=x%3A$fromX+y%3A$fromY&to=x%3A$toX+y%3A$toY&at=0&returnJSON=true&returnGeometries=false&returnInstructions=true&timeout=60000&nPaths=3&clientVersion=4.0.0&options=AVOID_TRAILS%3At%2CALLOW_UTURNS%3At")
local crossTime=$(echo "$json" | jq -r -s 'map(.alternatives[0].response.results[].crossTime) | add')
local crossTimeWithoutRealTime=$(echo "$json" | jq -r -s 'map(.alternatives[0].response.results[].crossTimeWithoutRealTime) | add')
local start="Vous allez être retardé de "
local difference=$(($crossTime-$crossTimeWithoutRealTime))
local end=" secondes"
echo $start$difference$end
}

