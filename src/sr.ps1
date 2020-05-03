#Requires -RunAsAdministrator
Set-ExecutionPolicy RemoteSigned

# search and replace: .\sr.ps1 file_name foo bar 
# equivalent to UNIX: sed 's/foo/bar/g' file_name
$sed=(Get-Content -path $args[0]) -replace $args[1],$args[2]
$sed
