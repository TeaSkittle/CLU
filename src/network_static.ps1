#Requires -RunAsAdministrator
Set-ExecutionPolicy RemoteSigned

# Load global variables
. .\var.ps1

# Set network settings for static

# Get user input
ipconfig /all
$interface = Read-Host "Interface"
$ip = Read-Host "IP"
$sub = Read-Host "Subnet Mask"
$gate = Read-Host "Default Gateway"
# Defaults if empty input
if (!$interface) { $interface=$defint }
if (!$sub) { $sub=$defgate }
if (!$gate) {$gate=$defsub }

# netsh
# Set network adapter setting
netsh interface ipv4 set address name="$interface" static $ip $sub $gate
netsh interface ipv4 set dns name="$interface" static $dnsone primary
netsh interface ipv4 add dns name="$interface" addr="$dnstwo" index=2

# Flush DNS
ipconfig /flushdns
