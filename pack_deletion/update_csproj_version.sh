#!/bin/bash

# Check if the version variable is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

version=$1
project_file="Ample.Web.csproj"  # Replace with your actual project file name

# Update the PackageReference version in the project file
sed -i "s/<PackageReference Include=\"Ample.3PAPI.ActiveDirectory\" Version=\"[0-9]*\.[0-9]*\.[0-9]*\" \/>/<PackageReference Include=\"Ample.3PAPI.ActiveDirectory\" Version=\"$version\" \/>/" $project_file

sed -i "s/<PackageReference Include=\"Ample.Boot\" Version=\"[0-9]*\.[0-9]*\.[0-9]*\" \/>/<PackageReference Include=\"Ample.Boot\" Version=\"$version\" \/>/" $project_file

sed -i "s/<PackageReference Include=\"Ample.DB.Config.MySql\" Version=\"[0-9]*\.[0-9]*\.[0-9]*\" \/>/<PackageReference Include=\"Ample.DB.Config.MySql\" Version=\"$version\" \/>/" $project_file

sed -i "s/<PackageReference Include=\"Ample.DB.Config.PostgreSQL\" Version=\"[0-9]*\.[0-9]*\.[0-9]*\" \/>/<PackageReference Include=\"Ample.DB.Config.Sql\" Version=\"$version\" \/>/" $project_file

sed -i "s/<PackageReference Include=\"Ample.DB.Config.Sql\" Version=\"[0-9]*\.[0-9]*\.[0-9]*\" \/>/<PackageReference Include=\"Ample.Engine\" Version=\"$version\" \/>/" $project_file

sed -i "s/<PackageReference Include=\"Ample.Engine\" Version=\"[0-9]*\.[0-9]*\.[0-9]*\" \/>/<PackageReference Include=\"Ample.Engine\" Version=\"$version\" \/>/" $project_file

sed -i "s/<PackageReference Include=\"Ample.Engine.Config\" Version=\"[0-9]*\.[0-9]*\.[0-9]*\" \/>/<PackageReference Include=\"Ample.Engine.Config\" Version=\"$version\" \/>/" $project_file

sed -i "s/<PackageReference Include=\"Ample.Engine.Data.Entities\" Version=\"[0-9]*\.[0-9]*\.[0-9]*\" \/>/<PackageReference Include=\"Ample.Engine.Data.Entities\" Version=\"$version\" \/>/" $project_file

sed -i "s/<PackageReference Include=\"Ample.Engine.Designer\" Version=\"[0-9]*\.[0-9]*\.[0-9]*\" \/>/<PackageReference Include=\"Ample.Engine.Designer\" Version=\"$version\" \/>/" $project_file

sed -i "s/<PackageReference Include=\"Ample.Engine.Runner\" Version=\"[0-9]*\.[0-9]*\.[0-9]*\" \/>/<PackageReference Include=\"Ample.Engine.Runner\" Version=\"$version\" \/>/" $project_file

sed -i "s/<PackageReference Include=\"Ample.Infrastructure.Data.Entities\" Version=\"[0-9]*\.[0-9]*\.[0-9]*\" \/>/<PackageReference Include=\"Ample.Infrastructure.Data.Entities\" Version=\"$version\" \/>/" $project_file

sed -i "s/<PackageReference Include=\"Ample.Infrastructure.DI\" Version=\"[0-9]*\.[0-9]*\.[0-9]*\" \/>/<PackageReference Include=\"Ample.Infrastructure.DI\" Version=\"$version\" \/>/" $project_file

sed -i "s/<PackageReference Include=\"Ample.Scheduler\" Version=\"[0-9]*\.[0-9]*\.[0-9]*\" \/>/<PackageReference Include=\"Ample.Scheduler\" Version=\"$version\" \/>/" $project_file

sed -i "s/<PackageReference Include=\"Ample.WSInfra\" Version=\"[0-9]*\.[0-9]*\.[0-9]*\" \/>/<PackageReference Include=\"Ample.WSInfra\" Version=\"$version\" \/>/" $project_file

