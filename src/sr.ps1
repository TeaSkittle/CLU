# search and replace: sr.ps1 foo bar file_name 
# equivalent to UNIX: sed 's/foo/bar/g' file_name
$sed=(Get-Content -path $args[2]) -replace "$args[0]","$args[1]"
$sed
