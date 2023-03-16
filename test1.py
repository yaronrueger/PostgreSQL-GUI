_version_ = "1.0"
_author_ = "Yaron Rueger"
_email_ = "yaron.rueger@telekom.de"
_maintainer_ = "Yaron Rueger"


########################################################################
#TODO:
#   [0] add button to save changes
#   [] change button to add the table not replace it
#   [] change size of table
#   [] darkmode
#   [] ...
#   [] name of the table
########################################################################
import tkinter as tk
from tkinter import *
import psycopg2
import tksheet
import math

window = tk.Tk()
for i in range(10):
    window.grid_columnconfigure(i, weight=1)

#window.grid_rowconfigure(2, weight=1)    
window.title("WAB3_DB")
window.config(padx=50, pady=50)
window.config(bg="#2d2d2d")


#window.geometry("1000x500")
#scrollbar = Scrollbar(window)
#scrollbar.pack( side = RIGHT, fill = Y )

# Connect to the PostgreSQL database
conn = psycopg2.connect(database="wab3_db", user="postgres",password="R00t1", host="localhost", port="5432")
cur = conn.cursor()

tables=["tkey_location", "tkey_rack", "tkey_usbHub", "tkey_server", "tkey_schirmbox", "tkey_heRack", "tkey_device"]
sheets = []
buttons = []

def get_tables():
    delete_tables()
    j = 0
    for i in tables:
        cur.execute("SELECT * FROM " + i)
        data = cur.fetchall()
        newdata = []
        for i in data:
            newdata.append(list(i))
        sheets.append(tksheet.Sheet(window, data=newdata))
        sheets[-1].grid(row=math.floor(j/2)+6, column=j%2)
        sheets[-1].enable_bindings(("single_select", "row_select", "column_width_resize","arrowkeys","right_click_popup_menu","rc_select", "rc_insert_row","rc_delete_row", "copy", "cut", "paste", "delete","undo","edit_cell"))
        j+=1

def get_oneTable(name):
    global sheets
    delete_tables()
    cur.execute("SELECT * FROM " + name)
    data = cur.fetchall()
    newdata = []
    for i in data:
        newdata.append(list(i))
    sheets.append(tksheet.Sheet(window, data=newdata))
    sheets[-1].enable_bindings(("single_select", "row_select", "column_width_resize","arrowkeys","right_click_popup_menu","rc_select", "rc_insert_row","rc_delete_row", "copy", "cut", "paste", "delete","undo","edit_cell"))
    sheets[-1].grid(row=6,column=0, rowspan=20, columnspan=9, sticky="nsew")

def delete_tables():
    for i in reversed(sheets):
        i.grid_forget()
        sheets.remove(i)

button1 = tk.Button(text="show all", bg="#0277BD", fg="white", font=("Arial", 12), command=get_tables)
button1.grid(row=0,column=0, sticky= "w")

button2 = tk.Button(text="show nothing", bg="#0277BD", fg="white", font=("Arial", 12), command=delete_tables)
button2.grid(row=0,column=1, sticky= "w")

for i in tables:
    button = tk.Button(text=i, bg="#0277BD", fg="white", font=("Arial", 12), command=lambda n=i: get_oneTable(n))
    buttons.append(button)

for i in range(len(buttons)):
    buttons[i].grid(row=math.floor(i/2)+2,column=i%2, sticky= "w")
window.mainloop()

def save_data():
    ...

# Close the database connection when the program exits
cur.close()
conn.close()