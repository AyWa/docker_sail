#!/bin/bash -eu
GIT_SSH_COMMAND='ssh -i /root/.ssh/id_rsa' git clone git@github.com:Ciboulette/SAIL.git
cd SAIL/
npm install
cd app/
npm install
npm run build
cd ..
pm2 start server.js
exit 0
