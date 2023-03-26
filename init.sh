export $(grep -v '^#' .env | xargs)

rm -rf static/config/environment.json
rm -rf .svelte-kit/output/client/config/environment.json
cp static/config/environment.template.json static/config/environment.json

sed -i "s?{NITROX_SERVICE}?$NITROX_SERVICE?g" static/config/environment.json
sed -i "s?{NITROX_HOST}?$NITROX_HOST?g" static/config/environment.json
sed -i "s?{NITROX_PORT}?$NITROX_PORT?g" static/config/environment.json
sed -i "s?{NITROX_ENVIRONMENT}?$NITROX_ENVIRONMENT?g" static/config/environment.json
sed -i "s?{NITROX_PROXY}?$NITROX_PROXY?g" static/config/environment.json

if [ -d ".svelte-kit/output/client/config" ]; then
  cp static/config/environment.json .svelte-kit/output/client/config/environment.json
fi

if [ $NITROX_ENVIRONMENT = 'development' ]; then
  npx vite dev --port $NITROX_PORT --host $NITROX_HOST --mode development
else
  echo $VITE_NITROX_PROXY
  npx vite preview --port $NITROX_PORT --host $NITROX_HOST --mode production
fi
