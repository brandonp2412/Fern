param(
  [string]$ProductId = "9NST4F2TQ00Q"
)

$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $false

function Set-FinalizedOutput([bool]$finalized) {
  if ($env:GITHUB_OUTPUT) {
    $value = $finalized.ToString().ToLowerInvariant()
    Add-Content -Path $env:GITHUB_OUTPUT -Value "finalized=$value"
  }
}

function Invoke-StoreCommand([string[]]$Arguments) {
  $output = @(& msstore @Arguments 2>&1)
  $exitCode = $LASTEXITCODE
  $output | ForEach-Object { Write-Host $_.ToString() }

  return @{
    ExitCode = $exitCode
    Output = $output
  }
}

function Invoke-StoreCommandWithRetry(
  [string[]]$Arguments,
  [string]$Description,
  [int]$Attempts = 5,
  [int]$DelaySeconds = 15
) {
  $result = $null

  for ($attempt = 1; $attempt -le $Attempts; $attempt++) {
    $result = Invoke-StoreCommand $Arguments
    if ($result.ExitCode -eq 0) {
      return $result
    }

    if ($attempt -lt $Attempts) {
      Write-Warning "$Description attempt $attempt failed with exit code $($result.ExitCode); retrying in $DelaySeconds seconds."
      Start-Sleep -Seconds $DelaySeconds
    }
  }

  return $result
}

function ConvertFrom-StoreJson($Output, [string]$Description) {
  $text = ($Output | ForEach-Object { $_.ToString() }) -join [Environment]::NewLine
  $jsonStart = $text.IndexOf("{")
  $jsonEnd = $text.LastIndexOf("}")

  if ($jsonStart -lt 0 -or $jsonEnd -le $jsonStart) {
    throw "Microsoft Store CLI returned no $Description JSON."
  }

  return $text.Substring($jsonStart, $jsonEnd - $jsonStart + 1) |
    ConvertFrom-Json
}

Set-FinalizedOutput $false

$pollResult = Invoke-StoreCommandWithRetry @(
  "submission", "poll", $ProductId, "--verbose"
) "Microsoft Store submission polling" 3 20

if ($pollResult.ExitCode -ne 0) {
  $pollText = ($pollResult.Output | ForEach-Object { $_.ToString() }) -join [Environment]::NewLine
  $failedStatuses = @(
    "CommitFailed",
    "PreProcessingFailed",
    "CertificationFailed",
    "ReleaseFailed",
    "PublishFailed",
    "FAILED"
  )
  $knownFailure = $failedStatuses | Where-Object {
    $pollText -match [regex]::Escape($_)
  }

  if ($knownFailure) {
    Write-Warning "Existing Microsoft Store submission is failed; the next publish can replace it."
  } else {
    Write-Error "Could not wait for the existing Microsoft Store submission to finish."
    exit $pollResult.ExitCode
  }
}

$appResult = Invoke-StoreCommandWithRetry @(
  "apps", "get", $ProductId, "--verbose"
) "Microsoft Store application lookup"

if ($appResult.ExitCode -ne 0) {
  Write-Error "Could not retrieve the Microsoft Store application."
  exit $appResult.ExitCode
}

try {
  $application = ConvertFrom-StoreJson $appResult.Output "application"
} catch {
  Write-Error $_.Exception.Message
  exit 1
}

$submissionId = $application.LastPublishedApplicationSubmission.Id
if (-not $submissionId) {
  Set-FinalizedOutput $true
  Write-Host "No published Microsoft Store submission exists yet; there is no rollout to finalize."
  exit 0
}

$getResult = Invoke-StoreCommandWithRetry @(
  "submission", "rollout", "get", $ProductId,
  "--submissionId", $submissionId, "--verbose"
) "Microsoft Store rollout lookup"

if ($getResult.ExitCode -ne 0) {
  Set-FinalizedOutput $true
  Write-Warning "Microsoft Store did not return a usable package rollout after retries. Treating it as no active rollout; the publish step will still verify Store readiness."
  exit 0
}

try {
  $rollout = ConvertFrom-StoreJson $getResult.Output "rollout"
} catch {
  Write-Error $_.Exception.Message
  exit 1
}

if (
  -not $rollout.IsPackageRollout -or
  $rollout.PackageRolloutStatus -eq "PackageRolloutComplete"
) {
  Set-FinalizedOutput $true
  Write-Host "No active Microsoft Store package rollout remains."
  exit 0
}

$finalizeResult = Invoke-StoreCommandWithRetry @(
  "submission", "rollout", "finalize", $ProductId,
  "--submissionId", $submissionId, "--verbose"
) "Microsoft Store rollout finalization" 3 15

if ($finalizeResult.ExitCode -ne 0) {
  $verifyResult = Invoke-StoreCommandWithRetry @(
    "submission", "rollout", "get", $ProductId,
    "--submissionId", $submissionId, "--verbose"
  ) "Microsoft Store rollout verification" 3 10

  if ($verifyResult.ExitCode -eq 0) {
    try {
      $verifiedRollout = ConvertFrom-StoreJson $verifyResult.Output "rollout"
      if (
        -not $verifiedRollout.IsPackageRollout -or
        $verifiedRollout.PackageRolloutStatus -eq "PackageRolloutComplete"
      ) {
        Set-FinalizedOutput $true
        Write-Host "Microsoft Store rollout is already complete after finalization retries."
        exit 0
      }
    } catch {
      Write-Warning $_.Exception.Message
    }
  }

  Write-Error "Microsoft Store package rollout finalization failed after retries."
  exit $finalizeResult.ExitCode
}

Set-FinalizedOutput $true
Write-Host "Finalized the active Microsoft Store package rollout."
exit 0
