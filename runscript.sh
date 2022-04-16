echo "Starting MailHog for email debugging"
chmod +x /MailHog_linux_amd64
./MailHog_linux_amd64 &

echo "Building and deploying WebDSL project"
cd /webdsl-project
webdsl run &
until $(curl --output /dev/null --silent --head --fail "http://localhost:8080/`cat /app_name`"); do
    sleep 1
done

echo "Performing search reindex for application init data"
yes '' | webdsl reindex

echo "Building and deploying React project"
if [ -n "$(ls -A /root/react/package.json)" ]; then
  cd /root/react
  npm install
  npm start
fi

sleep 6h