-- Ref: GeoJson 
-- https://www.mongodb.com/docs/manual/reference/geojson/

-- coordinates: [77.713038, 12.899048]
-- first value : longitude
-- second value: latitude


use awesomeplaces

db.places.insertOne(
    {
        name: "my first location",
        location: {
            type: "Point",
            coordinates: [77.713038, 12.899048]
        }
    }
)

-- 12.90014, 77.71396
12.9226075,77.6881935
db.places.find(
    {
        location: {
            $near: {
                $geometry: {
                    type: "Point",
                    coordinates: [77.71396, 12.90014]
                }
            }
        }
    }
).pretty()

db.places.createIndex({location: "2dsphere"})
db.places.find(
    {
        location: {
            $near: {
                $geometry: {
                    type: "Point",
                    coordinates: [77.71396, 12.90014] 
                },
                $maxDistance: 300,
                $minDistance: 10
            }
        }
    }
).pretty()