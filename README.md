# Fern

A beautiful personal-finance app for New Zealand banks, built on the
[Akahu Enduring API](https://www.akahu.nz). Fern connects to your bank
accounts through Akahu and gives you a full dashboard: balances, net
position, spending breakdowns, searchable transaction history, webhooks,
and more.

## The Akahu API spec

The machine-readable OpenAPI 3.1 spec that this app is built against lives
in [`akahu-openapi.json`](./akahu-openapi.json) at the repo root.

### How it was obtained

The spec was downloaded directly from ReadMe's public API registry (the
service that hosts Akahu's developer docs):

```
curl -sL https://dash.readme.com/api/v1/api-registry/1myv13mqkadg46 \
  -o akahu-openapi.json
```

That endpoint returns the raw OpenAPI 3.1.0 document
(`"title": "Akahu Enduring API"`, server `https://api.akahu.io/v1`)
describing every endpoint, parameter, request body, and schema.

### If that link stops working

The `dash.readme.com/api/v1/api-registry/<id>` URL is an undocumented,
volatile ReadMe-internal endpoint — the ID changes whenever Akahu
re-publishes their docs. If it 404s or stops resolving:

1. **Browse to Akahu's API reference** at
   [developers.akahu.nz](https://developers.akahu.nz) (or
   [akahu.docs.apiary.io](https://developers.akahu.nz/reference) — their
   docs are hosted on ReadMe).
2. Open your browser's devtools **Network** tab, reload the API reference
   page, and look for a request to
   `https://dash.readme.com/api/v1/api-registry/<some-id>` — that response
   is the current OpenAPI JSON. Save it over `akahu-openapi.json`.
3. Alternatively, ReadMe exposes a "Download OpenAPI" option in some docs
   sites' reference section menus.

The human-readable docs (guides, endpoint descriptions) are always at
https://developers.akahu.nz — the endpoints themselves are stable:
`https://api.akahu.io/v1`.

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

## Project structure

```
akahu-openapi.json          The OpenAPI 3.1 spec this app was built from (see above)
lib/
├── main.dart               App entry + fern-themed Akahu connect screen
├── theme.dart              "Fern" design system (palette + Material 3 theme)
├── models/                 Typed models mirroring the spec's schemas
│   ├── account.dart        Account, balance, connection info, refresh stamps
│   ├── transaction.dart    Transaction, PendingTransaction, merchant, NZFCC
│   │                       category + groups, meta (PCR fields, FX conversion,
│   │                       card suffix, logo)
│   ├── connection.dart     Financial institution connections (embedded in accounts)
│   ├── user.dart           The /me user
│   └── page.dart           Cursor-paginated result wrapper
├── services/
│   └── akahu_api.dart      API client — endpoints that work on a Personal App
├── state/
│   └── app_state.dart      Session state (user, accounts, refresh orchestration)
├── utils/format.dart       Money, dates, account/transaction labels
├── widgets/
│   ├── common.dart         MoneyText, LogoAvatar, StatusChip, state views
│   └── txn_tile.dart       Transaction row with merchant logos
└── screens/
    ├── home_shell.dart            Bottom-nav shell (4 tabs)
    ├── overview_screen.dart       Net position, account carousel, spending-by-
    │                              category bars, recent activity
    ├── accounts_screen.dart       All accounts + bank-data refresh
    ├── account_detail_screen.dart Balance hero, pending txns, paginated history,
    │                              account refresh
    ├── transactions_screen.dart   Search, direction + date-range filters,
    │                              day-grouped feed, cursor infinite scroll
    ├── txn_detail.dart            Enriched transaction sheet + issue reporting
    └── profile_screen.dart        User card, disconnect (token revocation)
test/
└── integration_test.dart   Live end-to-end suite hitting the real API
```

## API coverage

`lib/services/akahu_api.dart` implements only the endpoints that work on a
Personal App:

- `GET /me` — profile & access info
- `GET /accounts`, `GET /accounts/{id}` — account list & detail
- `GET /accounts/{id}/transactions` — cursor-paginated history
- `GET /accounts/{id}/transactions/pending` — pending transactions
- `GET /transactions`, `GET /transactions/{id}` — cross-account feed
- `GET /transactions/pending` — all pending transactions
- `POST /transactions/ids` — fetch transactions by ID list
- `POST /refresh`, `POST /refresh/{id}` — request data refreshes
- `POST /support/{transaction_id}` — report duplicates / enrichment issues
- `DELETE /authorisations/{id}` — revoke an institution authorisation
- `DELETE /token` — revoke the user access token (Fern's "disconnect")

The spec documents further endpoints (parties, verification tokens, name
verification, categories, connections, identity, keys, webhooks, OAuth
token exchange) but they either require app-auth (unavailable to Personal
Apps) or return 403 for personal accounts even with valid user-token auth,
so they've been removed from the app.

## Running the app

```
flutter pub get

# Run with tokens prefilled (they're still editable on the connect screen)
flutter run \
  --dart-define=AKAHU_ACCESS_TOKEN=user_token_… \
  --dart-define=AKAHU_APP_ID_TOKEN=app_token_…
```

Tokens entered on the connect screen are stored locally with
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
