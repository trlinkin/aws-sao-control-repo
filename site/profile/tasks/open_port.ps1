
param($dispname)
param($proto)
param($port)
New-NetFirewallRule -DisplayName "$dispname" -Direction Inbound -Action Allow -Protocol $proto -LocalPort $port
