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
si la bdd est deja configurer:   
`docker run --name mongo1 --restart=always -v /home/cibot/docker_config/swarm_mongodb_container/main/mongo-files/data:/data/db -v /home/cibot/docker_config/swarm_mongodb_container/main:/opt/keyfile --net sail-mongo-cluster -p 30001:27017 -d mongo --keyFile /opt/keyfile/mongodb-keyfile --replSet sail-mongo-set`   
`docker run --name mongo2 --restart=always -v /home/cibot/docker_config/swarm_mongodb_container/second/mongo-files/data:/data/db -v /home/cibot/docker_config/swarm_mongodb_container/second:/opt/keyfile --net sail-mongo-cluster -p 30002:27017 -d mongo --keyFile /opt/keyfile/mongodb-keyfile --replSet sail-mongo-set`   
##neo4j
`cd neo4j`   
command:  
`docker build . -t neo4j`   
`docker run -d --name neo4j_server --restart=always --publish=7474:7474 --publish=7687:7687 --net neo4j-cluster --volume=/home/cibot/docker_config/neo4j/data:/data neo4j`   
you can access to  http://localhost:7474/ or http://198.211.118.218:7474/browser/   
##neo4j_doc_manager
`cd neo4j_doc_manager`   
il faut peut etre changer le script sh en mettant les bonnes addresses et bon mdp des bdd/neo4j   
`docker build . -t neo4j_doc_manager`     
`docker create --name neo4j_docmanag --restart=always --net sail-mongo-cluster neo4j_doc_manager`   
`docker network connect neo4j-cluster neo4j_docmanag`   
`docker start neo4j_docmanag`   
##SAIL_APP
il faut mettre la clef ssh dans /docker_config/sail_app/.ssh/id_rsa (la demander à marc ou se faire une clef rsa github).   
la premiere install il faut faire la demande de validation de clef pour obtenir le file know_hosts:   
`GIT_SSH_COMMAND='ssh -i /root/.ssh/id_rsa' git clone git@github.com:Ciboulette/SAIL.git`   
normal install :
 `docker build . -t sail_app`   
`docker run -d --name sail_app --restart=always --publish=4200:4200 --volume=/home/cibot/docker_config/sail_app/.ssh:/root/.ssh/ --net sail-mongo-cluster sail_app`   
`docker network connect neo4j-cluster sail_app`   
