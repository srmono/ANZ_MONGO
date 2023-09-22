use performance

db.createCollection("capped", { capped: true, size: 10000, max: 3} )

db.capped.insertOne({name: "venkat"})
db.capped.insertOne({name: "snuti"})
db.capped.insertOne({name: "hamsika"})

db.capped.find().pretty()

db.capped.find().sort({$natural: -1}).pretty()

db.capped.insertOne({name: "brijesh"})

