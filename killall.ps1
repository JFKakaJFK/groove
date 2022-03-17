# Kills the orphaned? tomcat instance and restarts webdsl
# somehow this is necessary to have the right port free... 

# get the listening servers for port 2113
$server = netstat -ano | Select-String -Pattern 'TCP.+0\.0\.0\.0:2113.+LISTENING'

# if there still is a server, kill it
if($server -match '(\d+)$') {
	echo "killing old server"
	taskkill /F /PID $Matches[1]
}

# get the listening servers for port 8080
$server = netstat -ano | Select-String -Pattern 'TCP.+0\.0\.0\.0:8080.+LISTENING'

# if there still is a server, kill it
if($server -match '(\d+)$') {
	echo "killing old server"
	taskkill /F /PID $Matches[1]
}