-- Data Schemas and Data Modelling
use shop

db.products.insertOne({name: "A Book", price: 12.99})

db.products.insertOne({title: "T Shirt", price: 12.99, seller: {name: "venkat", age: 32}})

db.products.deleteMany({})

db.products.insertOne({name: "A Book", price: 12.99})
db.products.insertOne({name: "T Shirt", price: 20.99})

db.products.insertOne({name: "Computer", price: 1000, details: {cpu: "intel i7"}})

db.products.deleteMany({})

-- companyData

use companyData

db.companies.insertOne(
    {
        name: "ANZ",
        isStartUp: true,
        employees: 500,
        funding: 12345678901234567000,
        details: {
            ceo: "xyz"
        },
        tags: [
            {title: "super"},
            {title: "perfect"}
        ],
        foundingData: new Date(),
        insertedAt: new Timestamp()
    }
)

------------------------------------

db.numbers.insertOne({a: 1})

> db.numbers.findOne()

db.stats()

db.companies.drop()

db.stats()
db.numbers.deleteMany({})

db.stats()

db.numbers.insertOne({a: NumberInt(1)})
db.numbers.insertOne({a: 1})
db.stats()

-- Note: When we use specific type methods the specific size will be applied 

-- find data type
typeof db.numbers.findOne().a

show dbs
use shop 
db.dropDatabase()
show collections or db.getCollectionNames()
db.collectionname.drop()
db.getCollectionNames().forEach(collection => db[collection].drop())

-- One to one relationship
-- Patient and Disease summary

use hospital 

db.patients.insertOne({name: "venkat", age: 32, diseaseSummary: "summary-venkat-1"})

db.diseaseSummaries.insertOne(
    {
        _id: "summary-venkat-1",
        diseases: ["cold"]
    }
)

-- create variable in mongo shell
var dsid = db.patients.findOne().diseaseSummary

dsid

db.diseaseSummaries.findOne({_id: dsid})

db.patients.deleteMany({})
db.diseaseSummaries.deleteMany({})

db.patients.insertOne({name: "venkat", age: 32, diseaseSummary: {diseases: ["cold"]}})

--------------------------------------------------------------------------------

-- Person and car [one to one ]
use carData 
db.persons.insertOne({
    name: "venkat",
    car: {
        model: "BMW",
        price: 48000
    }
})

db.persons.deleteMany({})

db.persons.insertOne({
    name: "venkat",
    age: 32,
    salary: 3000
})

db.cars.insertOne( {
        model: "BMW",
        price: 48000,
        owner: ObjectId("650187efdf21420cf4302584")
    })

-- one to many Threads and answers

user support 

db.questionThreads.insertOne(
    {
        creator: "Venkat",
        question: "How does it work?",
        answers: ["q1a1", "q1a2"]
    }
)

db.answers.insertMany([
    {
        _id: "q1a1",
        text: "it works like that"
    },
    {
        _id: "q1a2",
        text: "thanks"
    }
])

-- delete all
db.questionThreads.deleteMany({})

db.questionThreads.insertOne(
    {
        creator: "Venkat",
        question: "How does it work?",
        answers: [
            {
                text: "it works like that"
            },
            {
                text: "thanks"
            }
        ]
    }
)

-- one to many with city and citizens

use a_cityData

db.cities.insertOne({
    name: "India",
    coordinates: {
        lat: 21,
        lng: 55
    }
})

db.citizens.insertMany([
    {
        name: "venkat",
        cityId: ObjectId("650ab5d250f15e91dbf1cbf4")
    },
    {
        name: "Sai",
        cityId: ObjectId("650ab5d250f15e91dbf1cbf4")
    }
])

-- Many to Many relationship (customers and products)

use shop

db.products.insertOne({title: "A Book", price: 12.99})
db.customers.insertOne({name: "venkat", age: 32})
db.orders.insertOne(
    {
        productId: ObjectId("6268b9e7389f4185fef630ae"),
        customerId:  ObjectId("6268b9ef389f4185fef630af")
    }
)
db.orders.drop()
db.customers.updateOne(
    {},
    {
        $set : {
            orders: [
                {
                    productId: ObjectId("6268b9e7389f4185fef630ae"),
                    quantity: 2
                }
            ]
        }
    }
)
db.customers.updateOne(
    {},
    {
        $set : {
            orders: [
                {
                    title: "A Book",
                    price: 12.99,
                    quantity: 2
                }
            ]
        }
    }
)

---------------
-- Many to many -> Books and authors

use bookRegistry 

--Approach 1
db.books.insertOne(
    {
        name: "My Fav Book", 
        authors: [
            {
                name: "Venkat",
                age: 32
            },
            {
                name: "Sai",
                age: 28
            }
        ]
    }
)

-------------------
db.books.insertOne(
    {
        name: "My Fav Book", 
    }
)

db.authors.insertMany([
    {
        name: "Venkat",
        age: 32,
        address: {
            city: "Bangalore"
        }
    },
    {
        name: "Sai",
        age: 28,
        address: {
            city: "Chennai",
            street: "Thambuchetty Street"
        }
    }
])


db.books.updateOne(
    {},
    {
        $set : {
            authors: [
                ObjectId("650ab97b50f15e91dbf1cbfa"),
                ObjectId("650ab97b50f15e91dbf1cbfb")
            ]
        }
    }
)

--- $lookup query for join 
db.books.aggregate(
    [
        {
            $lookup : {
                from: "authors",
                localField: "authors", 
                foreignField: "_id",
                as: "creators"
            }
        }
    ]
).pretty()


