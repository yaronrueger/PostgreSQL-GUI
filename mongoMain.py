from pymongo import MongoClient

# Verbindung zu MongoDB-Datenbank herstellen
myclient = MongoClient("mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.8.0")
print(myclient.list_database_names())

dblist = myclient.list_database_names()
if "wab3DB" in dblist:
    print("The database (wab3DB) exists.")

mydb  = myclient["wab3DB"]

mycol = mydb["customers"]

#mylist = [
#  { "_id": 1, "name": "John", "address": "Highway 37"},
#  { "_id": 2, "name": "Peter", "address": "Lowstreet 27"},
#  { "_id": 3, "name": "Amy", "address": "Apple st 652"},
#  { "_id": 4, "name": "Hannah", "address": "Mountain 21"},
#  { "_id": 5, "name": "Michael", "address": "Valley 345"},
#  { "_id": 6, "name": "Sandy", "address": "Ocean blvd 2"},
#  { "_id": 7, "name": "Betty", "address": "Green Grass 1"},
#  { "_id": 8, "name": "Richard", "address": "Sky st 331"},
#  { "_id": 9, "name": "Susan", "address": "One way 98"},
#  { "_id": 10, "name": "Vicky", "address": "Yellow Garden 2"},
#  { "_id": 11, "name": "Ben", "address": "Park Lane 38"},
#  { "_id": 12, "name": "William", "address": "Central st 954"},
#  { "_id": 13, "name": "Chuck", "address": "Main Road 989"},
#  { "_id": 14, "name": "Viola", "address": "Sideway 1633"}
#]


#x = mycol.insert_many(mylist)

#print list of the _id values of the inserted documents:
#print(x.inserted_ids)

x = mycol.find()
print(x)
myclient.close()
