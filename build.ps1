$vendorDirectory = "Vendor"
$contantsTemplateFile = "Consul\Constants.Template.wxi"
$contantsFile = "Consul\Constants.wxi"

$release = Get-Content -Raw -Path "release.json" | ConvertFrom-Json

$version = $release.Version
$hash = $release.Hash
$downloadUrl = "https://releases.hashicorp.com/consul/" + $version + "/consul_" + $version + "_windows_amd64.zip"
$outputArchive = "release.zip"
$outputDirectory = "release"

Write-Host "Downloading Consul from $downloadUrl."
Invoke-WebRequest -UseBasicParsing -Uri $downloadUrl -OutFile $outputArchive

Write-Host "Checking downloaded archive '$outputArchive' for integrity."
$downloadHash = (Get-FileHash -Path $outputArchive -Algorithm SHA256).Hash.ToLower()
Write-Host "Got $downloadHash, expected $hash."
$hasMatches = $hash -eq $downloadHash

if ($hasMatches)
{
    Write-Host "Archive hash matches, will continue."

    Write-Host "Copying consul to the vendor directory."
    Expand-Archive $outputArchive -DestinationPath $outputDirectory -Force
    Copy-Item "$outputDirectory/consul.exe" "$vendorDirectory/consul.exe"

    Write-Host "Patching constants file."
    $template = Get-Content -Raw -Path $contantsTemplateFile
    ($template).Replace("%VERSION%", $version) | Set-Content $contantsFile

    Write-Host "Solution is now ready for building."
}
else
{
    throw "Archive hash does not match, will fail."
}