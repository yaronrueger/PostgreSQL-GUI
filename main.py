_version_ = "1.0"
_author_ = "Yaron Rueger"
_email_ = "yaron.rueger@telekom.de"
_maintainer_ = "Yaron Rueger"

########################################################################
#TODO:
#   [0] add button to save changes
#   [x] get the tableNames from the database
#   [x] get the columnsnames from the database
#   [x] add warnings
#       -->[x]closing with changes but no commiting
#   [0] Functions 
#       -->[x]saveData()
#       -->[]searchData ()
#       -->[]addData ()
#       -->[]onclosing ()
#       -->[]deleteData()
#   [x] change size of table
#   [0] darkmode 
#   [0] strings extra for cur.execute()
#   [x] add real data
#   [] clean code
#       -->[0]add comments 
#   []dropdown menu for fi data 
#   [] dataChangedAdd
########################################################################

import tkinter as tk
from tkinter import *
from tkinter import messagebox
import psycopg2
import tksheet
import math

tables=[]
sheets = []
buttons = []
entryList = []
tkeyName = None
label1= None
button3=None
button5 =None
addWindow = None
dataChanged = False
dataChangedAdd = False


def get_oneTable(name):
    columns=[]
    newdata = []
    global sheets
    global tkeyName
    tkeyName = name
    global label1
    global button3
    global button5
    delete_tables()
    #label for tablename
    label1 = tk.Label(window, text=name)
    label1.grid(row=3, column=0, sticky="nsew")
    #get columnnames from database
    cur.execute("Select * FROM "+ name +" LIMIT 0")
    columnLength= cur.description
    for i in range(len(columnLength)):
        columns.append(columnLength[i][0])
    #get data from table
    cur.execute("SELECT * FROM " + name)
    data = cur.fetchall()
    #save them in the sheet
    for i in data:
        newdata.append(list(i))
    sheets.append(tksheet.Sheet(window, data=newdata,enable_edit_cell_auto_resize = True, auto_resize_default_row_index = True))
    sheets[-1].enable_bindings(("single_select", "row_select", "column_width_resize","arrowkeys","right_click_popup_menu","rc_select", "rc_insert_row","rc_delete_row", "copy", "cut", "paste", "delete","undo","edit_cell"))
    sheets[-1].grid(row=4,column=0, rowspan=20, columnspan=9, sticky="nsew")
    sheets[-1].headers(columns)
    sheets[-1].extra_bindings([("end_edit_cell", cell_editedOne)])
    #add commit-button
    button3 = tk.Button(text="commit", bg="#262626", fg="white", font=("Arial", 12), command=save_data)
    button3.grid(row=3,column=1,  sticky= "nsew")
    #add add-button
    button5 = tk.Button(text="add", bg="#262626", fg="green", font=("Arial", 12), command=add_data)
    button5.grid(row=3,column=2,  sticky= "nsew")


def cell_editedOne(event):
    global dataChanged
    old_value = sheets[-1].get_cell_data(event[0], event[1])
    changedData = event[3]
    columnsName = sheets[-1].get_sheet_data(return_copy = False, get_header = True, get_index = False)[event[1]]
    #check if data is a foreign key
    if "fi_" in columnsName:
        try:
            idName = sheets[-1].get_sheet_data(return_copy = False, get_header = True, get_index = False)[0]
            idWert = sheets[-1].get_cell_data(event[0], 0, return_copy = True)
            cur.execute("UPDATE " + tkeyName + " SET " + columnsName + " = " + "'"+changedData +"'"+ " WHERE " + idName + " = " + "'"+idWert+"'")
            dataChanged = True
        except(Exception, psycopg2.Error):
            messagebox.showwarning("ACHTUNG", message=("Es gibt keinen passenden Primary Key"))
            dataChanged = False
        #data has to change back or database will break
    else:
        idName = sheets[-1].get_sheet_data(return_copy = False, get_header = True, get_index = False)[0]
        idWert = sheets[-1].get_cell_data(event[0], 0, return_copy = True)
        cur.execute("UPDATE " + tkeyName + " SET " + columnsName + " = " + "'"+changedData +"'"+ " WHERE " + idName + " = " + "'"+idWert+"'")
        dataChanged = True


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


def on_closing():
    global dataChanged
    if dataChanged:
        if messagebox.askokcancel("Beenden", "Möchten Sie das Programm wirklich beenden? Es gibt noch uncommittete Änderungen!"):
            window.destroy()
            cur.close()
            conn.close()
    else:
        window.destroy()
        cur.close()
        conn.close()


