import psycopg2
import tkinter as tk

# Connect to the PostgreSQL database
conn = psycopg2.connect(database="wab3_db", user="postgres", password="R00t1", host="localhost", port="5432")
cur = conn.cursor()

# Create the main window
root = tk.Tk()
root.title("DB_WAB_3")
root.configure(bg='#242424')

# Create a label for the headline
headline = tk.Label(root, text="DB_WAB_3", font=("Arial", 20), fg="white", bg="#242424")
headline.pack(pady=10)

# Create a frame to hold the buttons and text widget
frame = tk.Frame(root, bg='#242424')
frame.pack()

# Create a Text widget to display the data
text_widget = tk.Text(frame, bg="white", fg="black", font=("Arial", 10), height=20, width=80)
text_widget.pack(side="right", padx=10)

# Create a function to handle button clicks
def display_table_data(table_name):
    # Retrieve the data for the table from the database
    cur.execute(f"SELECT * FROM {table_name}")
    data = cur.fetchall()
    
    # Get the attribute names
    cur.execute(f"SELECT column_name FROM information_schema.columns WHERE table_name = '{table_name}'")
    attribute_names = [name[0] for name in cur.fetchall()]
    
    # Display the data in the text widget
    text_widget.delete("1.0", tk.END)
    text_widget.insert(tk.END, f"{table_name.upper()}\n\n")
    for row in data:
        for i in range(len(attribute_names)):
            text_widget.insert(tk.END, f"{attribute_names[i]}: {row[i]}\n")
        text_widget.insert(tk.END, "\n")
        

# Create a button for each table
table_names = ["tkey_location", "tkey_rack", "tkey_usbHub", "tkey_server", "tkey_schirmbox", "tkey_heRack", "tkey_device"]
for name in table_names:
    button = tk.Button(frame, text=name, bg="#0277BD", fg="white", font=("Arial", 12), command=lambda n=name: display_table_data(n))
    button.pack(side="left", padx=5, pady=5)

# Start the main event loop
root.mainloop()

# Close the database connection when the program exits
cur.close()
conn.close()
