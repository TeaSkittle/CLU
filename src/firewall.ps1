# Turn off firewall for all profiles
netsh advfirewall set allprofiles    state off
netsh advfirewall set currentprofile state off
netsh advfirewall set domainprofile  state off
netsh advfirewall set privateprofile state off
netsh advfirewall set publicprofile  state off
