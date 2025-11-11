# make_jeddi_package.ps1
# Génère toutes les pages HTML pour Jeddi Legende

# Dossier des pages
$baseFolder = Get-Location

# Langues et pages
$langs = @("fr", "en", "es", "de", "it")
$pages = @("accueil", "jeddi", "legendes", "galerie", "don")

# Texte de base pour chaque page et langue
$texts = @{
    "accueil" = @{
        "fr" = "Bienvenue dans le Monde de Jeddi"
        "en" = "Welcome to the World of Jeddi"
        "es" = "Bienvenido al Mundo de Jeddi"
        "de" = "Willkommen in der Welt von Jeddi"
        "it" = "Benvenuti nel Mondo di Jeddi"
    }
    "jeddi" = @{
        "fr" = "La légende de Jeddi"
        "en" = "The Legend of Jeddi"
        "es" = "La leyenda de Jeddi"
        "de" = "Die Legende von Jeddi"
        "it" = "La leggenda di Jeddi"
    }
    "legendes" = @{
        "fr" = "Écrivez vos légendes ici (admin uniquement)"
        "en" = "Write your legends here (admin only)"
        "es" = "Escribe tus leyendas aquí (solo admin)"
        "de" = "Schreiben Sie hier Ihre Legenden (nur Admin)"
        "it" = "Scrivi qui le tue leggende (solo admin)"
    }
    "galerie" = @{
        "fr" = "Galerie des Créatures"
        "en" = "Creatures Gallery"
        "es" = "Galería de Criaturas"
        "de" = "Galerie der Kreaturen"
        "it" = "Galleria delle Creature"
    }
    "don" = @{
        "fr" = "Faites un don"
        "en" = "Make a donation"
        "es" = "Haz una donación"
        "de" = "Spenden"
        "it" = "Fai una donazione"
    }
}

# Menu global
$menu = @("Accueil", "Jeddi", "Légendes", "Galerie", "Don")

# Fonction pour créer chaque page
function Create-HTMLPage {
    param(
        [string]$page,
        [string]$lang,
        [string]$text
    )

    $filename = "$($page)_$($lang).html"
    $filepath = Join-Path $baseFolder $filename

    $htmlContent = @"
<!DOCTYPE html>
<html lang="$lang">
<head>
    <meta charset="UTF-8">
    <title>$text</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f0f0f0; margin:0; padding:0;}
        header { background-color: #8B0000; color: white; padding: 10px;}
        nav a { margin: 0 10px; color: white; text-decoration: none; font-weight: bold;}
        footer { background-color: #222; color: white; text-align: center; padding: 10px; position: relative;}
        .licorne { position: fixed; bottom: 0; left: 0; width: 150px; animation: move 10s linear infinite;}
        @keyframes move { 0% {left:0;} 50% {left:80%;} 100% {left:0;} }
        .content { padding: 20px; min-height: 80vh; background-image: url('grimoire.jpg'); background-size: cover; }
        h1 { color: #8B0000;}
        textarea { width: 100%; height: 200px; }
        button { padding: 10px 20px; background-color: #8B0000; color: white; border: none; cursor: pointer; }
    </style>
</head>
<body>
<header>
    <nav>
        <a href="accueil_$lang.html">Accueil</a>
        <a href="jeddi_$lang.html">Jeddi</a>
        <a href="legendes_$lang.html">Légendes</a>
        <a href="galerie_$lang.html">Galerie</a>
        <a href="don_$lang.html">Don</a>
    </nav>
</header>
<div class="content">
    <h1>$text</h1>
    <!-- Page spécifique -->
"@

    if ($page -eq "legendes") {
        $htmlContent += @"
    <form method='POST'>
        <textarea placeholder='Écrivez ici vos légendes (admin)'></textarea><br>
        <button type='submit'>Enregistrer</button>
    </form>
"@
    }

    if ($page -eq "don") {
        $htmlContent += @"
    <p>Vous pouvez faire un don via PayPal.</p>
    <form action='https://www.paypal.com/donate' method='post' target='_blank'>
        <input type='hidden' name='hosted_button_id' value='TON_CODE_PAYPAL'>
        <button type='submit'>Donner</button>
    </form>
"@
    }

    $htmlContent += @"
</div>
<img src='licorne.gif' class='licorne' alt='Licorne'>
<footer>© 2025 Monde de Jeddi</footer>
</body>
</html>
"@

    # Écrire le fichier
    Set-Content -Path $filepath -Value $htmlContent -Encoding UTF8
    Write-Host "Page créée : $filename"
}

# Boucle pour toutes les langues et pages
foreach ($lang in $langs) {
    foreach ($page in $pages) {
        Create-HTMLPage -page $page -lang $lang -text $texts[$page][$lang]
    }
}

Write-Host "`nToutes les pages HTML ont été générées !"
