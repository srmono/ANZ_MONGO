## Step 1: Set Up the MongoDB Instances

Before configuring sharding, make sure you have two MongoDB instances running on separate ports, as you mentioned in your initial setup.

Instance 1:

MongoDB port: 27017
Data directory: C:\data\db1
Log file: C:\data\log1\mongod.log
Instance 2:

MongoDB port: 27018
Data directory: C:\data\db2
Log file: C:\data\log2\mongod.log

## Step 2: Configure a Config Server

Sharding requires a config server to store metadata about shard data distribution. In this example, we'll use a single MongoDB instance as the config server. Create a configuration file for the config server (mongod_config.cfg):

systemLog:
  destination: file
  path: C:\data\config\log\mongod_config.log
  logAppend: true

storage:
  dbPath: C:\data\config\db

net:
  port: 27019
  bindIp: 127.0.0.1

configsvr: true

-- Start the config server:
mongod --config C:\path\to\mongod_config.cfg

## Step 3: Enable Sharding on Instances

Connect to each of your MongoDB instances and enable sharding on them. Open two separate command prompts:

Instance 1: mongo --port 27017

In the MongoDB shell, run:
sh.enableSharding("mydb")

Instance 2:
mongo --port 27018
sh.enableSharding("mydb")


## Step 4: Shard the Collection
Create a collection and shard it. In each of the MongoDB instances, create a database and a collection, then shard the collection:
Instance 1:
use mydb
db.createCollection("mycollection")
sh.shardCollection("mydb.mycollection", { _id: "hashed" })

Instance 2:
use mydb
sh.addShard("127.0.0.1:27017")


## Step 5: Insert and Query Data
You can now insert and query data into the sharded collection using either instance. MongoDB will distribute the data across the instances based on the shard key (in this example, "_id" hashed).



-----------

Shard Key Range Selection:

When choosing a shard key, consider the distribution of data values. If the shard key values are monotonically increasing, it may lead to uneven data distribution. Hashed shard keys can be used to distribute data uniformly.

// Enable sharding on the database
sh.enableSharding("mydb")

// Create a collection with a hashed shard key
db.createCollection("mycollection", { shardKey: { _id: "hashed" } })

// Insert data into the sharded collection
for (let i = 0; i < 100000; i++) {
    db.mycollection.insert({ _id: i, data: "example" })
}

// Check chunk distribution
sh.status()


Automatic Chunk Splitting:

MongoDB's balancer automatically splits and migrates chunks between shards to balance data distribution. Trust the balancer to perform these tasks.
Ensure that the balancer is running (sh.getBalancerState() should return true).



Monitoring Chunk Distribution:
// Check chunk distribution programmatically
db.runCommand({ shardStatus: "mydb.mycollection" })


Manual Chunk Splitting:
// Manually split a chunk at a specific value
sh.splitAt("mydb.mycollection", { shardKeyField: "someValue" })

Manual Chunk Migration:
// Manually move a chunk from source shard to target shard
db.adminCommand({
  moveChunk: "mydb.mycollection",
  find: { shardKeyField: "someValue" },
  to: "targetShard"
})


######################################################################################################################################

----------- Misc Info

// Connect to a mongos instance
mongo --host mongos_host --port mongos_port

// Enable sharding for a database
sh.enableSharding("your_database")

// Create a sharded collection with a shard key
use your_database
db.createCollection("your_collection")
sh.shardCollection("your_database.your_collection", { shardKeyField: 1 })


-------------------------------------------------------

In MongoDB, we can configure the maximum number of documents per shard using a feature called "Chunking." Chunks are essentially ranges of shard key values, and MongoDB will automatically split and distribute chunks across shards as your data grows. However, there is no direct configuration option to limit the number of documents to a specific count like 25,000 per shard.

Here's how you can indirectly control the number of documents per shard:

-- Select an Appropriate Shard Key: Choose a shard key that distributes data relatively evenly across shards. A good shard key will help ensure that no single shard becomes overwhelmed with more data than others. If you have a natural field in your data that can be used as a shard key and that has good distribution characteristics, use it. If not, consider using a hashed shard key to distribute data uniformly.

-- Monitor and Rebalance: MongoDB's internal balancer continuously monitors the distribution of chunks and will automatically move chunks between shards to balance the data distribution. You can also manually initiate balancing with the sh.startBalancer() and sh.stopBalancer() methods. Monitoring and rebalancing will help maintain even data distribution among shards.

sh.startBalancer()
sh.stopBalancer()
sh.getBalancerState()

// Check the balancer state
var isBalancerRunning = sh.getBalancerState()
print("Balancer is running: " + isBalancerRunning);

// Stop the balancer if it's running
if (isBalancerRunning) {
  sh.stopBalancer();
  print("Balancer stopped.");
}



-- Plan Shard Key and Chunks: Depending on your use case, you can plan shard key values and the size of chunks to indirectly control the number of documents per shard. If your chunks are too large and you want to limit the number of documents per shard, consider using a finer-grained shard key or adjusting the chunk size using the maxChunkSize option.

-- Pre-Split Chunks: You can pre-split chunks to ensure an even distribution of data across shards initially. This can be useful if you want to ensure that each shard has roughly the same number of documents at the start. To pre-split chunks, you can use the sh.splitAt() command.

// Split a chunk in a specific range
sh.splitAt("mydb.mycollection", { _id: <value_to_split_at> })
 