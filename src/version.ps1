#Requires -RunAsAdministrator
Set-ExecutionPolicy RemoteSigned

# View windows build version
systeminfo | findstr /B /C:"OS Version:"
