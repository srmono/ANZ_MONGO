-- replica setup

mkdir cfg0 cfg1 cfg2

mkdir a0 a1 a2 b0 b1 b2 c0 c1 c2 d0 d1 2

-- Start config servers
mongod --configsvr --dbpath cfg0 --port 26050 --fork --logpath log.cfg0 --replSet cfg
-- similar way above, start other config servers

-- Login to first config server and initiate replicaset 
mongo --port 26050
rs.initiate()
rs.add("localhost:26051")
rs.add("localhost:26052")

rs.status()

-- Start Sharding servers
mongod --shardsvr --replSet a --dbpath a0 --port 26000 --fork --logpath log.a0 
mongod --shardsvr --replSet a --dbpath a1 --port 26001 --fork --logpath log.a1
mongod --shardsvr --replSet a --dbpath a2 --port 26002 --fork --logpath log.a2

similar way start for b, c and d
in linux ps -ef | grep mongod|grep a0

-- Enable replicaset on each shard instance
A group 
mongo --port 26000
rs.initiate()
rs.add("localhost:26001")
rs.add("localhost:26002")

rs.status()

-- do the same for all other groups

--  

-- Now start the mongo sharding environment with initially created config servers, which will be the interaction for the clients
mongos --configdb "cfg/localhost:26050,localhost:26051, localhost:26052" --fork --logpath log.mongos1 --port 26061 

-- we can create multiple sharding environments with same configuration running on different ports
mongos --configdb "cfg/localhost:26050,localhost:26051, localhost:26052" --fork --logpath log.mongos2 --port 26062

mongo --port 26061
sh.addShard("a/localhost:26000")
sh.addShard("b/localhost:26100")
sh.addShard("c/localhost:26200")
sh.addShard("d/localhost:26300")
sh.status()

show dbs

sh.enableSharding("mydb")

sh.status()
sh.shardCollection("mydb. product", {_id:1})
sh.status()

db.product.insert({title:"A Book, price: 91})


sh.status()

db.getLastErrorObj()

use config

db.shards.find()










