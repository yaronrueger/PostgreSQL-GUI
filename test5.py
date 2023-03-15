import psycopg2
import tkinter as tk


# Connect to the PostgreSQL database
conn = psycopg2.connect(database="wab3_db", user="postgres", password="R00t1", host="localhost", port="5432")
cur = conn.cursor()

# Retrieve the data for the table from the database
cur.execute(f"SELECT * FROM tkey_location")
data = cur.fetchall()
print(data)
newdata = []
for i in data:
    newdata.append(list(i))

print(newdata)
print()
#print(data[1].split(","))
#print(data1)
# Close the database connection when the program exits
cur.close()
conn.close()
