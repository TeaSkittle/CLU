#Requires -RunAsAdministrator
Set-ExecutionPolicy RemoteSigned

# Load global variables
. .\var.ps1

# Set network settings for DHCP

# Get user input
ipconfig /all
$interface = Read-Host "Interface"
if (!$interface) { $interface=$defint }

# netsh
# Set network adapter setting
netsh interface ip set address name="$interface" dhcp
netsh interface ipv4 set dns name="$interface" static $dnsone primary
netsh interface ipv4 add dns name="$interface" addr="$dnstwo" index=2

# Flush DNS
ipconfig /flushdns
 
