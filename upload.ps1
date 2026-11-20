$ErrorActionPreference = "Stop"

git add .

$changes = git status --porcelain

if (-not $changes) {
    Write-Host "No changes to upload." -ForegroundColor Yellow
    exit
}

$commitMessage = "Update portfolio - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"

git commit -m $commitMessage

git pull --rebase origin main

if ($LASTEXITCODE -ne 0) {
    Write-Host "Pull failed. Resolve conflicts before pushing." -ForegroundColor Red
    exit 1
}

git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host "Successfully uploaded to GitHub!" -ForegroundColor Green
}