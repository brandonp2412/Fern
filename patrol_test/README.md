# Patrol end-to-end tests

Run the Android E2E suite on an emulator or device:

```sh
dart pub global activate patrol_cli 4.7.0
patrol test -t patrol_test/smoke_test.dart
```

The smoke test uses Fern's offline demo mode, so it does not require Akahu
credentials or network access.
