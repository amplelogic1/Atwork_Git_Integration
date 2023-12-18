#!/bin/bash

# Function to generate a random port
function generate_random_port {
    echo $(( ( RANDOM % (65535-1024) ) + 1024 ))
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        --projectcode)  # Change from --path to --projectcode
            project_code="$2"
            shift
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Check if the required argument is provided
if [ -z "$project_code" ]; then
    echo "Usage: ./sitecreation.sh --projectcode <project_code>"
    exit 1
fi

# Create project directories dynamically
base_path="/opt/Platform-3.0-Projects/$project_code"
directories=("Design_Client" "Run_Client" "Design_Server" "Run_Server")

for dir in "${directories[@]}"; do
    dir_path="$base_path/$dir"
    if [ ! -d "$dir_path" ]; then
        mkdir -p "$dir_path"
        echo "Created directory: $dir_path"
    else
        echo "Directory already exists: $dir_path"
    fi
done

# Generate random ports
port_design_client=$(generate_random_port)
port_run_client=$(generate_random_port)
port_design_server=$(generate_random_port)

# Display the generated ports
echo "Random Port for Design_Client: $port_design_client"
echo "Random Port for Run_Client: $port_run_client"
echo "Random Port for Design_Server: $port_design_server"

# Now, you can use these ports in your subsequent scripts
exec /root/linux_sites_Creation/clientcreations.sh --path "$base_path/Design_Client/" --port "$port_design_client" --name "$project_code"
exec /root/linux_sites_Creation/clientcreations.sh --path "$base_path/Run_Client/" --port "$port_run_client" --name "$project_code"
exec /root/linux_sites_Creation/sitescreations.sh --path "$base_path/Design_Server" --port "$port_design_server" --name "$project_code"
