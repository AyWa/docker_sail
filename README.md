#docker_sail
##helper
Docker: remove all Exited containers
`sudo docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs sudo docker rm`   
Delete all containers   
`docker rm $(docker ps -a -q)`   
Delete all images   
`docker rmi $(docker images -q)`   
##Warning:
A la premiere install:   
Ne pas lancer neo4j_document_manager sans set un mdp au neo4j (en allant sur l'interface web)  
CREER LES NETWORK CLUSTER:   
`docker network create --driver=bridge --subnet=172.28.0.0/16 --gateway=172.28.0.1 sail-mongo-cluster`    
`docker network create --driver=bridge --subnet=172.27.0.0/16 --gateway=172.27.0.1  neo4j-cluster`
##Mongo_SWARM_duplicate (for neo4j manager etc)
https://github.com/AyWa/docker_sail/blob/master/swarm_mongodb_container/install_swarm   
il faut utiliser la deuxieme version pour être securiser:   
##Mongo_container (useless )
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
`docker run --publish=7474:7474 --publish=7687:7687 --net neo4j-cluster --volume=/home/cibot/docker_config/neo4j/data:/data neo4j`   
you can access to  http://localhost:7474/ or http://198.211.118.218:7474/browser/   
##neo4j_doc_manager
`cd neo4j_doc_manager`   
il faut peut etre changer le script sh en mettant les bonnes addresses et bon mdp des bdd/neo4j   
command:  (il faudra rajouter le network docker mongo et neo4j) 
`docker build . -t neo4j_doc_manager`   
`docker run neo4j_doc_manager`    
`docker run --net sail-mongo-cluster --net neo4j-cluster neo4j_doc_manager`
