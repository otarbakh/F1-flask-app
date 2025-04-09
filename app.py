from flask import Flask, render_template
import requests

app = Flask(__name__)

@app.route('/')
def index():
    # For simplicity, we'll hard-code some sample data for Formula 1
    drivers = [
        {'name': 'Lewis Hamilton', 'team': 'Mercedes', 'position': 1},
        {'name': 'Max Verstappen', 'team': 'Red Bull Racing', 'position': 2},
        {'name': 'Charles Leclerc', 'team': 'Ferrari', 'position': 3},
    ]
    return render_template('index.html', drivers=drivers)

if __name__ == '__main__':
    app.run(debug=True)
