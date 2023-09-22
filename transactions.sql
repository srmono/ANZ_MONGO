

mongo uri (atlas)

use blog 
db.users.insertOne({name: "venkat"})

db.posts.insertMany([
    {title: "Nice post", userId: ObjectId(9080808080)},
    {title: "Nice post 2" , userId: ObjectId(9080808080)}
])

db.users.deleteOne({_id: ObjectId(9080808080)})

const session =  db.getMongo().startSession()

session.startTransaction()

const usersCol = session.getDatabase("blog").users 
const postsCol = session.getDatabase("blog").posts

db.users.find().pretty()

usersCol.deleteOne({_id: ObjectId(9080808080)})
postsCol.deleteMany({userId: ObjectId(9080808080)})

db.posts.find().pretty()

session.commitTransaction()

-- session.abortTransaction()

--------------------------------------------------------------------------------------------------------------

-- https://www.mongodb.com/basics/acid-transactions

--------------------------------------------------------------------------------------------------------------

const session = db.getMongo().startSession();

session.startTransaction();

try {
  const collection = session.getDatabase("mydb").mycollection;

  // Example operations:
  collection.insertOne({ name: "John" });
  collection.updateOne({ name: "Alice" }, { $set: { age: 30 } });

  // Commit the transaction
  session.commitTransaction();
} catch (error) {
  // Handle errors and abort the transaction on failure
  session.abortTransaction();
  throw error;
} finally {
  // Clean up the session
  session.endSession();
}

