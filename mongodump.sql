mongodump --db database_name --collection collection_name --out /path/to/backup/directory


mongorestore --db database_name --collection collection_name /path/to/backup/directory/your_database/collection_name.bson

mongodump with --query 
mongodump --db your_database --collection your_collection --query '{"field": "value"}' --out /path/to/backup/directory


mongodump --db your_database --collection your_collection --out /path/to/backup/directory

