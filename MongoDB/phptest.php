// Verbindung zur MongoDB-Datenbank herstellen
const MongoClient = require('mongodb').MongoClient;
const uri = 'mongodb://localhost:27017/myproject';
const client = new MongoClient(uri, { useNewUrlParser: true, useUnifiedTopology: true });
client.connect(err => {
  const collection = client.db("myproject").collection("tkey_rack");
  // Collection tkey_rack erstellen und Felder festlegen
  collection.createIndex({ id_number: 1 }, { unique: true }); // id_number als eindeutigen Index setzen
  collection.createIndex({ fi_location: 1 });
  // fi_location als Referenz auf tkey_location setzen
  collection.createIndex({ fi_location: 1 }, { sparse: true });
  collection.createIndex({ fi_location: 1, id_number: 1 }, { unique: true, sparse: true });
  // Verbindung schließen
  client.close();
});


# Convert tables to collections
db.createCollection("location")
db.createCollection("rack")
db.createCollection("usbHub")
db.createCollection("server")
db.createCollection("schirmbox")
db.createCollection("heRack")
db.createCollection("bluetoothDongle")
db.createCollection("device")

# Embed documents to represent relationships

# Embed a document representing a rack within the document representing a location
db.location.insert({
  id_city: "Berlin",
  ds_country: "Germany",
  ds_building: "Office",
  racks: [
    {
      id_number: "Rack1",
      usbHubs: [
        {
          id_id: "USB1",
        }
      ],
      servers: [
        {
          id_ipAddress: "192.168.0.1",
          ds_name: "Server1",
          ds_labOrTest: "Lab",
        }
      ],
      schirmbox: {
        id_schirmboxName: "ScreenBox1",
        bluetoothDongles: [
          {
            id_btmac: "BT1",
            ds_usbPort: "USB1"
          }
        ]
      }
    }
  ]
})

