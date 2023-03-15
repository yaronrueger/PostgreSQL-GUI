from flask import Flask, render_template, request
import psycopg2

app = Flask(__name__)

# Connect to the database
conn = psycopg2.connect(
    dbname="wab3_db",
    user="postgres",
    password="R00t1",
    host="localhost"
)

@app.route("/")
def index():
    # Fetch all rows from the tkey_device table
    cur = conn.cursor()
    cur.execute("SELECT * FROM tkey_location")
    rows = cur.fetchall()
    cur.close()

    return render_template("index.html", rows=rows)

@app.route("/add", methods=["POST"])
def add():
    print("OK1")
    # Add a new row to the tkey_device table
    if request.method == "POST":
        #android_id = request.form["android_id"]
        #model = request.form["model"]
        #msisdn = request.form["msisdn"]
        #imei = request.form["imei"]
        #bt_mac = request.form["bt_mac"]
        #battery_proj = request.form["battery_proj"]
        #usb_port = request.form["usb_port"]
        #ip_address = request.form["ip_address"]
        #schirmbox_name = request.form["schirmbox_name"]
        print("OK")
        city = request.form["Berlin"]
        country = request.form["Germany"]
        building = request.form["building1"]

        cur = conn.cursor()

        cur.execute("INSERT INTO tkey_location (id_city, ds_country, ds_building) VALUES (%s %s %s)", (city, country, building))
        #cur.execute(
        #    "INSERT INTO tkey_device (id_androidID, ds_model, ds_msisdn, ds_imei, ds_btMac, dy_batteryProj, dn_usbPort, fi_ipAddress, fi_schirmboxName) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)",
        #    (android_id, model, msisdn, imei, bt_mac, battery_proj, usb_port, ip_address, schirmbox_name)
        #)
        conn.commit()
        cur.close()

        return "Record added successfully!"
    else:
        return "Method not allowed for this URL"

@app.route("/edit", methods=["POST"])
def edit():
    # Update an existing row in the tkey_device table
    android_id = request.form["android_id"]
    model = request.form["model"]
    msisdn = request.form["msisdn"]
    imei = request.form["imei"]
    bt_mac = request.form["bt_mac"]
    battery_proj = request.form["battery_proj"]
    usb_port = request.form["usb_port"]
    ip_address = request.form["ip_address"]
    schirmbox_name = request.form["schirmbox_name"]

    cur = conn.cursor()
    cur.execute(
        "UPDATE tkey_device SET ds_model=%s, ds_msisdn=%s, ds_imei=%s, ds_btMac=%s, dy_batteryProj=%s, dn_usbPort=%s, fi_ipAddress=%s, fi_schirmboxName=%s WHERE id_androidID=%s",
        (model, msisdn, imei, bt_mac, battery_proj, usb_port, ip_address, schirmbox_name, android_id)
    )
    conn.commit()
    cur.close()

    return "Record updated successfully!"

@app.route("/delete", methods=["POST"])
def delete():
    # Delete a row from the tkey_device table
    android_id = request.form["android_id"]

    cur = conn.cursor()
    cur.execute("DELETE FROM tkey_device WHERE id_androidID=%s", (android_id,))
    conn.commit()
    cur.close()

    return "Record deleted successfully!"

if __name__ == "__main__":
    app.run(debug=True)
