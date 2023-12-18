DESIGN_CLIENT=$(ssh administrator@192.168.1.78 "powershell "Get-WebSite -Name 'Platform3.0_Server_design'.PhysicalPath"")
echo $DESIGN_CLIENT
