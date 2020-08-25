
/1 web: App --env=production --workdir="./"
/2 web: App --env=production --workdir=./ --config:servers.default.port=$PORT --config:postgresql.url=$DATABASE_URL

web: Run serve --env production --hostname 0.0.0.0 --port $PORT
