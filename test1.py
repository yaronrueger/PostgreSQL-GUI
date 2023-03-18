_version_ = "1.0"
_author_ = "Yaron Rueger"
_email_ = "yaron.rueger@telekom.de"
_maintainer_ = "Yaron Rueger"


########################################################################
#TODO:
#   [0] add button to save changes
#   [x] get the tableNames from the database
#   [x] name of the table
#   [] change button to add the table not replace it
#   [x] change size of table
#       -->[]place them one in a row
#   [x] darkmode
#   [x] get the columnsnames from the database
#   [] scrollbar for window
#   [] add real data
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
#window.grid_rowconfigure(2, weight=1)    
window.title("WAB3_DB")
window.config(padx=50, pady=50)
window.config(bg="#2d2d2d")
window.geometry("1000x500")
#scrollbar = Scrollbar(window)
#scrollbar.pack( side = RIGHT, fill = Y )

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

#######################get_allTables()#########################################
#def get_tables():
#    delete_tables()
#    j = 0
#    for i in tables:
#        cur.execute("SELECT * FROM " + i)
#        data = cur.fetchall()
#        newdata = []
#        for i in data:
#            newdata.append(list(i))
#        sheets.append(tksheet.Sheet(window, data=newdata))
#        sheets[j].grid(row=j+6, column=0, rowspan=20, columnspan=9, sticky="nsew")
#        sheets[j].enable_bindings(("single_select", "row_select", "column_width_resize","arrowkeys","right_click_popup_menu","rc_select", "rc_insert_row","rc_delete_row", "copy", "cut", "paste", "delete","undo","edit_cell"))
#        sheets[j].extra_bindings([("end_edit_cell", cell_edited)])
#        j+=1

#######################cell_edited()#########################################
#def cell_edited(event):
#    changedData = event[3]
#    row = event[0]
#    column = event[1]

def cell_editedOne(event):
    print(event)
    changedData = event[3]
    print(changedData)
    columnsName = sheets[-1].get_sheet_data(return_copy = False, get_header = True, get_index = False)[event[1]]
    print(columnsName)
    idName = sheets[-1].get_sheet_data(return_copy = False, get_header = True, get_index = False)[0]
    print(idName)
    idWert = sheets[-1].get_cell_data(event[0], 0, return_copy = True)
    print(idWert)
    cur.execute("UPDATE " + tkeyName + " SET " + columnsName + " = " + "'"+changedData +"'"+ " WHERE " + idName + " = " + "'"+idWert+"'")

label1= None
def get_oneTable(name):
    columns=[]
    global sheets
    global tkeyName
    tkeyName = name
    global label1
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
    

def delete_tables():
    global label1
    for i in reversed(sheets):
        i.grid_forget()
        sheets.remove(i)
        label1.grid_forget()

#button1 = tk.Button(text="show all", bg="#262626", fg="white", font=("Arial", 12), command=get_tables)
#button1.grid(row=0,column=0, sticky= "nsew")

button2 = tk.Button(text="show nothing", bg="#262626", fg="white", font=("Arial", 12), command=delete_tables)
button2.grid(row=3,column=1, sticky= "nsew")

for i in tables:
    button = tk.Button(text=i, bg="#262626", fg="white", font=("Arial", 12), command=lambda n=i: get_oneTable(n))
    buttons.append(button)

for i in range(len(buttons)):
    buttons[i].grid(row=math.floor(i/2),column=i%2, sticky= "nsew")
window.mainloop()

def save_data():
    ...

# Close the database connection when the program exits
cur.close()
conn.close()