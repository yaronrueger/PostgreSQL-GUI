DROP TABLE IF EXISTS tkey_device;
DROP TABLE IF EXISTS tkey_schirmbox;
DROP TABLE IF EXISTS tkey_usbHub;
DROP TABLE IF EXISTS tkey_server;
DROP TABLE IF EXISTS tkey_rack;
DROP TABLE IF EXISTS tkey_location;

CREATE TABLE tkey_location(
        id_city varChar(50) PRIMARY KEY,
        ds_country varChar(50),
        ds_building varChar(50)
);

CREATE TABLE tkey_rack(
        id_number varChar(50) PRIMARY KEY,
        fi_location varChar(50),
        FOREIGN KEY (fi_location) REFERENCES tkey_location(id_city)
);


CREATE TABLE tkey_server(
        id_ipAddress varChar(50) PRIMARY KEY,
        ds_labOrTest varChar(50),
        fi_rackNumber varChar(50),
        FOREIGN KEY (fi_rackNumber) REFERENCES tkey_rack(id_number)
);

CREATE TABLE tkey_usbHub(
        id_id varChar(50) PRIMARY KEY,
        ds_btMac varChar(50),
        fi_rackNumber varChar(50),
        FOREIGN KEY (fi_rackNumber) REFERENCES tkey_rack(id_number)
);

CREATE TABLE tkey_schirmbox(
        id_schirmboxName varChar(50) PRIMARY KEY,
        ds_btMac varChar(50),
        fi_rackNumber varChar(50),
        FOREIGN KEY (fi_rackNumber) REFERENCES tkey_rack(id_number)
);

CREATE TABLE tkey_device(
        id_androidID varChar(50) PRIMARY KEY,
        ds_model varChar(50),
        ds_msisdn varChar(50),
        ds_imei varChar(50),
        ds_btMac varChar(50),
        dy_batteryProj boolean,
        dn_usbPort int,
        fi_schirmboxName varChar(50),
        fi_ipAddress varChar(50),
        FOREIGN KEY (fi_ipAddress) REFERENCES tkey_server(id_ipAddress),
        FOREIGN KEY (fi_schirmboxName) REFERENCES tkey_schirmbox(id_schirmboxName)
);