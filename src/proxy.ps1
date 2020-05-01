# Set correct proxy settings

# Registry
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyEnable   /t REG_DWORD /d 1 /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyServer   /t REG_SZ    /d $proxyserv /f
REG ADD "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v ProxyOverride /t REG_SZ    /d $proxylist /f 

# netsh
netsh winhttp set proxy proxy-server="$proxyserver" bypass-list="$proxtlist"
netsh winhttp import proxy source =ie
