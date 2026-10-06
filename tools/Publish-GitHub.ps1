# Explicit destination. Run this helper only when you want to publish this project.
$ErrorActionPreference = 'Stop'
$workshopRoot = Split-Path -Parent $PSScriptRoot
Set-Location -LiteralPath $workshopRoot
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { throw 'Git is required.' }
if (-not (Test-Path -LiteralPath (Join-Path $workshopRoot '.git'))) {
    git init -b main
    if ($LASTEXITCODE -ne 0) { throw 'Git initialization failed.' }
    git remote add origin https://github.com/caeled/secret-squares.git
    git fetch origin main
    if ($LASTEXITCODE -ne 0) { throw 'Could not read the remote repository. Check internet access and your Git login.' }
    # Adopt remote history while preserving the downloaded working files.
    git reset --mixed FETCH_HEAD
    if ($LASTEXITCODE -ne 0) { throw 'Could not adopt remote history.' }
}
$remoteUrl = git remote get-url origin
if ($LASTEXITCODE -ne 0 -or $remoteUrl -notmatch '^https://github.com/caeled/secret-squares(?:\.git)?$') { throw "Unexpected origin: $remoteUrl. Review it before publishing." }
git add .
git diff --cached --quiet
if ($LASTEXITCODE -eq 1) {
    git commit -m 'Update portable Secret Squares workshop'
    if ($LASTEXITCODE -ne 0) { throw 'Commit failed. Check Git name and email settings.' }
} elseif ($LASTEXITCODE -ne 0) { throw 'Could not inspect staged changes.' }
git push -u origin main
if ($LASTEXITCODE -ne 0) { throw 'Publishing failed. No login or permission settings were changed.' }
Write-Host 'Project: https://github.com/caeled/secret-squares'
