#Requires -RunAsAdministrator
# NOTE: Put this ^ at the top of .ps1 files
# Holds global variables for other scripts
# run with the "dot" operator: . .\var.ps1

# Title bar
$ver=1.6
$title="CLU - $ver"
$host.ui.RawUI.WindowTitle = “$title”

# Network
$defint="Ethernet"
$defsub=255.255.255.0
$defgate=192.168.0.1

# DNS
$dnsone=8.8.8.8
$dnstwo=8.8.4.4

# Proxy
$proxyserver="blank"
$proxylist="192.168.*;<local>"

# Time zone
$deftime="Mountain Standard Time"

# Files
$dest=C:\CLU\

# Color Scheme
$bg="black"
$fg="white"
# TO change run these:
# $host.UI.RawUI.BackgroundColor = "$bg"
# $host.UI.RawUI.ForegroundColor = "$fg"
# clear
