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

INSERT INTO tkey_location VALUES ('Nuernberg', 'Germany', 'GeorgElserStraße2');
INSERT INTO tkey_rack VALUES ('1', 'Nuernberg');
INSERT INTO tkey_usbHub VALUES ('101213', '2fa3d', '1');
INSERT INTO tkey_server VALUES ('10.112.125.01', 'my-nyge-sm-1', 'lab', '1');
INSERT INTO tkey_schirmbox VALUES ('schirmbox1', '12fa34b', '1');
INSERT INTO tkey_heRack VALUES (1, 0, '10.112.125.01', 'schirmbox1', '1');
INSERT INTO tkey_device VALUES ('12hf1', 'Samsung21', '121212', '22323', 'btmac1', true, 1, '10.112.125.01', 'schirmbox1');
