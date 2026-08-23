$ErrorActionPreference = "Stop"

$productId = "9NST4F2TQ00Q"
$ErrorActionPreference = "Continue"
$output = @(& msstore submission rollout get $productId 2>&1)
$commandExitCode = $LASTEXITCODE
$ErrorActionPreference = "Stop"
$outputText = $output -join [Environment]::NewLine

if ($commandExitCode -ne 0) {
  # The rollout endpoint rejects submissions that are still in certification,
  # have no gradual rollout, or have already been finalized. Those are all
  # valid no-op states for this periodic guard.
  Write-Host "No active package rollout is ready to finalize."
  Write-Host $outputText
  exit 0
}

$plainOutput = $outputText -replace "`e\[[0-?]*[ -/]*[@-~]", ""
$jsonMatch = [regex]::Match(
  $plainOutput,
  '(?s)\{\s*"IsPackageRollout".*\}\s*$'
)

if (-not $jsonMatch.Success) {
  throw "Microsoft Store CLI returned rollout data without a JSON result: $outputText"
}

$rollout = $jsonMatch.Value | ConvertFrom-Json
Write-Host "Rollout status: $($rollout.PackageRolloutStatus); percentage: $($rollout.PackageRolloutPercentage)"

if (-not $rollout.IsPackageRollout -or
    $rollout.PackageRolloutStatus -ne "PackageRolloutInProgress" -or
    [double]$rollout.PackageRolloutPercentage -lt 100) {
  Write-Host "The rollout is not an in-progress 100% rollout; leaving it unchanged."
  exit 0
}

& msstore submission rollout finalize $productId
if ($LASTEXITCODE -ne 0) {
  throw "Microsoft Store failed to finalize the completed package rollout."
}

Write-Host "Finalized the completed Microsoft Store package rollout."
