from flask import Flask, render_template

app = Flask(__name__)

# Liste des langues et des pages
langs = ["fr", "en", "it", "de", "es"]
pages = ["accueil", "about", "jeddi", "legendes", "don"]

# Création automatique des routes
for lang in langs:
    for page in pages:
        # Route spéciale pour l'accueil
        route = f"/{lang}/" if page == "accueil" else f"/{lang}/{page}"

        # Fonction lambda correcte pour capturer les variables
        def make_route(p=page, l=lang):
            def route_func():
                return render_template(f"{p}_{l}.html")
            return route_func

        app.add_url_rule(route, f"{page}_{lang}", make_route())

# Route par défaut pour la racine
@app.route("/")
def index():
    return render_template("accueil_fr.html")
@app.route('/jeddi')
def jeddi_fr():
    return render_template('jeddi_fr.html')
if __name__ == "__main__":
    app.run(debug=True)
