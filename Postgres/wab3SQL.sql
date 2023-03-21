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

INSERT INTO tkey_location VALUES (
    ('Nuernberg', 'Germany', 'Georg_Elser_Straße H002')
    );

INSERT INTO tkey_rack VALUES (
    ('UPDATE_ME','Nuernberg')
    );

INSERT INTO  tkey_usbHub VALUES (
    ('D6E2948D','UPDATE_ME'),
    ('D3E79188','UPDATE_ME'),
    ('0E3F4950','UPDATE_ME'),
    ('CC2F5E40','UPDATE_ME'),
    ('D5364759','UPDATE_ME'),
    ('5952243D','UPDATE_ME'),
    ('CE2D5C42','UPDATE_ME'),
    ('CE2D5C42','UPDATE_ME'),
    ('9E7D0C12','UPDATE_ME'),
    ('4ABECFD1','UPDATE_ME'),
    ('01196F76','UPDATE_ME'),
    ('4ABECFD1','UPDATE_ME')
    );

INSERT INTO tkey_server VALUES (
    ('10.213.125.245', 'mg-nyge-sm-1', 'LAB', 'UPDATE_ME'),
    ('10.213.125.247','mg-nyge-sm-2', 'LAB', 'UPDATE_ME'),
    ('10.213.125.252','mg-nyge-test','LAB','UPDATE_ME'),
    ('10.213.125.248','mg-nyge-live-2','LIVE','UPDATE_ME'),
    ('10.213.125.251','mg-nyge-ref','LAB','UPDATE_ME'),
    ('10.34.35.180','mg-nyge-1','LAB','UPDATE_ME')
    );

INSERT INTO tkey_schirmbox VALUES (
    ('SM TA3 BOX1','UPDATE_ME'),
    ('SM TA3 BOX2','UPDATE_ME'),
    ('SM TA4 BOX1','UPDATE_ME'),
    ('Kiste 1 auf dem Rack','UPDATE_ME'),
    ('Kiste 2 auf dem Rack','UPDATE_ME'),
    ('NYGE-Test-BIG','UPDATE_ME'),
    ('NYGE-Test-BIG2','UPDATE_ME'),
    ('OUT 1','UPDATE_ME'),
    ('OUT 2','UPDATE_ME'),
    ('OUT 4','UPDATE_ME'),
    ('OUT 6','UPDATE_ME'),
    ('NYGE-Ref-BIG','UPDATE_ME'),
    ('NYYGE-REF-SMALL oben rechts','UPDATE_ME'),
    ('H009 links','UPDATE_ME'),
    ('H009 rechts','UPDATE_ME')
    );

--heRack für Server [x.1] und  Schirmbox[x.2]
INSERT INTO tkey_heRack(id_id, dn_he,fi_ipAddress,fi_rack) VALUES (
    ('1.1','UPDATE_ME','10.213.125.245','UPDATE_ME'),
    ('2.1','UPDATE_ME','10.213.125.247','UPDATE_ME'),
    ('3.1','UPDATE_ME','10.213.125.252','UPDATE_ME'),
    ('4.1','UPDATE_ME','10.213.125.248','UPDATE_ME'),
    ('5.1','UPDATE_ME','10.213.125.251','UPDATE_ME'),
    ('6.1','UPDATE_ME','10.34.35.180','UPDATE_ME')
);
INSERT INTO tkey_heRack(id_id, dn_he,fi_schirmboxName,fi_rack) VALUES (
    ('1.2','UPDATE_ME','SM TA3 BOX1','UPDATE_ME'),
    ('2.2','UPDATE_ME','SM TA3 BOX2','UPDATE_ME'),
    ('3.2','UPDATE_ME','SM TA4 BOX1','UPDATE_ME'),
    ('4.2','UPDATE_ME','Kiste 1 auf dem Rack','UPDATE_ME'),
    ('5.2','UPDATE_ME','Kiste 2 auf dem Rack','UPDATE_ME'),
    ('6.2','UPDATE_ME','NYGE-Test-BIG','UPDATE_ME'),
    ('7.2','UPDATE_ME','NYGE-Test-BIG2','UPDATE_ME'),
    ('8.2','UPDATE_ME','OUT 1','UPDATE_ME'),
    ('9.2','UPDATE_ME','OUT 2','UPDATE_ME'),
    ('10.2','UPDATE_ME','OUT 4','UPDATE_ME'),
    ('11.2','UPDATE_ME','OUT 6','UPDATE_ME'),
    ('12.2','UPDATE_ME','NYGE-Ref-BIG','UPDATE_ME'),
    ('13.2','UPDATE_ME','NYYGE-REF-SMALL oben rechts','UPDATE_ME'),
    ('14.2','UPDATE_ME','H009 links','UPDATE_ME'),
    ('15.2','UPDATE_ME','H009 rechts','UPDATE_ME')
);

