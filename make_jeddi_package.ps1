# ============================
# 🌠 Script de création du projet : Légendes du Monde de Jeddi
# ============================

# Nom du dossier principal
$project = "jeddi_legende-main"

Write-Host "✨ Création du projet '$project'..."

# Création de la structure des dossiers
New-Item -ItemType Directory -Force -Path "$project"
New-Item -ItemType Directory -Force -Path "$project\templates"
New-Item -ItemType Directory -Force -Path "$project\static\images"
New-Item -ItemType Directory -Force -Path "$project\static\css"
New-Item -ItemType Directory -Force -Path "$project\legendes"

# ============================
# 📜 Création du fichier app.py
# ============================
$appCode = @'
from flask import Flask, render_template, request, redirect, url_for, flash
import os

app = Flask(__name__)
app.secret_key = "JeddiSecretKey987"
ADMIN_PASSWORD = "1997.Monde-1958-Jeddi.1998"
LANGS = ["fr", "en", "es", "de", "it"]

SAVE_FOLDER = "legendes"
os.makedirs(SAVE_FOLDER, exist_ok=True)

def load_legend(lang):
    filepath = os.path.join(SAVE_FOLDER, f"legende_{lang}.txt")
    if os.path.exists(filepath):
        with open(filepath, "r", encoding="utf-8") as f:
            return f.read()
    return ""

def save_legend(lang, text):
    filepath = os.path.join(SAVE_FOLDER, f"legende_{lang}.txt")
    with open(filepath, "w", encoding="utf-8") as f:
        f.write(text)

@app.route("/")
def index():
    return redirect("/fr/accueil")

PAGES = ["accueil", "jeddi", "galerie", "don"]

for lang in LANGS:
    for page in PAGES:
        route = f"/{lang}/{page}"
        def make_page_route(p=page, l=lang):
            def route_func():
                return render_template(f"{p}_{l}.html")
            return route_func
        app.add_url_rule(route, f"{page}_{lang}", make_page_route())

@app.route("/<lang>/legendes", methods=["GET", "POST"])
def legendes(lang):
    if lang not in LANGS:
        return redirect("/fr/legendes")

    legend_text = load_legend(lang)

    if request.method == "POST":
        text = request.form.get("legend_text", "").strip()
        password = request.form.get("password", "")

        if password == ADMIN_PASSWORD:
            save_legend(lang, text)
            flash("✅ Légende enregistrée avec succès.")
            legend_text = text
        else:
            flash("❌ Mot de passe incorrect.")

    return render_template(f"legendes_{lang}.html", legend_text=legend_text)

if __name__ == "__main__":
    app.run(debug=True)
'@

Set-Content -Path "$project\app.py" -Value $appCode -Encoding UTF8

# ============================
# 📦 Fichier requirements.txt
# ============================
$requirements = @'
Flask==3.0.3
gunicorn
'@
Set-Content -Path "$project\requirements.txt" -Value $requirements -Encoding UTF8

# ============================
# 🎨 Fichier style.css
# ============================
$style = @'
body {
    background-color: #f8f5f2;
    font-family: "Georgia", serif;
    color: #222;
    margin: 0;
    padding: 0;
    text-align: center;
}
header {
    background-color: #3a2d2d;
    color: #fff;
    padding: 1em;
}
nav a {
    color: #fff;
    margin: 0 10px;
    text-decoration: none;
}
footer {
    background-color: #3a2d2d;
    color: white;
    text-align: center;
    padding: 1em;
    position: fixed;
    bottom: 0;
    width: 100%;
}
.licorne {
    width: 150px;
    position: fixed;
    bottom: 10px;
    right: 10px;
    animation: courir 8s linear infinite;
}
@keyframes courir {
    0% { right: -150px; }
    100% { right: 100%; }
}
'@
Set-Content -Path "$project\static\css\style.css" -Value $style -Encoding UTF8

