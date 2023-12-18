

APPOOL_NAME=$(ssh administrator@192.168.1.59 "powershell \"(Get-WebSite -Name 'Asset_Management_ServerApp').applicationPool\"")

# Replace backslashes with forward slashes in the application pool name using sed
APPOOL_NAME=$(echo "$APPOOL_NAME" | sed 's/\\/\//g')

echo $APPOOL_NAME