def on_closing2():
    global dataChangedAdd
    global addWindow
    if dataChangedAdd:
        if messagebox.askokcancel("Beenden", "Möchten Sie das Programm wirklich beenden? Es gibt noch uncommittete Änderungen!"):
            addWindow.destroy()
    else:
        addWindow.destroy()


def save_data():
    global dataChanged
    conn.commit()
    dataChanged = False


def commitAdd(events):
    global tkeyName
    values = []
    print(range(len(events)))
    if(range(len(events))!= 0):
        for i in range(len(events)):
            values.append(events[i].get())
        stringSQL = "INSERT INTO "
        stringSQL += tkeyName
        stringSQL += " VALUES ("
        for i in values:
            stringSQL += "'"
            stringSQL += i
            stringSQL += "'"
            stringSQL += ","
        stringSQL = stringSQL[:-1]
        stringSQL += ")"
        print(stringSQL)
        cur.execute(stringSQL)
        save_data() 
        get_oneTable(tkeyName)
        for i in range(len(events)):
            events[i].delete(0, END)


def add_data():
    global tkeyName
    global entryList
    global addWindow
    columnNames = []
    columnLabels=[]
    values = None
    addWindow = tk.Tk()
    addWindow.title("adding Data")
    addWindow.config(padx=50, pady=50)
    addWindow.config(bg="#2d2d2d")
    #addWindow.geometry("500x100")
    tableLable = tk.Label(addWindow, text=tkeyName)
    tableLable.grid(row=0, column=0, sticky="nsew")
    #columnnames
    cur.execute("Select * FROM "+ tkeyName +" LIMIT 0")
    columnLength= cur.description
    for i in range(len(columnLength)):
        columnNames.append(columnLength[i][0])
    #label and entrys  for each column
    for i in range(len(columnNames)):
        columnLabels.append(tk.Label(addWindow, text=columnNames[i]))
        columnLabels[i].grid(row=1,column=i, sticky="nsew")
        entryList.append(tk.Entry(addWindow))
        entryList[i].grid(row=2,column=i, sticky="nsew")
    #button  to commit
    buttonCommit = tk.Button(addWindow, text="commit", bg="#262626", fg="white", font=("Arial", 12),command=lambda n = entryList: commitAdd(n))
    buttonCommit.grid(row=0,column=1, sticky="nsew")
    #warning message
    window.protocol("WM_DELETE_WINDOW", on_closing2)
    addWindow.mainloop()


def delete_data():
    print("in Arbeit")


window = tk.Tk()
#space between buttons and tables
window.grid_rowconfigure(2, minsize=30)
window.title("WAB3_DB")
window.config(padx=50, pady=50)
window.config(bg="#2d2d2d")
window.geometry("1000x800+300+300")
for i in range(10):
    window.grid_columnconfigure(i, weight=1)
window.grid_rowconfigure(5, weight=1)
#first sheet
sheetFirst=tksheet.Sheet(window)
sheetFirst.enable_bindings(("single_select", "row_select", "column_width_resize","arrowkeys","right_click_popup_menu","rc_select", "rc_insert_row","rc_delete_row", "copy", "cut", "paste", "delete","undo","edit_cell"))
sheetFirst.grid(row=4, column=0,rowspan=20,columnspan=9, sticky="nsew")

# Connect to the PostgreSQL database
conn = psycopg2.connect(database="wab3_db", user="postgres",password="R00t1", host="localhost", port="5432")
cur = conn.cursor()

#creates list of table names
cur.execute("""SELECT table_name FROM information_schema.tables WHERE table_schema = 'public'""")
tableNames = cur.fetchall()
tablesLength = len(tableNames)
for i in range(tablesLength):
    tables.append(tableNames[i][0])

############################BUTTONS############################
buttonSearch = tk.Button(text="search", bg="#262626", fg="white", font=("Arial", 12), command=search_data)
buttonSearch.grid(row=0,column=4,rowspan=2,  sticky= "nsew")
buttonDelete = tk.Button(text="show nothing", bg="#262626", fg="white", font=("Arial", 12), command=delete_tables)
buttonDelete.grid(row=0,column=5, rowspan= 2,  sticky= "nsew")
#Tablebuttons
for i in tables:
    button = tk.Button(text=i, bg="#262626", fg="white", font=("Arial", 12), command=lambda n=i: get_oneTable(n))
    buttons.append(button)
for i in range(len(buttons)):
    if i <4:
        buttons[i].grid(row=math.floor(i/2),column=i%2, sticky= "nsew")
    else:
        buttons[i].grid(row=math.floor(i/2)-2,column=(i%2)+2, sticky= "nsew")
##############################################################
#check if there is non commited data
window.protocol("WM_DELETE_WINDOW", on_closing)

window.mainloop()
# Close the database connection when the program exits
cur.close()
conn.close()