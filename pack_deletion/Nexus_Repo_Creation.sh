#!/bin/bash

# Parse command-line options
while getopts ":p:" opt; do
  case $opt in
    p)
      project_code=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

# Check if project_code is provided
if [ -z "$project_code" ]; then
  echo "Usage: $0 -p <project_code>"
  exit 1
fi

# Define the organization names
org_npm="${project_code}-npm"
org_nuget="${project_code}-nuget"

# Create Npm repositories and groups
curl -X POST -u admin:Ample@0908 --header 'Content-Type: application/json' \
  http://192.168.1.208:30589/service/rest/v1/script \
  -d '{"name":"'$org_npm'","type":"groovy","content":"repository.createNpmHosted(\"'$org_npm'-hosted\");repository.createNpmGroup(\"'$org_npm'-group\", [\"'$org_npm'-hosted\",\"Ample-Npm-Group\"])"}'

curl -X POST -u admin:Ample@0908 --header "Content-Type: text/plain" \
  "http://192.168.1.208:30589/service/rest/v1/script/$org_npm/run"

# Create NuGet repositories and groups
curl -X POST -u admin:Ample@0908 --header 'Content-Type: application/json' \
  http://192.168.1.208:30589/service/rest/v1/script \
  -d '{"name":"'$org_nuget'","type":"groovy","content":"repository.createNugetHosted(\"'$org_nuget'-hosted\");repository.createNugetGroup(\"'$org_nuget'-group\", [\"'$org_nuget'-hosted\",\"Ample-Nuget-Group\"])"}'

curl -X POST -u admin:Ample@0908 --header "Content-Type: text/plain" \
  "http://192.168.1.208:30589/service/rest/v1/script/$org_nuget/run"
