#!/bin/bash -eu
echo "yolo le docker";
export NEO4J_AUTH=neo4j:sail
echo $NEO4J_AUTH
env | grep NEO4J
mongo-connector -m mongodb://sailroot:Sail2017@172.18.0.3:27017/admin -t http://172.17.0.3:7474/db/data -d neo4j_doc_manager
exit 0
