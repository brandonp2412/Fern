# Fix Android resource linking failed error

The project fails to build because `app/src/main/res/drawable/ic_launcher_foreground.xml` contains an `<adaptive-icon>` element, which is only supported in API level 26 and above. Since it is located in the unqualified `drawable/` directory, the Android Asset Packaging Tool (AAPT) attempts to process it for all supported SDK versions (which includes versions below 26 in this project).

Furthermore, the content of `ic_launcher_foreground.xml` is recursive (referencing `@drawable/ic_launcher_foreground`) and redundant, as a proper adaptive icon is already defined in `app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml`.

## Proposed Changes

### [Component Name]

#### [DELETE] [ic_launcher_foreground.xml](file:///home/brandon/fern/android/app/src/main/res/drawable/ic_launcher_foreground.xml)
This file is misnamed, misplaced, and contains a recursive definition. Removing it will allow the build to proceed and ensure that the adaptive icon defined in `mipmap-anydpi-v26` correctly resolves the foreground to the density-specific PNG assets (or other available drawables).

#### [MODIFY] [ic_launcher.xml](file:///home/brandon/fern/android/app/src/main/res/mipmap-anydpi-v26/ic_launcher.xml)
Update to include the 16% inset for the foreground layer, which seems to have been the intention of the problematic file. This ensures the launcher icon is correctly sized on API 26+ devices.

#### [MODIFY] [ic_launcher_round.xml](file:///home/brandon/fern/android/app/src/main/res/mipmap-anydpi-v26/ic_launcher_round.xml)
Similar update to `ic_launcher_round.xml` for consistency.

## Verification Plan

### Automated Tests
- Run `./gradlew :app:processDebugResources` to verify that the resource linking error is resolved.
- Run a full build: `./gradlew :app:assembleDebug`.

### Manual Verification
- Deploy the app to an emulator (API 26+) and verify that the launcher icon appears correctly with the intended inset.
- Deploy the app to an emulator (API < 26) and verify that the legacy launcher icon (PNG) appears correctly.
