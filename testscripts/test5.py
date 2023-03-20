import tkinter as tk
from tkinter import *
import psycopg2
import tksheet
import math

window = tk.Tk()
window.title("WAB3_DB")
window.config(padx=50, pady=50)
window.config(bg="grey")
window.geometry("1000x500")

# Connect to the PostgreSQL database
conn = psycopg2.connect(database="wab3_db", user="postgres", password="R00t1", host="localhost", port="5432")
cur = conn.cursor()


cur.execute("""SELECT table_name FROM information_schema.tables
       WHERE table_schema = 'public'""")
tables = cur.fetchall()
for table in tables:
    print(table)
zahl = len(tables)

cur.execute("Select * FROM "+ tables[0][0] +" LIMIT 0")
print(cur.description)
columns = cur.description
for i in range(len(columns)):
    print(columns[i][0])
#columns = cur.fetchall()
#print(columns)
#print(len(tables))
#print(tables[zahl-1][0])

# Retrieve the data for the table from the database
cur.execute(f"SELECT * FROM tkey_location")
data = cur.fetchall()
newdata = []
for i in data:
    newdata.append(list(i))

#print(newdata)
def cell_edited(event):
    #print(event[3])
    ...
columnsList = []
for i in range(len(columns)):
    columnsList.append(columns[i][0])
sheet = tksheet.Sheet(window, data=newdata)
sheet.grid(row=0, column=0)
sheet.enable_bindings(("single_select", "row_select", "column_width_resize","arrowkeys","right_click_popup_menu","rc_select", "rc_insert_row","rc_delete_row", "copy", "cut", "paste", "delete","undo","edit_cell"))
sheet.extra_bindings([("end_edit_cell", cell_edited)])
sheet.headers(columnsList)




#print(sheet.get_sheet_data())
#newdata = sheet.get_sheet_data()

#cur.execute("INSERT INTO tkey_location VALUES " + newdata[0][0])
# Close the database connection when the program exits

window.mainloop()
cur.close()
conn.close()
