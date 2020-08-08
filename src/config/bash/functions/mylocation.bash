#!/usr/bin/env bash

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : install
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : installer script for DFAPPNAME
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

__mylocation() {
if [ -z "$IPSTACK_ACCESS_TOKEN" ]; then
printf_red "This requires a free API key\n\t\thttps://ipstack.com/plan and the
\t\tEnviroment variable IPSTACK_ACCESS_TOKEN to\n\t\tbe set IE:export IPSTACK_ACCESS_TOKEN=myapikey"
else
OUTPUT_FILE=/tmp/server_location.txt
PUBLIC_IP="$(curl -LSs -4 http:/ifconfig.co/ip)"
curl -s http://api.ipstack.com/${PUBLIC_IP}?access_key=$IPSTACK_ACCESS_TOKEN | \
jq '.latitude,.longitude,.city,.region_name,.country_name,.zip' | \
while read -r LATITUDE; do
  read -r LONGITUDE
  read -r CITY
  read -r REGION
  read -r COUNTRY
  read -r ZIP
  echo -e "LAT: ${LATITUDE}\nLON: ${LONGITUDE}\nCity: ${CITY}\nRegion: ${REGION}\nCountry: ${COUNTRY}\nZip: ${ZIP}" | \
    tr --delete \" > \
    ${OUTPUT_FILE}
done

cat "${OUTPUT_FILE}"
rm -Rf "${OUTPUT_FILE}"
fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
