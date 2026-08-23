$ErrorActionPreference = "Continue"
$PSNativeCommandUseErrorActionPreference = $false

$productId = "9NST4F2TQ00Q"
& msstore submission rollout finalize $productId 2>&1 |
  ForEach-Object { Write-Host $_.ToString() }
$commandExitCode = $LASTEXITCODE

if ($commandExitCode -eq 0) {
  Write-Host "Finalized the completed Microsoft Store package rollout."
} else {
  # Microsoft permits finalization only after certification has completed and
  # the rollout is in progress. All other states are expected no-ops; the
  # scheduled workflow will try again after Partner Center advances the state.
  Write-Host "No package rollout is ready to finalize; leaving it unchanged."
}

exit 0
