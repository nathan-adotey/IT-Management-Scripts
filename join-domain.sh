#!/bin/bash
#
# Synopsis:
#   [-] Sample script for joining a Red Hat Enterprise Linux or Fedora workstation/server to an Active Directory domain
#   [-] Required packages must be managable with the rpm, yum, or dnf package managers
#   [-] Re-configures the system hostname
#
# Developer(s) w/Role: Sample Developer, System Engineer II
#
# Declare/initialize arrays
REALMD_RPM_PACKAGES=("realmd" "sssd" "oddjob" "oddjob-mkhomedir" "adcli" "samba-common-tools" "krb5-workstation" "authselect-compat")
MISSING_PACKAGES=()
#
# Enforce root privilage execution
clear
if [[ $EUID -ne 0 ]]; then
    echo -e "This script must be executed with root privilages...Exiting..."
    sleep 5
    exit 99
fi
# Verify required realmd packages
echo -e "Verifying realmd packages..."
for package in "${REALMD_RPM_PACKAGES[@]}"; do
    if ! rpm -qa ${package} > /dev/null; then # Place a package in an array if it cannot be queried by the rpm package manager
	MISSING_PACKAGES+="${package}"
    fi
done
if [[ -z "${MISSING_PACKAGES[@]}" ]]; then
    echo -e "Package validation successful"
    sleep 2
else
    echo -e "The following packages must be installed before initiating a domain join:"
    for missing_package in "${MISSING_PACKAGES[@]}"; do
	echo "${missing_package}"
    done
    exit 99 # Terminate the script if there are missing packages
fi
# Attempt to join an Active Directory domain & configure a new hostname
# Prompt the user to enter a new hostname; it will reset if the user fails to provide a hostname
while true; do
    clear
    read -p "Enter a new system hostname: " HOSTNAME # Cache the user's input as the system's new hostname
    if [[ "$HOSTNAME" != "" ]]; then
        break
    fi
done
while true; do
    clear
    read -p "Enter the domain you would wish to join this workstation/server to: " DOMAIN # Cache the user's input as the discoverable domain
    if [[ "$DOMAIN" != "" ]]; then
        break
    fi
done
clear
hostnamectl hostname $HOSTNAME # Change the system's hostname
echo -e "Attempting to join $DOMAIN..."
sleep 2
if sudo realm discover "$DOMAIN" 2> /dev/null ; then # Prompt the user to authenicate as a domain user if such domain is discoverable (defaults to Administrator)
    read -p "Enter a domain user that can authenicate on $DOMAIN (An empty response will default to the Administrator user): " USER #
    if [ -z "$USER" ]; then
        USER="Administrator"  
    fi
    if realm join $DOMAIN -U $USER 2> /dev/null; then # Join the domain and present a success prompt
        echo -e "Domain join successful. Welcome to $DOMAIN"
	sleep 2
	exit
    fi
else
    # Force close the script if the remote domain is unavailable
    echo -e "Could not discover $DOMAIN. Verify network/firewall configurations and try again."
    sleep 2
    exit 99
fi
