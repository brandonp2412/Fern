#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$SCRIPT_DIR/screenshot-names.sh"

device_type=""
only=""
show=0

for arg in "$@"; do
    case "$arg" in
        --show|--headed) show=1 ;;
        *)
            if [ -z "$device_type" ]; then
                device_type="$arg"
            elif [ -z "$only" ]; then
                only="$arg"
            fi
            ;;
    esac
done
device_type="${device_type:-desktop}"

echo "Running screenshot tests with Chrome..."

# Set environment variables for device type and platform
export FERN_DEVICE_TYPE="$device_type"
export FERN_WEB="true"

dart_define=()
if [ -n "$only" ]; then
    only="$(screenshot_name "$only")"
    dart_define=(--dart-define=SCREENSHOT_ONLY="$only")
    echo "Capturing only: $only"
fi

headless_flag=(--headless)
[ "$show" -eq 1 ] && headless_flag=()

# Run Flutter drive command targeting Chrome
flutter drive --profile --driver=test_driver/integration_test.dart \
    --target=integration_test/screenshot_test.dart \
    "${dart_define[@]}" \
    -d chrome "${headless_flag[@]}"

echo "Screenshot tests completed successfully!"
