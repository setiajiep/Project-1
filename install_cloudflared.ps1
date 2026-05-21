# install_cloudflared.ps1
# This script downloads the standalone cloudflared.exe to the current workspace directory.

$exeUrl = "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-windows-amd64.exe"
$outputPath = Join-Path $PSScriptRoot "cloudflared.exe"

Write-Host "Checking if cloudflared.exe is already present in the workspace..."
if (Test-Path $outputPath) {
    Write-Host "cloudflared.exe is already present at: $outputPath"
} else {
    Write-Host "Downloading standalone cloudflared.exe from $exeUrl ..."
    try {
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
        Invoke-WebRequest -Uri $exeUrl -OutFile $outputPath -UseBasicParsing
        Write-Host "Download complete! Saved to: $outputPath"
    } catch {
        Write-Error "Failed to download cloudflared.exe: $_"
        exit 1
    }
}

# Verify the file and check version
if (Test-Path $outputPath) {
    Write-Host "Verifying executable..."
    & $outputPath --version
    Write-Host "Successfully downloaded!"
} else {
    Write-Error "Failed to locate cloudflared.exe after download."
    exit 1
}
