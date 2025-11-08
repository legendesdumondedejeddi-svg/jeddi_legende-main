from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def accueil():
    return render_template("accueil.html")

@app.route("/about")
def about():
    return render_template("about.html")

@app.route("/don")
def don():
    return render_template("don.html")

@app.route("/jeddi")
def jeddi():
    return render_template("jeddi.html")

@app.route("/legendes")
def legendes():
    return render_template("legendes.html")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=10000)
