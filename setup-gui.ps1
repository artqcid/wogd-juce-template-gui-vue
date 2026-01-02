#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Setup script for WOGD JUCE Template GUI
.DESCRIPTION
    Configures the GUI project name and metadata for a new plugin GUI.
    This script is designed to be run after creating a project from the template.
#>

Write-Host "`n🎨 WOGD JUCE Template GUI Setup`n" -ForegroundColor Cyan

# Prompt for GUI name
$guiName = Read-Host "Enter GUI project name (e.g., 'MyPlugin GUI')"
if ([string]::IsNullOrWhiteSpace($guiName)) {
    Write-Host "❌ GUI name cannot be empty!" -ForegroundColor Red
    exit 1
}

# Prompt for package name (npm-compatible)
$defaultPackageName = $guiName.ToLower() -replace '\s+', '-' -replace '[^a-z0-9-]', ''
$packageName = Read-Host "Enter npm package name (default: $defaultPackageName)"
if ([string]::IsNullOrWhiteSpace($packageName)) {
    $packageName = $defaultPackageName
}

# Prompt for description
$defaultDescription = "Vue.js GUI for $guiName"
$description = Read-Host "Enter project description (default: $defaultDescription)"
if ([string]::IsNullOrWhiteSpace($description)) {
    $description = $defaultDescription
}

Write-Host "`n📝 Configuration:" -ForegroundColor Yellow
Write-Host "  GUI Name: $guiName"
Write-Host "  Package Name: $packageName"
Write-Host "  Description: $description"

$confirm = Read-Host "`nProceed with setup? (y/n)"
if ($confirm -ne 'y') {
    Write-Host "Setup cancelled." -ForegroundColor Yellow
    exit 0
}

Write-Host "`n🔧 Updating project files..." -ForegroundColor Cyan

# Update package.json
Write-Host "  ✓ Updating package.json" -ForegroundColor Green
$packageJsonPath = "package.json"
if (Test-Path $packageJsonPath) {
    $packageJson = Get-Content $packageJsonPath -Raw | ConvertFrom-Json
    $packageJson.name = $packageName
    $packageJson.description = $description
    $packageJson.version = "0.0.1"
    $packageJson | ConvertTo-Json -Depth 10 | Set-Content $packageJsonPath
}

# Update index.html
Write-Host "  ✓ Updating index.html" -ForegroundColor Green
$indexHtmlPath = "index.html"
if (Test-Path $indexHtmlPath) {
    $indexHtml = Get-Content $indexHtmlPath -Raw
    $indexHtml = $indexHtml -replace '<title>.*?</title>', "<title>$guiName</title>"
    $indexHtml | Set-Content $indexHtmlPath
}

# Update README.md
Write-Host "  ✓ Updating README.md" -ForegroundColor Green
$readmePath = "README.md"
if (Test-Path $readmePath) {
    $readme = Get-Content $readmePath -Raw
    $readme = $readme -replace 'WOGD JUCE Template GUI', $guiName
    $readme = $readme -replace 'wogd-juce-template-gui', $packageName
    $readme | Set-Content $readmePath
}

# Commit changes
Write-Host "`n📦 Committing changes..." -ForegroundColor Cyan
git add package.json index.html README.md
git commit -m "Configure project: $guiName"

Write-Host "`n✅ Setup complete!`n" -ForegroundColor Green
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Install dependencies: npm install"
Write-Host "  2. Start dev server: npm run dev"
Write-Host "  3. Push changes: git push"
Write-Host "`nYour GUI is ready for development! 🎉`n"
