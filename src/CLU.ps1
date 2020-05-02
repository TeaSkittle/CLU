#Requires -RunAsAdministrator
# ==================================================================================
# Author - Travis Dowd
# Date Started: 2-7-2020 (v0.1)
# Version 1.0 completed on: 2-26-2020
# Powershell version started on: 5-1-2020 (v1.6)
#
# Most recent veriosn is always at: https://github.com/TeaSkittle/CLU
# ==================================================================================

# Allow scripts to be ran
Set-ExecutionPolicy RemoteSigned

# Load global variables
. .\var.ps1

# Set color scheme
$host.UI.RawUI.BackgroundColor = "$bg"
$host.UI.RawUI.ForegroundColor = "$fg"
clear
