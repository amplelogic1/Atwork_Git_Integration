APPOOL_NAME=$(ssh administrator@192.168.1.78 "powershell \"(Get-WebSite -Name 'LMS_ATWORK_SERVER_Design').applicationPool\"")

# Replace backslashes with forward slashes in the application pool name using sed
APPOOL_NAME=$(echo "$APPOOL_NAME" | sed 's/\\/\//g')

echo $APPOOL_NAME

