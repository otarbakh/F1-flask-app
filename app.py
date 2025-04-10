from flask import Flask, render_template
import requests

app = Flask(__name__)

@app.route('/')
def home():
    # Fetch live driver standings from the Ergast API
    standings = get_driver_standings()
    return render_template('index.html', standings=standings)

def get_driver_standings():
    url = "https://ergast.com/api/f1/current/driverStandings.json"
    response = requests.get(url)
    data = response.json()

    standings = []
    for driver in data['MRData']['StandingsTable']['StandingsLists'][0]['DriverStandings']:
        driver_info = {
            "position": driver['position'],
            "name": f"{driver['Driver']['givenName']} {driver['Driver']['familyName']}",
            "constructor": driver['Constructors'][0]['name'],
            "points": driver['points']
        }
        standings.append(driver_info)
    
    return standings

if __name__ == '__main__':
    app.run(debug=True)
