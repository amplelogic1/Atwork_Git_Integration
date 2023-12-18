#!/bin/bash

# Define the list of organizations
org_list=(
  "33test3322"
  "33testl21"
)

# Loop through each organization
for org in "${org_list[@]}"; do
  # Create Npm repositories and groups
  curl -X POST -u admin:Ample@0908 --header 'Content-Type: application/json' \
    http://192.168.1.208:30589/service/rest/v1/script \
    -d '{"name":"'$org'","type":"groovy","content":"repository.createNpmHosted('\'''$org'-npm-hosted'\'');repository.createNpmGroup('\'''$org'-npm-group'\'',['\'''$org'-npm-hosted'\'','\''Ample-Npm-Group'\''])"}'

  curl -X POST -u admin:Ample@0908 --header "Content-Type: text/plain" \
    "http://192.168.1.208:30589/service/rest/v1/script/$org/run"

  # Create NuGet repositories and groups
  curl -X POST -u admin:Ample@0908 --header 'Content-Type: application/json' \
    http://192.168.1.208:30589/service/rest/v1/script \
    -d '{"name":"'$org'","type":"groovy","content":"repository.createNugetHosted('\'''$org'-nuget-hosted'\'');repository.createNugetGroup('\'''$org'-nuget-group'\'',['\'''$org'-nuget-hosted'\'','\''Ample-Nuget-hosted'\''])"}'

  curl -X POST -u admin:Ample@0908 --header "Content-Type: text/plain" \
    "http://192.168.1.208:30589/service/rest/v1/script/$org/run"
done
