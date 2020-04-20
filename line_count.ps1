$lines=(Get-Content C:\1\temp2 | Measure-Object -Line).Lines
$lines--
type C:\1\temp2 -Tail $lines | Out-File C:\1\temp3 -encoding ASCII