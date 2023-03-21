_version_ = "1.0"
_author_ = "Yaron Rueger"
_email_ = "yaron.rueger@telekom.de"
_maintainer_ = "Yaron Rueger"


########################################################################
#TODO:
#   [0] add button to save changes
#   [x] get the tableNames from the database
#   [x] name of the table
#   [] add warnings
#   [x] change size of table
#   [x] darkmode
#   [x] get the columnsnames from the database
#   [] add real data
#   [] clean code
#       -->[]add comments
########################################################################

import tkinter as tk
from tkinter import *
import psycopg2
import tksheet
import math

window = tk.Tk()
for i in range(10):
    window.grid_columnconfigure(i, weight=1)

#space between buttons and tables
window.grid_rowconfigure(6, minsize=30)
window.title("WAB3_DB")
window.config(padx=50, pady=50)
window.config(bg="#2d2d2d")
window.geometry("1000x500")

# Connect to the PostgreSQL database
conn = psycopg2.connect(database="wab3_db", user="postgres",password="R00t1", host="localhost", port="5432")
cur = conn.cursor()
#creates list of table names
tables=[]
cur.execute("""SELECT table_name FROM information_schema.tables
       WHERE table_schema = 'public'""")
tableNames = cur.fetchall()
tablesLength = len(tableNames)
for i in range(tablesLength):
    tables.append(tableNames[i][0])

sheets = []
buttons = []
tkeyName = "null"

def cell_editedOne(event):
    changedData = event[3]
    columnsName = sheets[-1].get_sheet_data(return_copy = False, get_header = True, get_index = False)[event[1]]
    idName = sheets[-1].get_sheet_data(return_copy = False, get_header = True, get_index = False)[0]
    idWert = sheets[-1].get_cell_data(event[0], 0, return_copy = True)
    cur.execute("UPDATE " + tkeyName + " SET " + columnsName + " = " + "'"+changedData +"'"+ " WHERE " + idName + " = " + "'"+idWert+"'")

label1= None
button3=None
button5 =None

def save_data():
    conn.commit()

def add_data():
    print("In Arbeit")

def get_oneTable(name):
    columns=[]
    global sheets
    global tkeyName
    tkeyName = name
    global label1
    global button3
    global button5
    delete_tables()
    
    label1 = tk.Label(window, text=name)
    label1.grid(row=7, column=0, sticky="nsew")

    cur.execute("Select * FROM "+ name +" LIMIT 0")
    columnLength= cur.description
    for i in range(len(columnLength)):
        columns.append(columnLength[i][0])

    cur.execute("SELECT * FROM " + name)
    data = cur.fetchall()
    newdata = []
    for i in data:
        newdata.append(list(i))
    sheets.append(tksheet.Sheet(window, data=newdata,enable_edit_cell_auto_resize = True, auto_resize_default_row_index = True))
    sheets[-1].enable_bindings(("single_select", "row_select", "column_width_resize","arrowkeys","right_click_popup_menu","rc_select", "rc_insert_row","rc_delete_row", "copy", "cut", "paste", "delete","undo","edit_cell"))
    sheets[-1].grid(row=8,column=0, rowspan=20, columnspan=9, sticky="nsew")
    sheets[-1].headers(columns)
    sheets[-1].extra_bindings([("end_edit_cell", cell_editedOne)])

    button3 = tk.Button(text="commit", bg="#262626", fg="white", font=("Arial", 12), command=save_data)
    button3.grid(row=7,column=1,  sticky= "nsew")

    button5 = tk.Button(text="add", bg="#262626", fg="green", font=("Arial", 12), command=add_data)
    button5.grid(row=7,column=2,  sticky= "nsew")

def delete_tables():
    global label1
    global button3
    for i in reversed(sheets):
        i.grid_forget()
        sheets.remove(i)
        if(button3 != None):
            button3.grid_forget()
        if(label1 != None):
            label1.grid_forget()
        if(button5!= None):
            button5.grid_forget()

def search_data():
    print("In Arbeit")

button4 = tk.Button(text="search", bg="#262626", fg="white", font=("Arial", 12), command=search_data)
button4.grid(row=3,column=1,  sticky= "nsew")
button2 = tk.Button(text="show nothing", bg="#262626", fg="white", font=("Arial", 12), command=delete_tables)
button2.grid(row=0,column=2, rowspan= 4,  sticky= "nsew")

for i in tables:
    button = tk.Button(text=i, bg="#262626", fg="white", font=("Arial", 12), command=lambda n=i: get_oneTable(n))
    buttons.append(button)

for i in range(len(buttons)):
    buttons[i].grid(row=math.floor(i/2),column=i%2, sticky= "nsew")
window.mainloop()

# Close the database connection when the program exits
cur.close()
conn.close()