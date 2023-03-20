DROP TABLE IF EXISTS tkey_device;
DROP TABLE IF EXISTS tkey_heRack;
DROP TABLE IF EXISTS tkey_schirmbox;
DROP TABLE IF EXISTS tkey_server;
DROP TABLE IF EXISTS tkey_usbHub;
DROP TABLE IF EXISTS tkey_rack;
DROP TABLE IF EXISTS tkey_location;

CREATE TABLE tkey_location(
        id_city varChar(50) PRIMARY KEY,
        ds_country varChar(50),
        ds_building varChar(50)
);

CREATE TABLE tkey_rack(
        id_number varChar(50) PRIMARY KEY,
        fi_location varChar(50) REFERENCES tkey_location(id_city)
);

CREATE TABLE tkey_usbHub(
        id_id varChar(50) PRIMARY KEY,
        ds_btMac varChar(50),
        fi_rackNumber varChar(50) REFERENCES tkey_rack(id_number)
);
        
CREATE TABLE tkey_server(
        id_ipAddress varChar(50) PRIMARY KEY,
        ds_name text,
        ds_labOrTest varChar(50),
        fi_rackNumber varChar(50) REFERENCES tkey_rack(id_number)
);

CREATE TABLE tkey_schirmbox(
        id_schirmboxName text PRIMARY KEY,
        ds_btMac varChar(50),
        fi_rackNumber varChar(50) REFERENCES tkey_rack(id_number)
);

CREATE TABLE tkey_heRack(
        id_id SERIAL PRIMARY KEY,
        dn_he int,
        fi_ipAddress varChar(50) REFERENCES tkey_server(id_ipAddress),
        fi_schirmboxName varChar(50) REFERENCES tkey_schirmbox(id_schirmboxName),
        fi_rack varChar(50) REFERENCES tkey_rack(id_number)
);

CREATE TABLE tkey_device(
        id_androidID varChar(50) PRIMARY KEY,
        ds_model varChar(50),
        ds_msisdn varChar(50),
        ds_imei varChar(50),
        ds_btMac varChar(50),
        dy_batteryProj boolean,
        dn_usbPort int,
        fi_ipAddress varChar(50) REFERENCES tkey_server(id_ipAddress),
        fi_schirmboxName text REFERENCES tkey_schirmbox(id_schirmboxName)
);

INSERT INTO tkey_location(id_city, ds_country, ds_building) VALUES
('city1', 'country1', 'building1'),
('city2', 'country2', 'building2'),
('city3', 'country3', 'building3');

INSERT INTO tkey_rack(id_number, fi_location) VALUES
('number1', 'city1'),
('number2', 'city2'),
('number3', 'city3');

INSERT INTO tkey_usbHub(id_id, ds_btMac, fi_rackNumber) VALUES
('id1', 'btmac1', 'number1'),
('id2', 'btmac2', 'number2'),
('id3', 'btmac3', 'number3');

INSERT INTO tkey_server(id_ipAddress, ds_name, ds_labOrTest, fi_rackNumber) VALUES
('ip1', 'name1', 'lab', 'number1'),
('ip2', 'name2', 'test', 'number2'),
('ip3', 'name3', 'lab', 'number3');

INSERT INTO tkey_schirmbox(id_schirmboxName, ds_btMac, fi_rackNumber) VALUES
('schirmbox1', 'btmac1', 'number1'),
('schirmbox2', 'btmac2', 'number2'),
('schirmbox3', 'btmac3', 'number3');

INSERT INTO tkey_heRack(dn_he, fi_ipAddress, fi_schirmboxName, fi_rack) VALUES
(1, 'ip1', 'schirmbox1', 'number1'),
(2, 'ip2', 'schirmbox2', 'number2'),
(3, 'ip3', 'schirmbox3', 'number3');

INSERT INTO tkey_device(id_androidID, ds_model, ds_msisdn, ds_imei, ds_btMac, dy_batteryProj, dn_usbPort, fi_ipAddress, fi_schirmboxName) VALUES
('androidID1', 'model1', 'msisdn1', 'imei1', 'btmac1', true, 1, 'ip1', 'schirmbox1'),
('androidID2', 'model2', 'msisdn2', 'imei2', 'btmac2', false, 2, 'ip2', 'schirmbox2'),
('androidID3', 'model3', 'msisdn3', 'imei3', 'btmac3', true, 3, 'ip3', 'schirmbox3');

--SELECT * FROM tkey_location INNER JOIN tkey_rack ON tkey_location.id_city=tkey_rack.fi_location;