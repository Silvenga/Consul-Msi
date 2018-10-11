param(
    [parameter(Mandatory = $true)]
    [string] $Version
)

Write-Host "Searching for the $Version release."

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;

$hashUrl = "https://releases.hashicorp.com/consul/" + $Version + "/consul_" + $Version + "_SHA256SUMS"

$response = Invoke-WebRequest $hashUrl

if (-not $response.StatusCode -eq "200")
{
    throw "Version was not found."
}

$content = $response.Content
$hash = ($content.Split("`n") | Where-Object { $_ -like "*_windows_amd64.zip" }).Split(" ") | Select-Object -First 1

$release = @{ 
    Version = $Version
    Hash    = $hash
} | ConvertTo-Json

$release | Out-File -FilePath "./release.json"

Write-Host "Release file updated."