param (
    [string]$RootPath
)

if (-not $RootPath) {
    $defaultPath = Join-Path $env:USERPROFILE "Documents\GitHub"
    Write-Host "No path provided. Default is: $defaultPath"
    $RootPath = Read-Host "Enter the root path"
    if (-not $RootPath -or $RootPath.Trim() -eq "") { exit }
}

if (-not (Test-Path $RootPath)) { Write-Error "Path not found"; exit }

$startTime = Get-Date
$folders = Get-ChildItem -Path $RootPath -Recurse -Directory -Force -Filter "node_modules"
if (-not $folders) { Write-Output "No node_modules found"; exit }

$sizeList = $folders | ForEach-Object {
    (Get-ChildItem -Path $_.FullName -Recurse -Force -ErrorAction SilentlyContinue |
        Measure-Object -Property Length -Sum).Sum
}
$totalSize = ($sizeList | Measure-Object -Sum).Sum
$totalSizeGB = [math]::Round($totalSize / 1GB, 2)
Write-Output "Found $($folders.Count) folders. Estimated space: $totalSizeGB GB"

$count = $folders.Count; $i = 0; $freedSoFar = 0
foreach ($folder in $folders) {
    $i++
    $size = (Get-ChildItem -Path $folder.FullName -Recurse -Force -ErrorAction SilentlyContinue |
        Measure-Object -Property Length -Sum).Sum
    $sizeGB = [math]::Round($size / 1GB, 2)
    Write-Progress -Activity "Deleting node_modules" -Status "$($folder.FullName) ($sizeGB GB)" -PercentComplete (($i / $count) * 100)
    Remove-Item -Path $folder.FullName -Recurse -Force -ErrorAction SilentlyContinue
    $freedSoFar += $size
    $freedGB = [math]::Round($freedSoFar / 1GB, 2)
    Write-Output "[$i/$count] Deleted $($folder.FullName) -> $sizeGB GB (Total: $freedGB GB)"
}

$elapsed = (Get-Date) - $startTime
$freedGB = [math]::Round($freedSoFar / 1GB, 2)
Write-Output "`n=== Cleanup complete ==="
Write-Output "Deleted: $count folders"
Write-Output "Space freed: $freedGB GB"
Write-Output "Time taken: $($elapsed.ToString())"
