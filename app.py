# app.py
from flask import Flask, render_template, request, redirect, url_for, flash, session
import os

app = Flask(__name__)
app.secret_key = "jeddi_secret_key_2025"  # Clé secrète pour la session admin

# Langues et pages
langs = ["fr", "en", "es", "de", "it"]
pages = ["accueil", "jeddi", "legendes", "galerie", "don"]

# Mot de passe admin pour écrire les légendes
ADMIN_PASSWORD = "1997.Monde-1958-Jeddi.1998"

# Vérification si le dossier "legendes" existe
if not os.path.exists("legendes_textes"):
    os.makedirs("legendes_textes")

# Fonction pour lire le texte d'une légende
def read_legend(lang):
    filepath = f"legendes_textes/legend_{lang}.txt"
    if os.path.exists(filepath):
        with open(filepath, "r", encoding="utf-8") as f:
            return f.read()
    return ""

# Fonction pour sauvegarder le texte d'une légende
def save_legend(lang, text):
    filepath = f"legendes_textes/legend_{lang}.txt"
    with open(filepath, "w", encoding="utf-8") as f:
        f.write(text)

# Création dynamique des routes pour toutes les pages sauf légendes et don
for lang in langs:
    for page in pages:
        if page in ["legendes", "don"]:
            continue
        route = f"/{lang}/" if page == "accueil" else f"/{lang}/{page}"
        template_file = f"{page}_{lang}.html"

        def make_route(template_file=template_file):
            def route_func():
                return render_template(template_file)
            return route_func

        endpoint_name = f"{page}_{lang}"
        app.add_url_rule(route, endpoint_name, make_route())

# Page légendes avec admin
@app.route("/<lang>/legendes", methods=["GET", "POST"])
def legendes(lang):
    if lang not in langs:
        return "Langue inconnue", 404

    legend_text = read_legend(lang)

    if request.method == "POST":
        password = request.form.get("password")
        if password == ADMIN_PASSWORD:
            session["admin"] = True
            new_text = request.form.get("legend_text")
            save_legend(lang, new_text)
            flash("Légende enregistrée avec succès !")
            return redirect(url_for("legendes", lang=lang))
        else:
            flash("Mot de passe incorrect")

    is_admin = session.get("admin", False)
    return render_template(f"legendes_{lang}.html", legend_text=legend_text, admin=is_admin)

# Page don
@app.route("/<lang>/don", methods=["GET"])
def don(lang):
    if lang not in langs:
        return "Langue inconnue", 404
    return render_template(f"don_{lang}.html")

# Route racine (redirection vers français)
@app.route("/")
def index():
    return redirect("/fr/")

if __name__ == "__main__":
    app.run(debug=True)