INSERT INTO tkey_bluetoothDongle VALUES (
    ('B6:E3:14:06:03:02','2','SM TA3 BOX1'),
    ('B6:E3:14:06:03:04','4','SM TA3 BOX1'),
    ('BE:E3:14:06:03:06'.'6','SM TA3 BOX1'),
    ('BE:E3:14:06:03:08','8','SM TA3 BOX1'),
    ('BE:E3:14:06:03:10','10','SM TA3 BOX1'),
    ('BE:E3:14:06:03:12','12','SM TA3 BOX1'),
    ('BE:E3:14:06:03:14','14','SM TA3 BOX1'),
    ('BE:E3:14:06:04:02','2','SM TA3 BOX2'),
    ('BE:E3:14:06:04:04','4','SM TA3 BOX2'),
    ('BE:E3:14:06:04:06','6','SM TA3 BOX2'),
    ('BE:E3:14:06:04:08','8','SM TA3 BOX2'),
    ('BE:E3:14:06:04:10','10','SM TA3 BOX2'),
    ('BE:E3:14:06:04:12','12','SM TA3 BOX2'),
    ('BE:E3:14:06:04:14','14','SM TA3 BOX2'),
    ('B6:E3:14:06:05:02','2','SM TA4 BOX1'),
    ('B6:E3:14:06:05:04','4','SM TA4 BOX1'),
    ('B6:E3:14:06:05:06','6','SM TA4 BOX1'),
    ('B6:E3:14:06:05:08','8','SM TA4 BOX1'),
    ('B6:E3:14:06:05:10','10','SM TA4 BOX1'),
    ('B6:E3:14:06:05:12','12','SM TA4 BOX1'),
    ('B6:E3:14:06:05:14','14','SM TA4 BOX1'),
    ('B6:E3:14:06:01:02','-','Kiste 2 auf dem Rack'),
    ('8E:E6:94:21:DA:93','-','Kiste 1 auf dem Rack'),
    ('0A:33:37:4A:9C:60','-','Kiste 1 auf dem Rack'),
    ('62:1A:84:FF:95:D4','-','Kiste 1 auf dem Rack'),
    ('AA:CF:7F:4C:B9:4E','-','Kiste 1 auf dem Rack'),
    ('FD:DD:92:D1:A6:55','-','Kiste 1 auf dem Rack'),
    ('DA:E0:53:CC:09:56','-','Kiste 1 auf dem Rack'),
    ('DE:C1:79:1B:F6:E7','-','Kiste 1 auf dem Rack'),
    ('E9:23:A4:26:0A:8D','-','Kiste 1 auf dem Rack'),
    ('EB:EF:C5:34:43:9B','-','Kiste 1 auf dem Rack'),
    ('18:B2:11:E8:3B:5A','-','Kiste 1 auf dem Rack'),
    ('2D:B8:85:98:08:A1','-','Kiste 2 auf dem Rack'),
    ('2D:B8:85:98:08:A2','-','Kiste 2 auf dem Rack'),
    ('00:1A:7D:DA:71:14','-','Kiste 2 auf dem Rack'),
    ('00:1A:7D:DA:71:24','-','Kiste 2 auf dem Rack'),
    ('74:13:49:7E:FD:28','2','NYGE-Test-BIG'),
    ('CB:4C:E8:4E:FD:43 ','4','NYGE-Test-BIG'),
    ('4B:D7:4B:E0:46:B8 ','6','NYGE-Test-BIG'),
    ('AC:1B:D8:5D:62:B1','8','NYGE-Test-BIG'),
    ('34:7B:1B:BE:7E:2B','10','NYGE-Test-BIG'),
    ('AF:8F:5F:3C:01:12','12','NYGE-Test-BIG'),
    ('4A:20:A4:51:A3:8D ','-','Out 1'),
    ('66:AA:EA:0B:D7:09','-','Out 2'),
    ('FD:E3:DE:65:92:BD','-','Out 4'),
    ('7D:56:42:C5:EC:F3','-','Out 6'),
    ('93:EB:32:C0:02:02','2','NYGE-Test-BIG2'),
    ('93:EB:32:C0:02:04','4','NYGE-Test-BIG2'),
    ('74:9E:F5:53:57:48','6','NYGE-Ref-BIG'),
    ('74:9E:F5:53:57:70','4','NYGE-Ref-BIG'),
    ('74:9E:F5:53:5B:8C','2','NYYGE-REF-SMALL oben rechts'),
    ('00:1A:7D:DA:71:03','-','H009 links'),
    ('00:1A:7D:DA:71:08','-','H009 rechts'),
    ('00:1A:7D:DA:71:09','-','H009 rechts'),
    ('00:15:83:52:0F:06','-','H009 links'),
    ('00:1A:7D:DA:71:15','-','H009 links'),
    ('00:15:83:52:0F:0E','-','H009 rechts'),
    ('00:15:83:51:EA:07','-','H009 links'),
    ('00:1A:7D:DA:71:14#2','-','H009 rechts'),
    ('2C:0F:8B:C5:E0:1B','-','H009 links'),
    ('00:1A:7D:DA:71:06','-','H009 links'),
    ('00:1A:7D:DA:71:11','-','H009 rechts'),
    ('93:EB:32:C0:02:06','6','NYGE-Test-BIG2'),
    ('93:EB:32:C0:02:08','8','NYGE-Test-BIG2')
);

