$base = "$env:USERPROFILE\Desktop\jeddi_legende-main"
$zip = "$env:USERPROFILE\Desktop\jeddi_legende-main.zip"

if (Test-Path $base) { Remove-Item -Recurse -Force $base; Write-Host "🧹 Dossier supprimé" }
if (Test-Path $zip) { Remove-Item -Force $zip; Write-Host "🗑️ ZIP supprimé" }
Write-Host "✨ Nettoyage terminé. Prêt pour recommencer."
