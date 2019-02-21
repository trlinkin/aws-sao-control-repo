param($dispname, $proto, $port)
New-NetFirewallRule -DisplayName "$dispname" -Direction Inbound -Action Allow -Protocol $proto -LocalPort $port
