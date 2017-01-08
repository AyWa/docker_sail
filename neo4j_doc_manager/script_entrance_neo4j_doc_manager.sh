#!/bin/bash -eu
echo "yolo le docker";
export NEO4J_AUTH=neo4j:sail
echo $NEO4J_AUTH
env | grep NEO4J
mongo-connector -m mongodb://sailroot:Sail2017@mongo2:27017/admin -t http://neo4j_server:7474/db/data -d neo4j_doc_manager
exit 0
