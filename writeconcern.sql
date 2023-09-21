use contactData

db.persons.insertOne(
    {
        name: "venkat",
        age: 32,
        hobbied: ["sports", "yoga"]
    }
)

db.persons.insertOne(
    {
        name: "sai",
        age: 28,
        hobbied: ["learning", "yoga"]
    }
)

db.persons.insertMany(
    [
        {
            name: "Nathasha",
            age: 26,
            hobbied: ["Sprots", "tennis"]
        }
    ]
)

db.persons.insertMany(
    [
        {
            name: "ramesh",
            age: 36
        },
        {
            name: "snuti",
            age: 18
        }
    ]
)

db.persons.insert({name: "Sreenath", age: 42})

db.persons.insert(
    [
        {
            name: "kumar",
            age: 33
        },
        {
            name: "hamsika",
            age: 16
        }
    ]
)

-- ordered insert

db.hobbies.insertMany([
    {_id: "sports", name: "Sports"},
    {_id: "cooking", name: "Cooking"},
    {_id: "cars", name: "Cars"}
])

db.hobbies.insertMany([
    {_id: "yoga", name: "Yoga"},
    {_id: "cooking", name: "Cooking"},
    {_id: "hiking", name: "Hiking"}
])

db.hobbies.insertMany([
    {_id: "yoga", name: "Yoga"},
    {_id: "cooking", name: "Cooking"},
    {_id: "hiking", name: "Hiking"}
], {ordered: false})

-- Write concern

db.persons.find().pretty()

db.persons.insertOne({ name: "Cherry", age: 41}, {writeConcern: {w:0} })

db.persons.insertOne({ name: "Cherry", age: 41}, {writeConcern: {w:1, j: false} })
db.persons.insertOne({ name: "Cherry", age: 41}, {writeConcern: {w:1, j: true} })
db.persons.insertOne({ name: "Cherry", age: 41}, {writeConcern: {w:1, j: true, wtimeout:200} })
db.persons.insertOne({ name: "Cherry", age: 41}, {writeConcern: {w:1, j: true, wtimeout:1} })

-------------------------
-- Import data

mongoimport tv-shows.json -d movieData -c movies --jsonArray --drop

use movieData
db.movies.find().pretty()