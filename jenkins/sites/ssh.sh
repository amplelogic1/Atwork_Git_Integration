#!/bin/bash

# Define the SSH server and username
SSH_USER="administrator"
SSH_SERVER="192.168.1.$1"

# Attempt to SSH into the server with a timeout
if ssh -q -o ConnectTimeout=10 -o PasswordAuthentication=no "$SSH_USER@$SSH_SERVER" exit; then
    # SSH connection is successful, execute your shell script here
    echo "SSH connection established."
    # Add your shell script execution command here
    # For example: ./your_script.sh
else
    # SSH connection failed or password authentication was requested
    echo "SSH connection failed or password authentication requested."
    # Handle the failure as needed
    # For example, you can exit the script or perform some other action
fi
