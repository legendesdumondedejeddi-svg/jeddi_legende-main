from flask import Flask, render_template_string, send_from_directory
import os

app = Flask(__name__, static_folder='.', template_folder='.')

# --- ROUTES PRINCIPALES ---

@app.route('/')
def accueil():
    return render_template_string(open("accueil.html", encoding="utf-8").read())

@app.route('/about')
def about():
    return render_template_string(open("about.html", encoding="utf-8").read())

@app.route('/don')
def don():
    return render_template_string(open("don.html", encoding="utf-8").read())

@app.route('/jeddi')
def jeddi():
    return render_template_string(open("jeddi.html", encoding="utf-8").read())

@app.route('/legendes')
def legendes():
    return render_template_string(open("legendes.html", encoding="utf-8").read())

# --- SERVIR LE CSS ---

@app.route('/<path:filename>')
def static_files(filename):
    if os.path.exists(filename):
        return send_from_directory('.', filename)
    return "Fichier non trouvé", 404

# --- DÉMARRAGE LOCAL ---

if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host="0.0.0.0", port=port)
