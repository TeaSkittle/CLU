#Requires -RunAsAdministrator
Set-ExecutionPolicy RemoteSigned

# count number of lines: lc.ps1 file_name
# equivalent to UNIX: wc -l file_name
$lines=(Get-Content $args[0] | Measure-Object -Line).Lines
$lines

# NOTE: this does not count empty/blank lines
