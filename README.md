#docker_sail
##Mongo_container
`cd mongodb_container`   
command:  
`docker build . -t mongodb_sail`   
`run -d -v /home/cibot/docker_config/mongodb_container/bdd/:/data/db -p 27017:27017 -p 28017:28017 -e MONGODB_USER="sailadmin" -e MONGODB_DATABASE="XXXXXX" -e MONGODB_PASS="XXXXXX" mongodb_sail`   
ou utiliser systemd   
cp le script pour daemon   
`sudo cp mongodb_container.service /etc/systemd/system/mongodb_container.service`   
le mettre a jour pour le systemd   
`systemctl daemon-reload`   
`systemctl start mongodb_container.service`   
`systemctl enable mongodb_container.service`   
##neo4j
`cd neo4j`   
command:  
`docker build . -t neo4j`   
`docker run --publish=7474:7474 --publish=7687:7687 --volume=/home/cibot/docker_config/neo4j/data:/data neo4j`   
you can access to  http://localhost:7474/ or http://198.211.118.218:7474/browser/   
##neo4j_doc_manager
`cd neo4j_doc_manager`   
command:  
``
