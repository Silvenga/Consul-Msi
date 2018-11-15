param(
  [parameter(Mandatory = $true)]
  [string] $Version
)

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;

Write-Host "Checking for sanity."
git diff-index --quiet HEAD --
$clean = $LASTEXITCODE -eq 0
if (-not $clean)
{
  throw "Repository is dirty, will not continue."
}

Write-Host "Searching for the $Version release."

$hashUrl = "https://releases.hashicorp.com/consul/" + $Version + "/consul_" + $Version + "_SHA256SUMS"
$response = Invoke-WebRequest $hashUrl
$downloadSuccess = $response.StatusCode -eq "200"
if (-not $downloadSuccess)
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

Write-Host "Creating git commit and tag."

git commit -a -m "Upstream release $Version."
git tag $Version