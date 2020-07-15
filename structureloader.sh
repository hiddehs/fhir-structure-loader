#!/bin/bash
endpoint="http://localhost/Administration"
packageDirectory="package"
definition_count=0

function loadStructureDefintions() {
  echo "Loading StructureDefinitions in $1"
  for jsonFile in $1*.json; do
    if [ "$(cat $jsonFile | jq '.resourceType')" = '"StructureDefinition"' ]; then
      definition_count=definition_count+1
      id=$(cat $jsonFile | jq '.id' | sed 's/"//g')
      cmd="curl -sL -H \"Content-Type: application/json\" -X PUT --data  \"@$jsonFile\" -w '%{http_code}' $endpoint/StructureDefinition/$id -o /dev/null"
      statusCode=$(eval "$cmd")
      if [ $statusCode = "201" ] | [ $statusCode = "200" ]; then
        echo "[$statusCode] Loaded $jsonFile to $endpoint/StructureDefinition/$id "
      else
        echo "[$statusCode] Failed to load $jsonFile to $endpoint/StructureDefinition/$id"
      fi
    fi
  done
}

while [ $# -gt 0 ]; do
  case "$1" in
  --url* | -u*)
    if [[ "$1" != *=* ]]; then shift; fi # Value is next arg if no `=`
    URL="${1#*=}"
    ;;
  --package* | -p*)
    if [[ "$1" != *=* ]]; then shift; fi
    PACKAGE="${1#*=}"
    ;;
  --help | -h)
    printf "Usage: ./structureloader.sh [--url={Administration Endpoint} --package={Directory that contains unzipped package directory}]" # Flag argument
    exit 0
    ;;
  *)
    printf >&2 "Error: Invalid argument\n"
    exit 1
    ;;
  esac
  shift
done


if [ -n "$URL" ]; then endpoint=$URL; fi
if [ -n "$PACKAGE" ]; then packageDirectory=$PACKAGE; fi

echo "Configured Administration endpoint: $endpoint"
echo "Configured Package directory: $packageDirectory"

for d in $packageDirectory/*/; do
  loadStructureDefintions $d
  return
done

echo "Successfully Loaded $definition_count StructureDefinitions"
