ServerIP=192.168.1.9
PROJECT_CODE=ELN_CLIENT

DESIGN_CLIENT=$(ssh administrator@192.168.1.9 "powershell "Get-WebSite -Name 'ETL_CLIENT'.PhysicalPath"")
echo $DESIGN_CLIENT


