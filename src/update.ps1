# Force windows updates

# Open windows update panel
CONTROL UPDATE

# Stop services
NET STOP wuauserv
NET STOP W32TIME

# Refresh WSUS Client ID
REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /f

# Start/Stop services
SC CONFIG WUAUSERV  start=auto
SC CONFIG W32TIME   start=auto
SC CONFIG BITS      start=auto
SC CONFIG CRYPTSVC  start=auto
NET START wuauserv
NET START W32Time
NET START msiserver
NET START BITS
NET START CryptSvc

# Set Time Zone
TZUTIL /S $deftime
NET START W32TIME
W32TM /RESYNC /REDISCOVER

# Start winodws update in panel
USOCLIENT.EXE StartInteractiveScan
