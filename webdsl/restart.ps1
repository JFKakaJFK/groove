# Kills the orphaned? tomcat instance and restarts webdsl
# somehow this is necessary to have the right port free... 
param([switch]$clean=$false)

# generate css files
echo "building theme.css"
npx tailwindcss -c tailwind.config.js -o stylesheets/theme.css -m

# get the listening servers for port 8080
$server = netstat -ano | Select-String -Pattern 'TCP.+0\.0\.0\.0:8080.+LISTENING'

# if there still is a server, kill it
if($server -match '(\d+)$') {
	echo "killing old server"
	taskkill /F /PID $Matches[1]
}

# optionally clean
if($clean) {
	# delete all caches
	# Remove-Item -Force -Recurse .\.webdsl*
	# Remove-Item -Force -Recurse .\.servletapp
	# run webdsl clean for whatever is left
	webdsl clean
}

# start webdsl
webdsl run