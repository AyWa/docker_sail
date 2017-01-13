FROM node:latest

COPY script_entrance_sail_app.sh /script_entrance_sail_app.sh
RUN mkdir -p /root/.ssh
RUN npm install angular-cli -g
RUN npm install pm2 -g

#ENTRYPOINT ["/script_entrance_sail_app.sh"]
