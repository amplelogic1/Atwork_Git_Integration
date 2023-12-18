#!/bin/bash

# Default values
NEXUS_URL="http://192.168.1.248:8081/repository/al-npm-hosted"
REPO_NAME="al-npm-hosted"
USERNAME="admin"
PASSWORD="Ample@0908"
VERSION="2.1.9"

# Parse command-line arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --version=*)
      VERSION="${1#*=}"
      shift 1
      ;;
    --repository=*)
      REPO_NAME="${1#*=}"
      shift 1
      ;;
    *)
      echo "Invalid argument: $1"
      exit 1
      ;;
  esac
done

# List of package groups
PACKAGE_GROUPS=(
  'ngx-al-core'
  'ngx-al-controls'
  'ngx-al-controllers'
  'ngx-al-form-report-designer'
  'ngx-al-form-report-runtime'
  'ngx-al-graphical-reports-designer'
  'ngx-al-graphical-reports-designer'
  'ngx-al-infra'
  'ngx-al-boot'
  'ngx-al-ext'
)

# Iterate through the list of package groups and delete the specified version
for group in "${PACKAGE_GROUPS[@]}"; do
  # Form the URL for the package
  package_url="$NEXUS_URL/$group/-/$group-$VERSION.tgz"

  # Use curl to check if the package exists
  response=$(curl -s -o /dev/null -w "%{http_code}" -u "$USERNAME:$PASSWORD" "$package_url")

  if [ "$response" -eq 200 ]; then
    echo "Package $group:$VERSION found in Nexus. Deleting..."

    # Use curl to delete the package
    curl -v -u "$USERNAME:$PASSWORD" -X DELETE "$package_url"

    echo "Package $group:$VERSION deleted."
  else
    echo "Package $group:$VERSION not found in Nexus."
  fi
done
