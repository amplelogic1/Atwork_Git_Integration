Server_IP=192.168.1.9
PROJECT_CODE=truncat

DESIGN_CLIENT_PATH=$(ssh administrator@$Server_IP "powershell \"(Get-WebSite -Name '${PROJECT_CODE}_Design_Client').PhysicalPath\"")
DESIGN_CLIENT_SCP_PATH=$(ssh administrator@$Server_IP "powershell \"(Get-WebSite -Name '${PROJECT_CODE}_Design_Client').PhysicalPath.Replace('\\', '/')\"")
RUN_CLIENT_PATH=$(ssh administrator@$Server_IP "powershell \"(Get-WebSite -Name '${PROJECT_CODE}_Run_Client').PhysicalPath\"")
RUN_CLIENT_SCP_PATH=$(ssh administrator@$Server_IP "powershell \"(Get-WebSite -Name '${PROJECT_CODE}_Run_Client').PhysicalPath.Replace('\\', '/')\"")
DESIGN_SERVER_PORT_NUMBER=$(ssh administrator@$Server_IP "powershell \"(Get-WebSite -Name '${PROJECT_CODE}_Design_Server').bindings.Collection[0].bindingInformation.Split(':')[1]\"")

echo $DESIGN_CLIENT_PATH
echo $DESIGN_CLIENT_SCP_PATH
echo $RUN_CLIENT_PATH
echo $RUN_CLIENT_SCP_PATH
echo $DESIGN_SERVER_PORT_NUMBER