INSERT INTO tkey_device VALUES (
    ('R3CR904K4ZT','S21','4915159716901', '350517924691347','F0:F5:64:70:93:DD', 'False', '1','B6:E3:14:06:03:02','10.213.125.245', 'SM TA3 BOX1'),
    ('R3CR9032NZT','S21','4915159716902','350517924599524','F0:F5:64:6E:C2:9F','False','1','B6:E3:14:06:03:04','10.213.125.245','SM TA3 BOX1'),
    ('R3CR9032R5H','S21','4915159716903','350517924600249','F0:F5:64:6E:C3:2F','False','3','BE:E3:14:06:03:06','10.213.125.245','SM TA3 BOX1'),
    ('R3CR904K4CZ','S21','4915159716904','350517924691149','F0:F5:64:70:93:B5','False','5','BE:E3:14:06:03:08','10.213.125.245','SM TA3 BOX1'),  
    ('R3CR904K4JY','S21','4915159716905','350517924691206','F0:F5:64:70:93:C1','False','7','BE:E3:14:06:03:10','10.213.125.245','SM TA3 BOX1'),
    ('R3CR9032T9T','S21','4915159716906','350517924600942','F0:F5:64:6E:C3:BB','False','9','BE:E3:14:06:03:12','10.213.125.245','SM TA3 BOX1'),
    ('R3CR9032K1N','S21','4915159716907','350517924598229','F0:F5:64:6E:C1:9B','False','11','BE:E3:14:06:03:14','10.213.125.245','SM TA3 BOX1'),
    ('R3CR80FAVRW','S21','4915159716908','350517923646458','F0:F5:64:5D:C1:8B','False','13','BE:E3:14:06:04:02','10.213.125.245','SM TA3 BOX2'),
    ('R3CR9032SVE','S21','4915159716909','350517924600801','F0:F5:64:6E:C3:9F','False','1','BE:E3:14:06:04:04','10.213.125.245','SM TA3 BOX2'),
    ('R3CR9036ESB','S21','4915159716910','350517924640385','F0:F5:64:6E:E2:8B','False','3','BE:E3:14:06:04:06','10.213.125.245','SM TA3 BOX2'),
    ('R3CR904K4VR','S21','4915159716911','350517924691305','F0:F5:64:70:93:D5','False','5','BE:E3:14:06:04:08','10.213.125.245','SM TA3 BOX2'),
    ('R3CR903190X','S21','4915159716912','350517924584021','F0:F5:64:6E:B6:83','False','7','BE:E3:14:06:04:10','10.213.125.245','SM TA3 BOX2'),
    ('R3CR904K4KB','S21','4915159716913','350517924691214','F0:F5:64:70:93:C3','False','9','BE:E3:14:06:04:12','10.213.125.245','SM TA3 BOX2'),
    ('R3CR9032T6N','S21','4915159716914','350517924600918','F0:F5:64:6E:C3:B5','False','11','BE:E3:14:06:04:14','10.213.125.245','SM TA3 BOX2'),
    ('R3CR9032GWR','S21','491715936214','350517924597510','F0:F5:64:6E:C1:0D','False','13','B6:E3:14:06:05:02','10.213.125.247','SM TA4 BOX1'),
    ('R3CR9036M3T','S21','491715936215','350517924642464','F0:F5:64:6E:E4:2B','False','1','B6:E3:14:06:05:04','10.213.125.247','SM TA4 BOX1'),
    ('R3CR9032T8Z','S21','491715936216','350517924600934','F0:F5:64:6E:C3:B9','False','3','B6:E3:14:06:05:06','10.213.125.247','SM TA4 BOX1'),
    ('R3CR9032P1D','S21','491715936217','350517924599540','F0:F5:64:6E:C2:A3','False','5','B6:E3:14:06:05:08','10.213.125.247','SM TA4 BOX1'),
    ('R3CR9032PAL','S21','491715936218','350517924599631','F0:F5:64:6E:C2:B5','False','7','B6:E3:14:06:05:10','10.213.125.247','SM TA4 BOX1'),
    ('R3CR904K49R','S21','491715936219','350517924691115','F0:F5:64:70:93:AF','False','9','B6:E3:14:06:05:12','10.213.125.247','SM TA4 BOX1'),
    ('R3CR9032JMW','S21','491715936220','350517924598096','F0:F5:64:E6:C1:81','True','11','B6:E3:14:06:05:14','10.213.125.247','SM TA4 BOX1'),
    ('R3CRA0WZ1WN','S21','4915208177053','350517927859735','F0:F5:64:B2:9A:5F','True','13','B6:E3:14:06:01:02','10.213.125.252','Kiste 2 auf dem Rack'),
    ('R5CRC42LFNV','S21','4915170407609','352946242837332','30:74:67:C7:51:80','True','-','8E:E6:94:21:DA:93','10.213.125.248','Kiste 1 auf dem Rack'),
    ('R5CRC41BTBN','S21','4915170407610','352946242810545','30:74:67:C5:94:EC','True','-','0A:33:37:4A:9C:60','10.213.125.248','Kiste 1 auf dem Rack'),
    ('R5CRC42LB5L','S21','4915170407722','352946242835849','30:74:67:C7:50:56','True','-','62:1A:84:FF:95:D4','10.213.125.248','Kiste 1 auf dem Rack'),
    ('R5CRC41BRPH','S21','4915170407758','352946242810008','30:74:67:C5:94:80','True','-','AA:CF:7F:4C:B9:4E','10.213.125.248','Kiste 1 auf dem Rack'),
    ('R5CRC3PF3KX','S21','4915170407768','352946242586020','30:74:67:AF:A9:54','True','-','FD:DD:92:D1:A6:55','10.213.125.248','Kiste 1 auf dem Rack'),
    ('R5CRC41C9LW','S21','4915170407842','352946242815585','30:74:67:C5:98:DC','True','-','DA:E0:53:CC:09:56','10.213.125.248','Kiste 1 auf dem Rack'),
    ('R5CRC41C9SF','S21','4915170407877','352946242815643','30:74:67:C5:98:E8','True','-','DE:C1:79:1B:F6:E7','10.213.125.248','Kiste 1 auf dem Rack'),
    ('R5CRC45YZPA','S21','4915170407878','352946242895678','30:74:67:D3:18:02','True','-','E9:23:A4:26:0A:8D','10.213.125.248','Kiste 1 auf dem Rack'),
    ('R5CRC41BS9A','S21','4915170407830','352946242810198','30:74:67:C5:94:A6','True','-','EB:EF:C5:34:43:9B','10.213.125.248','Kiste 1 auf dem Rack'),
    ('R5CRC41BS1L','S21','4915170407792','352946242810115','30:74:67:C5:94:96','True','-','18:B2:11:E8:3B:5A','10.213.125.248','Kiste 1 auf dem Rack'),
    ('R3CRA0WZ9KK','S21','491602368254','350517927862275','F0:F5:64:B2:9C:5B','True','-','2D:B8:85:98:08:A1','10.213.125.248','Kiste 2 auf dem Rack'),
    ('R5CR92WJ8KP','S21','491602363117','355320544812350','54:D1:7D:B8:09:BE','True','-','2D:B8:85:98:08:A2','10.213.125.248','Kiste 2 auf dem Rack'),
    ('RF8N915QJJH','S20','491718347327','356007118985311',' B4:CE:40:A2:94:77','True','-','00:1A:7D:DA:71:14','10.213.125.248','Kiste 2 auf dem Rack'),
    ('RF8N915QK4D','S20','491718341295','356007118985501','B4:CE:40:A2:94:9D','True','-','00:1A:7D:DA:71:24','10.213.125.248','Kiste 2 auf dem Rack'),
    ('R38MB0BXYLY','S10','4915159715838','-','74:9E:F5:53:60:60','False','1','74:13:49:7E:FD:28','10.213.125.252','NYGE-Test-BIG'),
    ('R5CR604HCZT','S21','4915159715839','-','F0:39:65:08:54:52','False','3','CB:4C:E8:4E:FD:43','10.213.125.252','NYGE-Test-BIG'),
    ('R5CR604K2ED','S21','4915159715844','352859307664287','F0:39:65:08:62:9E','False','5','4B:D7:4B:E0:46:B8','10.213.125.252','NYGE-Test-BIG'),
    ('R3CRA0WZD5T','S21','4915159716951','350517927863455','F0:F5:64:B2:9D:47','False','7','AC:1B:D8:5D:62:B1','10.213.125.252','NYGE-Test-BIG'),
    ('R3CRA010X0F','S21','4915159716952','350517926152496','F0:F5:64:90:4B:B9','False','9','34:7B:1B:BE:7E:2B','10.213.125.252','NYGE-Test-BIG'),
    ('R3CRA0WZ8GK','S21','48602039847','-','F0:F5:64:B2:9C:13','False','11','AF:8F:5F:3C:01:12','10.213.125.252','NYGE-Test-BIG'),
    ('R5CR604K74T','S21','4915159715842',,'352859307665839','F0:39:65:08:63:D4','False','-','4A:20:A4:51:A3:8D','10.213.125.252','Out 1'),
    ('R38MB0BXBPB','S10','4915159715845',,'353697110401045','74:9E:F5:53:5B:3E','False','-','66:AA:EA:0B:D7:09','10.213.125.252','Out 2'),
    ('R38MB0BXLDE','S10','4915159715841',,'353697110403918','74:9E:F5:53:5D:7C','False','-','FD:E3:DE:65:92:BD','10.213.125.252','Out 4'),
    ('R38MB0BX0NY','S10','4915159715843',,'353697110397409','74:9E:F5:53:58:66','False','-','7D:56:42:C5:EC:F3','10.213.125.252','Out 6'),
    ('R5CR604HCMZ','S21','4915159715846',,'-','F0:39:65:08:54:3C','False','1','93:EB:32:C0:02:02','10.213.125.252','NYGE-Test-BIG2'),
    ('R5CR604HD3D','S21','4915159715847',,'-','F0:39:65:08:54:5A','False','3','93:EB:32:C0:02:04','10.213.125.252','NYGE-Test-BIG2'),
    ('R38MB0BWWBY','S10','491715934998','353697110395973','74:9E:F5:53:57:48','False','5','74:9E:F5:53:57:48','10.213.125.251','NYGE-Ref-BIG'),
    ('R38MB0BWWYH','S10','491715934999','353697110396179','74:9E:F5:53:57:70','False','-','74:9E:F5:53:57:70','10.213.125.251','NYGE-Ref-BIG'),
    ('R38MB0BXCWN','S10','491715935000','353697110401433','74:9E:F5:53:5B:8C','False','-','74:9E:F5:53:5B:8C','10.213.125.251','NYYGE-REF-SMALL oben rechts'),
    ('RF8M21BVBDM','S10','4915159715314','351910104723544','CC:21:19:E5:30:50','True','-','00:1A:7D:DA:71:03','10.34.35.180','H009 links'),
    ('R38M907BXNY','S10','4915159712392','354622108774582','64:7B:CE:FE:4F:C3','True','-','00:1A:7D:DA:71:08','10.34.35.180','H009 rechts'),
    ('R3CNA0AY53D','S20 5G','4915159715191','351826112896850','5C:CB:99:EA:56:BA','True','-','00:1A:7D:DA:71:09','10.34.35.180','H009 rechts'),
    ('R38MB0BWX9W','S10','4915159713970','353697110396286','74:9E:F5:53:57:86','True','-','00:15:83:52:0F:06','10.34.35.180','H009 links'),
    ('RFCN309STHK','S20 5G','4915159715576','354397112512548','18:54:CF:A9:CC:67','True','-','00:1A:7D:DA:71:15','10.34.35.180','H009 links'),
    ('RF8M217X5VX','S10','436762591717','351910104556076','CC:21:19:E0:57:76','True','-','00:15:83:52:0F:0E','10.34.35.180','H009 rechts'),
    ('RF8M21BV5AA','S10','4915159712391','351910104721530','CC:21:19:E5:2E:BE','True','-','00:15:83:51:EA:07','10.34.35.180','H009 links'),
    ('RFCN3027MZA','S20 5G','4915159715136','354397111994408','18:54:CF:81:6C:4B','True','-','00:1A:7D:DA:71:14#2','10.34.35.180','H009 rechts'),
    ('R38MB0BWWGF','S10','4915159713970','353697110396021','74:9E:F5:53:57:52','True','-','2C:0F:8B:C5:E0:1B','10.34.35.180','H009 links'),
    ('2c9423922d057ece','S9','4915159712393','354663105429200','C0:BD:C8:30:BE:06','False','-','00:1A:7D:DA:71:06','10.34.35.180','H009 links'),
    ('R38MA0L43NR','S10','4915159714462','354622109752397','74:9E:F5:30:AF:3E','True','-','00:1A:7D:DA:71:11','10.34.35.180','H009 rechts'),
    ('RF8N51EJ7ME','S20','4915159714935','-','B4:1A:1D:1D:18:2A','True','5','93:EB:32:C0:02:06','10.213.125.252','NYGE-Test-BIG2'),
    ('RF8N328WENY','S20','4915159714936','-','80:7B:3E:38:5D:74','True','7','93:EB:32:C0:02:08','10.213.125.252','NYGE-Test-BIG2')
);
--SELECT * FROM tkey_location INNER JOIN tkey_rack ON tkey_location.id_city=tkey_rack.fi_location;