# This file is used for the remove update function
$lines=(Get-Content C:\CLU\temp2 | Measure-Object -Line).Lines
$lines--
type C:\CLU\temp2 -Tail $lines | Out-File C:\CLU\temp3 -encoding ASCII
