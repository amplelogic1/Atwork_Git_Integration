PORT_NUMBER=$(ssh administrator@192.168.1.248 "powershell \"(Get-WebSite -Name 'AL10533_Design_Client').bindings.Collection[0].bindingInformation.Split(':')[1]\"")
echo $PORT_NUMBER
