from flask import Flask, render_template
import requests

app = Flask(__name__)

@app.route('/')
def index():
    url = "http://ergast.com/api/f1/current/driverStandings.json"
    res = requests.get(url).json()

    drivers = res['MRData']['StandingsTable']['StandingsLists'][0]['DriverStandings']
    return render_template("index.html", drivers=[{
        "position": d["position"],
        "givenName": d["Driver"]["givenName"],
        "familyName": d["Driver"]["familyName"],
        "points": d["points"]
    } for d in drivers])

if __name__ == '__main__':
    app.run(debug=True)
