# Fern

## Android releases

Fastlane uploads the Android App Bundle for `com.fernmoney.fern_money` to
Google Play. Install the Ruby dependencies once with `bundle install`, then
run `bundle exec fastlane android production`. The lane builds the release
bundle before uploading it.

By default Fastlane uses the local service-account key at
`~/.config/googlePlay.json`. In CI, provide the same key at a secure path and
set `GOOGLE_PLAY_JSON_KEY` to that path. To upload the listing assets under
`fastlane/metadata`, run `bundle exec fastlane android metadata`.

A beautiful personal-finance app for New Zealand banks, built with
[Flutter](https://flutter.dev) on the [Akahu Enduring API](https://www.akahu.nz).
Fern connects to your bank accounts through Akahu and gives you a full
dashboard: balances, net position, spending breakdowns, searchable
transaction history, and more.

<p align="center">
  <a href="https://play.google.com/store/apps/details?id=com.fernmoney.fern_money"><img src="https://play.google.com/intl/en_us/badges/static/images/badges/en_badge_web_generic.png" alt="Get it on Google Play" height="80" align="middle" /></a>
  <a href="https://github.com/brandonp2412/fern/releases/latest/download/fern.apk"><img src="assets/badges/get-apk.svg" alt="Get the APK" height="55" align="middle" /></a>
</p>

<p align="center">
  <img src="fastlane/metadata/android/en-US/images/phoneScreenshots/1_en-US.png" width="380" />
  <img src="fastlane/metadata/android/en-US/images/phoneScreenshots/2_en-US.png" width="380" />
  <img src="fastlane/metadata/android/en-US/images/phoneScreenshots/3_en-US.png" width="380" />
  <img src="fastlane/metadata/android/en-US/images/phoneScreenshots/4_en-US.png" width="380" />
  <img src="fastlane/metadata/android/en-US/images/phoneScreenshots/5_en-US.png" width="380" />
  <img src="fastlane/metadata/android/en-US/images/phoneScreenshots/6_en-US.png" width="380" />
</p>

## The Akahu API spec

The OpenAPI 3.1 spec this app is built against lives at https://developers.akahu.nz/openapi/api-akahu-apply-spec.yml

See [developers.akahu.nz](https://developers.akahu.nz) for the human-readable docs.

## Authentication

Fern uses Akahu's user-token auth style only:

| Style      | Header                                            | Used for |
|------------|---------------------------------------------------|----------|
| User token | `Authorization: Bearer <user_token>` + `X-Akahu-Id: <app_token>` | All user-data endpoints (accounts, transactions, …) |

Get your tokens from [my.akahu.nz](https://my.akahu.nz) → Developers.

Akahu's app-auth style (`Authorization: Basic base64(app_token:app_secret)`)
is **not available to Personal Apps** at all, and several user-token
endpoints (parties, name verification, verification tokens) return 403 for
personal accounts too. Fern only implements the endpoints that actually
work on a Personal App.

## Running the app

```
flutter pub get
flutter run
```

Tokens are entered on the connect screen and stored locally with
`shared_preferences`, so you only sign in once per device.

Note: the Akahu API does not send CORS headers, so Flutter **web** builds
can't call it from a browser — use Android, iOS, or desktop targets.

## End-to-end tests

`test/integration_test.dart` runs against the live Akahu API using real
credentials from the environment:

```
source ~/.zprofile   # provides AKAHU_ACCESS_TOKEN & AKAHU_APP_ID_TOKEN
dart test test/integration_test.dart
```

- A `model parsing` group validates JSON → model mapping offline.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

MIT — see [LICENSE](LICENSE).
