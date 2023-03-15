from flask import Flask, render_template, request
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:R00t1@localhost/wab3_db'
db = SQLAlchemy(app)

class Location(db.Model):
    __tablename__ = 'tkey_location'
    id_city = db.Column(db.String(50), primary_key=True)
    ds_country = db.Column(db.String(50))
    ds_building = db.Column(db.String(50))

class Rack(db.Model):
    __tablename__ = 'tkey_rack'
    id_number = db.Column(db.String(50), primary_key=True)
    fi_location = db.Column(db.String(50), db.ForeignKey('tkey_location.id_city'))

class UsbHub(db.Model):
    __tablename__ = 'tkey_usbHub'
    id_id = db.Column(db.String(50), primary_key=True)
    ds_btMac = db.Column(db.String(50))
    fi_rackNumber = db.Column(db.String(50), db.ForeignKey('tkey_rack.id_number'))

class Server(db.Model):
    __tablename__ = 'tkey_server'
    id_ipAddress = db.Column(db.String(50), primary_key=True)
    ds_name = db.Column(db.Text)
    ds_labOrTest = db.Column(db.String(50))
    fi_rackNumber = db.Column(db.String(50), db.ForeignKey('tkey_rack.id_number'))

class Schirmbox(db.Model):
    __tablename__ = 'tkey_schirmbox'
    id_schirmboxName = db.Column(db.Text, primary_key=True)
    ds_btMac = db.Column(db.String(50))
    fi_rackNumber = db.Column(db.String(50), db.ForeignKey('tkey_rack.id_number'))

class HeRack(db.Model):
    __tablename__ = 'tkey_heRack'
    id_id = db.Column(db.Integer, primary_key=True)
    dn_he = db.Column(db.Integer)
    fi_ipAddress = db.Column(db.String(50), db.ForeignKey('tkey_server.id_ipAddress'))
    fi_schirmboxName = db.Column(db.Text, db.ForeignKey('tkey_schirmbox.id_schirmboxName'))
    fi_rack = db.Column(db.String(50), db.ForeignKey('tkey_rack.id_number'))

class Device(db.Model):
    __tablename__ = 'tkey_device'
    id_androidID = db.Column(db.String(50), primary_key=True)
    ds_model = db.Column(db.String(50))
    ds_msisdn = db.Column(db.String(50))
    ds_imei = db.Column(db.String(50))
    ds_btMac = db.Column(db.String(50))
    dy_batteryProj = db.Column(db.Boolean)
    dn_usbPort = db.Column(db.Integer)
    fi_ipAddress = db.Column(db.String(50), db.ForeignKey('tkey_server.id_ipAddress'))
    fi_schirmboxName = db.Column(db.Text, db.ForeignKey('tkey_schirmbox.id_schirmboxName'))

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        search_term = request.form['search_term']
        results = search(search_term)
        return render_template('results.html', results=results)
    else:
        return render_template('results.html')

def search(search_term):
    results = []
    # Search for data using SQLAlchemy query syntax
    # Here's an example for searching for data in the Location table
    locations = Location.query.filter(Location.ds_country.ilike(f'%{search_term}%') | Location.ds_building.ilike(f'%{search_term}%'))
    for location in locations:
        results.append({'type': 'Location', 'id': location.id_city, 'country': location.ds_country, 'building': location.ds_building})
    return results
