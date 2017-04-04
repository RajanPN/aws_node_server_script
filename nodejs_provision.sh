#!/bin/bash

echo "############# -START- #################"

# Node.js v4.x (the older long-term support version, supported until April of 2017)
# Node.js v6.x (the more recent LTS version, which will be supported until April of 2018)
# Node.js v7.x (the current actively developed version).

SCRSUFFIX="_6.x" # Change as requried by project _4.x / _6.x / _7.x
NODENAME="Node.js v6.x"

print_status() {
    echo
    echo "===============================Step $1================================"
    echo "$2"
	echo "====================================================================="
    echo
}

bail() {
    echo 'Error executing command, exiting'
    exit 1
}

exec_cmd_nobail() {
    echo "+ $1"
    bash -c "$1"
}

exec_cmd() {
    exec_cmd_nobail "$1" || bail
}

#### 1 ####
print_status "1" "Updating the repository ..."

	exec_cmd "sudo apt-get update"

#### 2 ####
print_status "2" "Installing the NodeJS ${NODENAME} repo..."

	# Retrieve the installation script for the Node.js 6.x archives
	exec_cmd "cd ~ && curl -sL https://deb.nodesource.com/setup${SCRSUFFIX} -o nodesource_setup.sh"

	# The PPA will be added to your configuration and your local package cache will be updated automatically. 
	exec_cmd "sudo bash nodesource_setup.sh"

	# Install the Node.js package.
	exec_cmd "sudo apt-get install nodejs"

	# Install build-essentials in order for some npm packages to work (such as those that require compiling code from source)
	exec_cmd "sudo apt-get install build-essential"

	# Remove the retrieved installation script after install
	exec_cmd "sudo rm -rf nodesource_setup.sh"

#### 3 ####
print_status "3" "Installation of NGINX ..."

	exec_cmd "sudo apt-get install nginx"

	# Enable the most restrictive profile that will still allow the traffic you've configured
	exec_cmd "sudo ufw allow 'Nginx HTTP'"

	# check with the systemd init system to make sure the web service is running
	exec_cmd "sudo systemctl status nginx"


#### 4 ####
print_status "4" "Installation of Supervisor ..."

	exec_cmd "sudo apt-get install supervisor"

	
#### 5 ####
print_status "5" "Installation of Supervisor ..."

	exec_cmd "sudo apt-get install supervisor"

		
#### 6 ####
print_status "6" "Installation of GIT ..."

	exec_cmd "sudo apt-get install -y git"

echo
echo "############# -END- #################"