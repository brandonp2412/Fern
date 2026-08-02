# Contributing

The only thing that matters is that the code works. Nothing else.

I do not care about:
- Code style or formatting
- Comments or documentation strings
- Commit message format
- Branch naming conventions
- Test coverage percentages (though tests that prove correctness are welcome)

I only care about:
- The app builds and runs without errors
- Existing functionality is not broken
- New features actually work end-to-end

## Before submitting

1. Run `flutter test` and make sure tests pass.
2. Run `dart run build_runner build -d` to regenerate drift code if you changed the database schema.
3. If you added new model fields, run `dart test test/integration_test.dart` against the live API to verify parsing.

That's it. Open a PR.
