DROP TABLE IF EXISTS tkey_device;
DROP TABLE IF EXISTS tkey_bluetoothDongle;
DROP TABLE IF EXISTS tkey_heRack;
DROP TABLE IF EXISTS tkey_schirmbox;
DROP TABLE IF EXISTS tkey_server;
DROP TABLE IF EXISTS tkey_usbHub;
DROP TABLE IF EXISTS tkey_rack;
DROP TABLE IF EXISTS tkey_location;

CREATE TABLE tkey_location(
        id_city TEXT PRIMARY KEY,
        ds_country TEXT,
        ds_building TEXT
);

CREATE TABLE tkey_rack(
        id_number TEXT PRIMARY KEY,
        fi_location TEXT REFERENCES tkey_location(id_city)
);

CREATE TABLE tkey_usbHub(
        id_id TEXT PRIMARY KEY,
        fi_rackNumber TEXT REFERENCES tkey_rack(id_number)
);
        
CREATE TABLE tkey_server(
        id_ipAddress TEXT PRIMARY KEY,
        ds_name TEXT,
        ds_labOrTest TEXT,
        fi_rackNumber TEXT REFERENCES tkey_rack(id_number)
);

CREATE TABLE tkey_schirmbox(
        id_schirmboxName TEXT PRIMARY KEY,
        fi_rackNumber TEXT REFERENCES tkey_rack(id_number)
);

CREATE TABLE tkey_heRack(
        id_id TEXT PRIMARY KEY,
        dn_he TEXT,
        fi_ipAddress TEXT REFERENCES tkey_server(id_ipAddress),
        fi_schirmboxName TEXT REFERENCES tkey_schirmbox(id_schirmboxName),
        fi_rack TEXT REFERENCES tkey_rack(id_number)
);

CREATE TABLE tkey_bluetoothDongle(
        id_btmac TEXT PRIMARY KEY,
        ds_usbPort TEXT,
        fi_schirmboxName TEXT REFERENCES tkey_schirmbox(id_schirmboxName)
);

CREATE TABLE tkey_device(
        id_androidID TEXT PRIMARY KEY,
        ds_model TEXT,
        ds_msisdn TEXT,
        ds_imei TEXT,
        ds_btMac TEXT,
        dy_batteryProj TEXT,
        dn_usbPort TEXT,
        fi_dongle TEXT REFERENCES tkey_bluetoothDongle(id_btmac),
        fi_ipAddress TEXT REFERENCES tkey_server(id_ipAddress),
        fi_schirmboxName TEXT REFERENCES tkey_schirmbox(id_schirmboxName)
);

INSERT INTO tkey_location(id_city, ds_country, ds_building) VALUES
('city1', 'country1', 'building1'),
('city2', 'country2', 'building2'),
('city3', 'country3', 'building3');

INSERT INTO tkey_rack(id_number, fi_location) VALUES
('number1', 'city1'),
('number2', 'city2'),
('number3', 'city3');

INSERT INTO tkey_usbHub(id_id, fi_rackNumber) VALUES
('id1', 'number1'),
('id2', 'number2'),
('id3', 'number3');

INSERT INTO tkey_server(id_ipAddress, ds_name, ds_labOrTest, fi_rackNumber) VALUES
('ip1', 'name1', 'lab', 'number1'),
('ip2', 'name2', 'test', 'number2'),
('ip3', 'name3', 'lab', 'number3');

INSERT INTO tkey_schirmbox(id_schirmboxName, fi_rackNumber) VALUES
('schirmbox1', 'number1'),
('schirmbox2', 'number2'),
('schirmbox3', 'number3');

INSERT INTO tkey_heRack(id_id,dn_he, fi_ipAddress, fi_schirmboxName, fi_rack) VALUES
('1','1', 'ip1', 'schirmbox1', 'number1'),
('2','2', 'ip2', 'schirmbox2', 'number2'),
('3','3', 'ip3', 'schirmbox3', 'number3');

INSERT INTO tkey_bluetoothDongle VALUES 
('1','2','schirmbox1'),
('2','4','schirmbox1'),
('3','6','schirmbox1');

INSERT INTO tkey_device(id_androidID, ds_model, ds_msisdn, ds_imei, ds_btMac, dy_batteryProj, dn_usbPort, fi_dongle, fi_ipAddress, fi_schirmboxName) VALUES
('androidID1', 'model1', 'msisdn1', 'imei1', 'btmac1', 'true', '1','1', 'ip1', 'schirmbox1'),
('androidID2', 'model2', 'msisdn2', 'imei2', 'btmac2', 'false', '2','1', 'ip2', 'schirmbox2'),
('androidID3', 'model3', 'msisdn3', 'imei3', 'btmac3', 'true', '3','1', 'ip3', 'schirmbox3');

--SELECT * FROM tkey_location INNER JOIN tkey_rack ON tkey_location.id_city=tkey_rack.fi_location;