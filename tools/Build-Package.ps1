$ErrorActionPreference = 'Stop'
$workshopRoot = [IO.Path]::GetFullPath((Split-Path -Parent $PSScriptRoot))
$destination = Join-Path (Split-Path -Parent $workshopRoot) 'secret-squares.zip'
$names = @('index.html','workshop-asl.html','assets','vendor','tools','tests','README.md','SCIENCE.md','THIRD-PARTY.md','LICENSE','LICENSE-CONTENT.md','Launch.cmd','Serve.cmd','.gitignore')
$paths = $names | ForEach-Object { Join-Path $workshopRoot $_ } | Where-Object { Test-Path -LiteralPath $_ }
Compress-Archive -LiteralPath $paths -DestinationPath $destination -Force
Write-Host "Portable package: $destination"
