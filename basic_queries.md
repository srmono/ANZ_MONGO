-- To Start Mongo Server
mongod 
    --dbpath "C:\Program Files\MongoDB\Server\4.4\data" 
    --logpath "C:\Program Files\MongoDB\Server\4.4\log\mongod.log" 
    --port 27071 


mongod 
    --dbpath "C:\Program Files\MongoDB\Server\4.4\data" 
    --logpath "C:\Program Files\MongoDB\Server\4.4\log\mongod.log" 
    --port 27072

mongo 
    --ssl 
    --host localhost 
    --port 27017 
    --username your_username 
    --password your_password 
    --authenticationDatabase admin
    

-- To connect Mongo shell
mongo 
mongo --port 27071 

-- Show databases
show dbs

-- Mongo Shell
https://www.mongodb.com/try/download/shell


-- use db 
use shop  // if database doesn't exits it will created new db

-- insert collections

db.products.insertOne({name: "A Book", price: 1999.0})






-- Read/Query
db.products.find()
db.products.find().pretty()


-- insert one more doc

db.products.insertOne({name: "T Shirt", price: 999.0, description: "Nice T Shirt"})

** cls command to clear the console


-- insert one more doc

db.products.insertOne(
    {
        name: "computer", 
        price: 4999.0, 
        description: "High quality computer", 
        details: {cpu: "intel", memory: "32gb"}
    })

