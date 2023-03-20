from flask import Flask, render_template
import psycopg2

app = Flask(__name__)

# Update the connection details to match your database
conn = psycopg2.connect(
    dbname="wab3_db",
    user="postgres",
    password="R00t1",
    host="localhost",
    port="5432"
)

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
