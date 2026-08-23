$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $false

$productId = "9NST4F2TQ00Q"
$ErrorActionPreference = "Continue"
$output = @(& msstore submission rollout get $productId 2>&1)
$commandExitCode = $LASTEXITCODE
$outputText = ($output | ForEach-Object { $_.ToString() }) -join [Environment]::NewLine
$ErrorActionPreference = "Stop"

if ($commandExitCode -ne 0) {
  # The rollout endpoint rejects submissions that are still in certification,
  # have no gradual rollout, or have already been finalized. Those are all
  # valid no-op states for this periodic guard.
  Write-Host "No active package rollout is ready to finalize."
  Write-Host $outputText
  exit 0
}

$plainOutput = $outputText -replace "`e\[[0-?]*[ -/]*[@-~]", ""
$isFullRollout = $plainOutput -match '"PackageRolloutPercentage"\s*:\s*100(?:\.0+)?'
$isInProgress = $plainOutput -match '"PackageRolloutStatus"\s*:\s*"PackageRolloutInProgress"'

if (-not $isFullRollout -or -not $isInProgress) {
  Write-Host "The rollout is not an in-progress 100% rollout; leaving it unchanged."
  Write-Host $plainOutput
  exit 0
}

& msstore submission rollout finalize $productId
if ($LASTEXITCODE -ne 0) {
  throw "Microsoft Store failed to finalize the completed package rollout."
}

Write-Host "Finalized the completed Microsoft Store package rollout."
