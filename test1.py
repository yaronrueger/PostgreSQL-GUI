import tkinter as tk
from tkinter import *
import psycopg2
import tksheet
import math

window = tk.Tk()
window.title("WAB3_DB")
window.config(padx=50, pady=50)
window.config(bg="grey")
#scrollbar = Scrollbar(window)
#scrollbar.pack( side = RIGHT, fill = Y )

# Connect to the PostgreSQL database
conn = psycopg2.connect(database="wab3_db", user="postgres",password="R00t1", host="localhost", port="5432")
cur = conn.cursor()

tables=["tkey_location", "tkey_rack", "tkey_usbHub", "tkey_server", "tkey_schirmbox", "tkey_heRack", "tkey_device"]
sheets = []

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
        sheets[-1].grid(row=math.floor(j/2)+1, column=j%2)
        sheets[-1].enable_bindings(("single_select", "row_select", "column_width_resize","arrowkeys","right_click_popup_menu","rc_select", "rc_insert_row","rc_delete_row", "copy", "cut", "paste", "delete","undo","edit_cell"))
        j+=1

def delete_tables():
    for i in reversed(sheets):
        i.grid_forget()
        sheets.remove(i)

button1 = tk.Button(text="show all", bg="#0277BD", fg="white", font=("Arial", 12), command=get_tables)
button1.grid(row=0,column=0, sticky= "w")

button2 = tk.Button(text="show nothing", bg="#0277BD", fg="white", font=("Arial", 12), command=delete_tables)
button2.grid(row=0,column=1, sticky= "w")

window.mainloop()

# Close the database connection when the program exits
cur.close()
conn.close()