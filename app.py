from flask import Flask, render_template

app = Flask(__name__)

<<<<<<< HEAD
@app.route('/')
def accueil():
    return render_template('accueil_fr.html')

@app.route('/about')
def about():
    return render_template('about_fr.html')

@app.route('/don')
def don():
    return render_template('don_fr.html')

@app.route('/jeddi')
def jeddi():
    return render_template('jeddi_fr.html')

@app.route('/legendes')
def legendes():
    return render_template('legendes_fr.html')

=======
# Page d'accueil
@app.route('/')
def accueil():
    return render_template("accueil.html")

# Page À propos
@app.route('/about')
def about():
    return render_template("about.html")

# Page Faire un don
@app.route('/don')
def don():
    return render_template("don.html")

# Page Jeddi
@app.route('/jeddi')
def jeddi():
    return render_template("jeddi.html")

# Page Légendes
@app.route('/legendes')
def legendes():
    return render_template("legendes.html")

# Lancer le serveur en mode debug (pratique pour tester localement)
>>>>>>> 8aa0d5d6972364103d37df6ab050f2dddd47e639
if __name__ == '__main__':
    app.run(debug=True)
