# Check if the directory exists and create it if not
ssh administrator@192.168.1.9 "if [ ! -d 'C:/Programdata/Amplelogic' ]; then mkdir -p 'C:/Programdata/Amplelogic'; fi"

# Copy the file from Jenkins server to Windows server
scp /opt/Atwork_Project_Creation/sites_creation/sitecreations.ps1  administrator@192.168.1.9:"C:/Programdata/Amplelogic/"
