param([string]$Dotnet = 'dotnet')
$ErrorActionPreference = 'Stop'
Set-Location $PSScriptRoot
& git submodule update --init --recursive
if ($LASTEXITCODE -ne 0) { throw 'Submodule initialization failed.' }
& $Dotnet build 'Plain Craft Launcher 2.sln' -c Release -v minimal
if ($LASTEXITCODE -ne 0) { throw 'Build failed.' }

$packageName = 'PCL-Download-Restored-2.99.0.1-r2'
$packageDir = Join-Path $PSScriptRoot ('dist/' + $packageName)
if (Test-Path $packageDir) { throw "Package directory already exists: $packageDir. Move it before rebuilding." }
New-Item -ItemType Directory -Path $packageDir -Force | Out-Null
$buildDir = Join-Path $PSScriptRoot 'Plain Craft Launcher 2/bin'
Copy-Item -LiteralPath (Join-Path $buildDir 'Plain Craft Launcher 2.exe') -Destination (Join-Path $packageDir 'PCL 下载恢复修改版.exe')
Copy-Item -LiteralPath (Join-Path $buildDir 'Plain Craft Launcher 2.exe.config') -Destination (Join-Path $packageDir 'PCL 下载恢复修改版.exe.config')
Get-ChildItem -LiteralPath $buildDir -Filter '*.dll' | Copy-Item -Destination $packageDir
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'LICENCE') -Destination $packageDir
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'RESTORED.md') -Destination (Join-Path $packageDir '使用说明.md')
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'VALIDATION.md') -Destination (Join-Path $packageDir '验证记录.md')
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'MICROSOFT-LOGIN.md') -Destination (Join-Path $packageDir '微软登录配置.md')
$commit = & git rev-parse HEAD
$coreCommit = & git -C MeloongCore rev-parse HEAD
@("Source: https://github.com/arknights8037/PCL", "Commit: $commit", "MeloongCore: $coreCommit", 'Configuration: Release / net48') | Set-Content -LiteralPath (Join-Path $packageDir 'BUILD.txt') -Encoding UTF8
Get-ChildItem -LiteralPath $packageDir -File | Sort-Object Name | ForEach-Object {
    '{0}  {1}' -f (Get-FileHash -LiteralPath $_.FullName -Algorithm SHA256).Hash.ToLowerInvariant(), $_.Name
} | Set-Content -LiteralPath (Join-Path $packageDir 'SHA256SUMS.txt') -Encoding UTF8
$archive = Join-Path $PSScriptRoot ('dist/' + $packageName + '-win64.zip')
Compress-Archive -LiteralPath $packageDir -DestinationPath $archive -CompressionLevel Optimal
Write-Host "Package: $archive"
