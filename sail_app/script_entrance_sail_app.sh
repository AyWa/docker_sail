#!/bin/bash -eu
rm -rf SAIL
GIT_SSH_COMMAND='ssh -i /root/.ssh/id_rsa' git clone git@github.com:Ciboulette/SAIL.git
cd SAIL/
npm install
cd app/
sed -i -e "s/localhost:4200/198.211.118.218:4200/g" src/app/notifications/notification.service.ts
npm install
npm run build
cd ..
sed -i -e "s/198.211.118.218:30001/mongo1:27017/g" config/database.js
sed -i -e "s/localhost:4200/198.211.118.218:4200/g" config/database.js
sed -i -e "s/198.211.118.218/neo4j_server/g" neo4j/user.js
sed -i -e "s/localhost:4200/198.211.118.218:4200/g" emails/email.js
pm2 start server.js
pm2 logs
exit 0
