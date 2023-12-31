use flights 

db.flightData.insertOne({
    "departureAirport": "MUC",
    "arrivalAirport": "SFO",
    "aircraft": "Airbus A380",
    "distance": 12000,
    "intercontinental": true
  });

db.flightData.find()
db.flightData.find().pretty();

---

db.flightData.insertOne({
    "departureAirport": "TXL",
    "arrivalAirport": "LHR",
  });

db.flightData.insertOne({
    "departureAirport": "TXL",
    "arrivalAirport": "LHR",
    _id: "txl-lhr-1"
  });

--* try again with same id
db.flightData.insertOne({
    "departureAirport": "TXL",
    "arrivalAirport": "LHR",
    _id: "txl-lhr-1"
  });

-----------------------------------------------
db.flightData.deleteOne({departureAirport: "TXL"})

db.flightData.updateOne({distance: 12000} , {$set: {marker: "delete"} })

db.flightData.updateMany({}, {$set: {marker: "toDelete"} })

db.flightData.deleteMany({marker: "toDelete"})

--------------------------------------------------------
## Insert many 

db.flightData.insertMany([
  {
    "departureAirport": "MUC",
    "arrivalAirport": "SFO",
    "aircraft": "Airbus A380",
    "distance": 12000,
    "intercontinental": true
  },
  {
    "departureAirport": "LHR",
    "arrivalAirport": "TXL",
    "aircraft": "Airbus A320",
    "distance": 950,
    "intercontinental": false
  }
]
)

db.flightData.find({name: "venkat"}); // no data 

db.flightData.find({intercontinental: true}).pretty()

db.flightData.find({distance: 12000}).pretty()

db.flightData.find({distance: {$gt: 900} }).pretty()

db.flightData.findOne({distance: {$gt: 900} })


db.flightData.updateOne( { "_id" : ObjectId("65015f87414d912172999361")}, {$set: {delayed: true}})

db.flightData.update( { "_id" : ObjectId("65015f87414d912172999361")}, {$set: {delayed: true}})

db.flightData.update( { "_id" : ObjectId("65015f87414d912172999361")}, {$set: {delayed: false}})

//error
db.flightData.updateOne( { "_id" : ObjectId("65015f87414d912172999361")}, {delayed: false})

db.flightData.updateMany( { "_id" : ObjectId("65015f87414d912172999361")}, {delayed: false})

-- this will replace entre document with new document
db.flightData.update( { "_id" : ObjectId("650a8c3350f15e91dbf1cbdc")} , {delayed: false})

db.flightData.replaceOne( 
  { "_id" : ObjectId("650a8c3350f15e91dbf1cbdc")},   
  {
     "departureAirport": "MUC",
     "arrivalAirport": "SFO",
     "aircraft": "Airbus A380",
     "distance": 12000,
     "intercontinental": true
})

--Insert passengers 

db.passengers.insertMany([
  {
    "name": "Venkat bvs",
    "age": 29
  },
  {
    "name": "Manu Lorenz",
    "age": 30
  },
  {
    "name": "Chris Hayton",
    "age": 35
  },
  {
    "name": "Sandeep Kumar",
    "age": 28
  },
  {
    "name": "Maria Jones",
    "age": 30
  },
  {
    "name": "Alexandra Maier",
    "age": 27
  },
  {
    "name": "Dr. Phil Evans",
    "age": 47
  },
  {
    "name": "Sandra Brugge",
    "age": 33
  },
  {
    "name": "Elisabeth Mayr",
    "age": 29
  },
  {
    "name": "Frank Cube",
    "age": 41
  },
  {
    "name": "Karandeep Alun",
    "age": 48
  },
  {
    "name": "Michaela Drayer",
    "age": 39
  },
  {
    "name": "Bernd Hoftstadt",
    "age": 22
  },
  {
    "name": "Scott Tolib",
    "age": 44
  },
  {
    "name": "Freddy Melver",
    "age": 41
  },
  {
    "name": "Alexis Bohed",
    "age": 35
  },
  {
    "name": "Melanie Palace",
    "age": 27
  },
  {
    "name": "Armin Glutch",
    "age": 35
  },
  {
    "name": "Klaus Arber",
    "age": 53
  },
  {
    "name": "Albert Twostone",
    "age": 68
  },
  {
    "name": "Gordon Black",
    "age": 38
  }
]
)

db.passengers.find(); -- -> cursor it 

db.passengers.find().toArray()

db.passengers.find().forEach( (passengerData) => {
    printjson(passengerData)
} )


-- projection
1 means include
0 means exclude

db.passengers.find({}, {name: 1}).pretty()

db.passengers.find({}, {_id: 0, name: 1}).pretty()
db.passengers.find({_id: 0, name: 1}).pretty()

-- Add Embedded document
db.flightData.find().pretty()

-- {} empty object targests all documents in the collection
db.flightData.updateMany(
    {}, 
    {
        $set: {
            status: {
                description: "on-time",
                lastUpdated: "1 hours ago"
            }
        }
    }
)

db.flightData.updateMany(
    {}, 
    {
        $set: {
            status: {
                description: "on-time",
                lastUpdated: "1 hours ago",
                details: {
                    responsible: "venkat"
                }
            }
        }
    }
)


-- Update array data in passengers collection

db.passengers.updateOne(
  {name: "Albert Twostone"}, 
  {$set: {hobbies: ["sports", "reading", "cooking"]} } 
)

db.passengers.find({name: "Albert Twostone"}).pretty()
db.passengers.findOne({name: "Albert Twostone"}).hobbies

db.passengers.find({hobbies: "sports"}).pretty()

-- query objects 
db.flightData.find({"status.description":"on-time"}).pretty()
db.flightData.find({"status.details.responsible":"venkat"}).pretty()

