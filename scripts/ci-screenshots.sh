#!/usr/bin/env bash

set -euo pipefail

device_type="${FERN_DEVICE_TYPE:-phoneScreenshots}"
emulator_port="${EMULATOR_PORT:?EMULATOR_PORT must be set}"
screenshot_dir="fastlane/metadata/android/en-US/images/$device_type"

rm -rf "$screenshot_dir"
mkdir -p "$screenshot_dir"

drive_log=$(mktemp)
drive_status=0
flutter drive --profile \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/screenshot_test.dart \
  -d "emulator-$emulator_port" >"$drive_log" 2>&1 || drive_status=$?
cat "$drive_log"

for number in $(seq 1 6); do
  if [[ ! -s "$screenshot_dir/${number}_en-US.png" ]]; then
    echo "Missing generated screenshot: ${number}_en-US.png" >&2
    [[ "$drive_status" -ne 0 ]] && exit "$drive_status"
    exit 1
  fi
done

if [[ "$drive_status" -ne 0 ]]; then
  if ! grep -q "All tests passed!" "$drive_log"; then
    exit "$drive_status"
  fi
  echo "flutter drive lost the emulator during teardown after screenshots were generated"
fi
