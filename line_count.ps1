# This file is used for the remove update function
# equivalent to UNIX wc -l
$lines=(Get-Content C:\1\temp2 | Measure-Object -Line).Lines
# subtract 1 from lines
$lines--
# output file with correct encoding
type C:\1\temp2 -Tail $lines | Out-File C:\1\temp3 -encoding ASCII
