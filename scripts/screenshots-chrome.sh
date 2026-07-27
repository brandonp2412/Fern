#!/bin/bash

set -e

device_type="${1:-desktop}"

echo "Running screenshot tests with Chrome..."

# Set environment variables for device type and platform
export FERN_DEVICE_TYPE="$device_type"
export FERN_WEB="true"

# Run Flutter drive command targeting Chrome
flutter drive --profile --driver=test_driver/integration_test.dart \
    --target=integration_test/screenshot_test.dart \
    -d chrome --headless

echo "Screenshot tests completed successfully!"
