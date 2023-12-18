
client=$(ssh administrator@192.168.1.248 "powershell "Get-WebSite -Name 'zebro_Design_Client'.PhysicalPath"")
echo $client