# ============================
# 📃 Création des fichiers HTML pour 5 langues
# ============================
$languages = @("fr", "en", "es", "de", "it")
foreach ($lang in $languages) {
    # Accueil
    Set-Content "$project\templates\accueil_$lang.html" "<!DOCTYPE html>
<html lang='$lang'>
<head><meta charset='utf-8'><title>Accueil</title><link rel='stylesheet' href='/static/css/style.css'></head>
<body>
<header><h1>Légendes du Monde de Jeddi</h1>
<nav>
<a href='/$lang/accueil'>Accueil</a> |
<a href='/$lang/jeddi'>Jeddi</a> |
<a href='/$lang/galerie'>Galerie</a> |
<a href='/$lang/legendes'>Légendes</a> |
<a href='/$lang/don'>Don</a>
</nav></header>
<main><h2>Bienvenue dans Légendes du Monde de Jeddi</h2>
<p>Explorez les mondes anciens et les légendes oubliées...</p></main>
<footer>© 2025 Légendes du Monde de Jeddi</footer>
<img src='/static/images/licorne.gif' class='licorne'>
</body></html>"

    # Jeddi
    Set-Content "$project\templates\jeddi_$lang.html" "<!DOCTYPE html>
<html lang='$lang'>
<head><meta charset='utf-8'><title>Jeddi</title><link rel='stylesheet' href='/static/css/style.css'></head>
<body>
<header><h1>Jeddi — Le Gardien des Légendes</h1>
<nav>
<a href='/$lang/accueil'>Accueil</a> |
<a href='/$lang/jeddi'>Jeddi</a> |
<a href='/$lang/galerie'>Galerie</a> |
<a href='/$lang/legendes'>Légendes</a> |
<a href='/$lang/don'>Don</a>
</nav></header>
<main>
<p>Jeddi voyage à travers le temps pour préserver la mémoire des contes anciens.</p>
</main>
<footer>© 2025 Légendes du Monde de Jeddi</footer>
<img src='/static/images/licorne.gif' class='licorne'>
</body></html>"

    # Légendes
    Set-Content "$project\templates\legendes_$lang.html" "<!DOCTYPE html>
<html lang='$lang'>
<head><meta charset='utf-8'><title>Légendes</title><link rel='stylesheet' href='/static/css/style.css'></head>
<body>
<header><h1>Grimoire des Légendes</h1>
<nav>
<a href='/$lang/accueil'>Accueil</a> |
<a href='/$lang/jeddi'>Jeddi</a> |
<a href='/$lang/galerie'>Galerie</a> |
<a href='/$lang/legendes'>Légendes</a> |
<a href='/$lang/don'>Don</a>
</nav></header>
<main>
<form method='POST'>
<textarea name='legend_text' rows='10' cols='80' placeholder='Écris ta légende ici...'>{{ legend_text }}</textarea><br>
<input type='password' name='password' placeholder='Mot de passe administrateur'><br>
<button type='submit'>💾 Enregistrer</button>
</form>
</main>
<footer>© 2025 Légendes du Monde de Jeddi</footer>
<img src='/static/images/licorne.gif' class='licorne'>
</body></html>"

    # Galerie
    Set-Content "$project\templates\galerie_$lang.html" "<!DOCTYPE html>
<html lang='$lang'>
<head><meta charset='utf-8'><title>Galerie des Créatures</title><link rel='stylesheet' href='/static/css/style.css'></head>
<body>
<header><h1>Galerie des Créatures</h1>
<nav>
<a href='/$lang/accueil'>Accueil</a> |
<a href='/$lang/jeddi'>Jeddi</a> |
<a href='/$lang/galerie'>Galerie</a> |
<a href='/$lang/legendes'>Légendes</a> |
<a href='/$lang/don'>Don</a>
</nav></header>
<main><p>Explore les créatures mythiques du Monde de Jeddi.</p></main>
<footer>© 2025 Légendes du Monde de Jeddi</footer>
<img src='/static/images/licorne.gif' class='licorne'>
</body></html>"

    # Don
    Set-Content "$project\templates\don_$lang.html" "<!DOCTYPE html>
<html lang='$lang'>
<head><meta charset='utf-8'><title>Faire un Don</title><link rel='stylesheet' href='/static/css/style.css'></head>
<body>
<header><h1>Soutenez Légendes du Monde de Jeddi</h1></header>
<main><p>Merci de soutenir notre projet. Vos dons permettent de préserver les contes anciens.</p>
<form action='https://www.paypal.com/donate' method='post' target='_blank'>
<input type='hidden' name='business' value='ton-email-paypal@example.com'>
<input type='hidden' name='currency_code' value='EUR'>
<input type='submit' value='Faire un don via PayPal'>
</form></main>
<footer>© 2025 Légendes du Monde de Jeddi</footer>
<img src='/static/images/licorne.gif' class='licorne'>
</body></html>"
}

Write-Host "✅ Projet complet créé avec succès !"
Write-Host "👉 Dossier prêt : $project"
