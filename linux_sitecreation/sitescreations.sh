#!/bin/bash

# Parse command line arguments
while [[ $# -gt 0 ]]
do
    key="$1"

    case $key in
        --path)
            directory="$2"
            shift
            shift
            ;;
        --port)
            port="$2"
            shift
            shift
            ;;
        --name)
            sitename="$2"
            shift
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Check if all required arguments are provided
if [ -z "$directory" ] || [ -z "$port" ] || [ -z "$sitename" ]; then
    echo "Usage: ./sitecreation --path <directory> --port <port> --name <sitename>"
    exit 1
fi

# Create systemd service file
echo "[unit]" > /etc/systemd/system/$sitename.service
echo "Description=$sitename.service .NET Core 3.1 Web Application" >> /etc/systemd/system/$sitename.service
echo "After=network.target"  >> /etc/systemd/system/$sitename.service

echo "[Service]"  >> /etc/systemd/system/$sitename.service
echo "WorkingDirectory=$directory/"  >> /etc/systemd/system/$sitename.service
echo "ExecStart=$directory/start.sh"  >> /etc/systemd/system/$sitename.service
echo "Restart=always"  >> /etc/systemd/system/$sitename.service
echo "RestartSec=10"  >> /etc/systemd/system/$sitename.service
echo "User=root"  >> /etc/systemd/system/$sitename.service
echo "Environment=ASPNETCORE_ENVIRONMENT=Production" >> /etc/systemd/system/$sitename.service

echo "[Install]"  >> /etc/systemd/system/$sitename.service
echo "WantedBy=multi-user.target"  >> /etc/systemd/system/$sitename.service

# Create start.sh script
echo "#!/bin/bash" > $directory/start.sh
echo "cd $directory" >> $directory/start.sh
echo "exec /usr/bin/dotnet $directory/Ample.Web.dll --urls http://0.0.0.0:$port" >> $directory/start.sh

# Enable and start the systemd service
sudo systemctl enable $sitename.service
sudo systemctl start $sitename.service
