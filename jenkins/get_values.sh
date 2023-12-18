ServerIP=192.168.1.87
SITENAME=AtWork3.0_Server

DESIGN_CLIENT=$(ssh administrator@$ServerIP "powershell \"(Get-WebSite -Name '$SITENAME').PhysicalPath\"")
echo $DESIGN_CLIENT
subject="hi team build is failed"
echo $subject
