# Optional download for personal computing devices or classroom use.
# The chart remains copyright William Vicars / Lifeprint.com.
$ErrorActionPreference = 'Stop'
$workshopRoot = [IO.Path]::GetFullPath((Split-Path -Parent $PSScriptRoot))
$destination = Join-Path $workshopRoot 'assets/asl-chart.jpg'
$source = 'https://www.lifeprint.com/asl101/fingerspelling/images/signlanguageabc02.jpg'
Invoke-WebRequest -Uri $source -OutFile $destination
Write-Host "Saved hand-position reference: $destination"
Write-Host 'Copyright William Vicars. Credit and permissions: https://www.lifeprint.com/asl101/fingerspelling/abc-fingerspelling-charts.htm'
Write-Host 'This chart is not MIT or CC BY licensed. Review its terms before redistribution.'
