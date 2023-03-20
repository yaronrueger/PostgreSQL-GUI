_version_ = "1.0"
_author_ = "Yaron Rueger"
_email_ = "yaron.rueger@telekom.de"
_maintainer_ = "Yaron Rueger"


import psycopg2
import math
import pandas as pd

eFile = pd.read_excel("dbE.xlsx")
print(eFile)

tkey_location=[]
tkey_rack=[]
tkey_usbHub=[]
tkey_server=[]
tkey_schirmbox=[]
tkey_heRack=[]
tkey_device=[]

insert_location ="INSERT INTO tkey_location VALUES (%s, %s, %s)"
insert_rack="INSERT INTO tkey_rack VALUES (%s, %s)"
insert_usbHub="INSERT INTO tkey_usbHub VALUES (%s, %s, %s)"
insert_server="INSERT INTO tkey_server VALUES (%s, %s, %s, %s)"
insert_schirmbox="INSERT INTO tkey_schirmbox VALUES (%s, %s, %s)"
insert_heRack="INSERT INTO tkey_heRack VALUES (%s, %s, %s, %s, %s)"
insert_device="INSERT INTO tkey_device VALUES (%s,%s, %s,%s, %s,%s, %s,%s, %s)"

print(eFile.head(1))