import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:drift/drift.dart'
    show DatabaseConnection, DriftRuntimeOptions, driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:fern/db/app_database.dart';
import 'package:fern/models/account.dart';
import 'package:fern/models/transaction.dart';
import 'package:fern/services/akahu_api.dart';
import 'package:fern/state/app_settings.dart';
import 'package:fern/state/app_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// An in-memory drift database for tests — no path_provider, no disk I/O.
/// Wrapped in a [DatabaseConnection] with closeStreamsSynchronously so
/// drift's stream-query timers don't keep fake-async widget tests alive.
AppDatabase testDb() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  return AppDatabase.forTesting(
    DatabaseConnection(
      NativeDatabase.memory(),
      closeStreamsSynchronously: true,
    ),
  );
}

// ---------------------------------------------------------------------------
// Realistic account fixtures — real NZ banks and account naming conventions.
// ---------------------------------------------------------------------------

Account anzEveryday({num balance = 2450.32}) => Account.fromJson({
  '_id': 'acc_anz_everyday',
  'name': 'ANZ Everyday',
  'status': 'ACTIVE',
  'type': 'CHECKING',
  'attributes': ['TRANSACTIONS', 'PAYMENT_FROM', 'PAYMENT_TO'],
  'formatted_account': '01-0123-0123456-00',
  'connection': {
    '_id': 'conn_anz',
    'name': 'ANZ',
    'logo': 'https://cdn.akahu.nz/logos/anz.png',
  },
  'balance': {'currency': 'NZD', 'current': balance, 'available': balance},
});

Account asbStreamline({num balance = 8120.11}) => Account.fromJson({
  '_id': 'acc_asb_streamline',
  'name': 'ASB Streamline',
  'status': 'ACTIVE',
  'type': 'SAVINGS',
  'attributes': ['TRANSACTIONS', 'PAYMENT_FROM', 'PAYMENT_TO'],
  'formatted_account': '12-3405-0123456-00',
  'connection': {
    '_id': 'conn_asb',
    'name': 'ASB',
    'logo': 'https://cdn.akahu.nz/logos/asb.png',
  },
  'balance': {'currency': 'NZD', 'current': balance, 'available': balance},
});

Account kiwibankNoticeSaver({num balance = 15302.87}) => Account.fromJson({
  '_id': 'acc_kiwibank_notice_saver',
  'name': 'Kiwibank Notice Saver',
  'status': 'ACTIVE',
  'type': 'SAVINGS',
  'attributes': ['TRANSACTIONS'],
  'formatted_account': '38-9012-0123456-00',
  'connection': {
    '_id': 'conn_kiwibank',
    'name': 'Kiwibank',
    'logo': 'https://cdn.akahu.nz/logos/kiwibank.png',
  },
  'balance': {'currency': 'NZD', 'current': balance, 'available': balance},
});

Account amexCreditCard({num owing = 512.40}) => Account.fromJson({
  '_id': 'acc_amex_credit_card',
  'name': 'Amex Platinum',
  'status': 'ACTIVE',
  'type': 'CREDITCARD',
  'attributes': ['TRANSACTIONS', 'PAYMENT_TO'],
  'formatted_account': '3782 822463 10005',
  'connection': {
    '_id': 'conn_amex',
    'name': 'American Express',
    'logo': 'https://cdn.akahu.nz/logos/amex.png',
  },
  'balance': {
    'currency': 'NZD',
    'current': owing,
    'available': 4487.60,
    'limit': 5000,
  },
});

// ---------------------------------------------------------------------------
// Realistic transaction fixtures — real NZ merchants matching AutoCategorizer
// rules, so category grouping in tests reflects genuine app behaviour.
// ---------------------------------------------------------------------------

Transaction _tx({
  required String id,
  required String account,
  required String date,
  required String description,
  required num amount,
  String type = 'EFTPOS',
  String? merchantName,
  String? categoryName,
  String? categoryGroup,
}) => Transaction.fromJson({
  '_id': id,
  '_account': account,
  '_connection': 'conn_anz',
  'date': date,
  'description': description,
  'amount': amount,
  'type': type,
  if (merchantName != null)
    'merchant': {'_id': 'merch_$id', 'name': merchantName},
  if (categoryName != null)
    'category': {
      '_id': 'cat_$id',
      'name': categoryName,
      if (categoryGroup != null)
        'groups': {
          'personal_finance': {'_id': 'grp_$id', 'name': categoryGroup},
        },
    },
});

Transaction mcdonaldsBurger({
  String account = 'acc_anz_everyday',
  String date = '2026-07-20T12:15:00.000Z',
}) => _tx(
  id: 'txn_mcdonalds_${date.substring(0, 10)}',
  account: account,
  date: date,
  description: 'MCDONALDS AUCKLAND',
  amount: -14.90,
  merchantName: "McDonald's",
);

Transaction uberTrip({
  String account = 'acc_anz_everyday',
  String date = '2026-07-18T21:40:00.000Z',
}) => _tx(
  id: 'txn_uber_${date.substring(0, 10)}',
  account: account,
  date: date,
  description: 'UBER *TRIP HELP.UBER.COM',
  amount: -23.50,
  merchantName: 'Uber',
);

Transaction bpFuel({
  String account = 'acc_anz_everyday',
  String date = '2026-07-15T08:05:00.000Z',
}) => _tx(
  id: 'txn_bp_${date.substring(0, 10)}',
  account: account,
  date: date,
  description: 'BP CONNECT PONSONBY',
  amount: -87.20,
  merchantName: 'BP',
);

Transaction netflixSubscription({
  String account = 'acc_asb_streamline',
  String date = '2026-07-05T00:00:00.000Z',
}) => _tx(
  id: 'txn_netflix_${date.substring(0, 10)}',
  account: account,
  date: date,
  description: 'NETFLIX.COM',
  amount: -22.99,
  merchantName: 'Netflix',
);

Transaction mercuryEnergyBill({
  String account = 'acc_asb_streamline',
  String date = '2026-07-10T00:00:00.000Z',
}) => _tx(
  id: 'txn_mercury_${date.substring(0, 10)}',
  account: account,
  date: date,
  description: 'MERCURY ENERGY',
  amount: -145.32,
  merchantName: 'Mercury Energy',
);

Transaction payday({
  String account = 'acc_anz_everyday',
  String date = '2026-07-01T00:00:00.000Z',
  num amount = 3200.00,
}) => _tx(
  id: 'txn_payday_${date.substring(0, 10)}',
  account: account,
  date: date,
  description: 'ACME LTD PAYROLL',
  amount: amount,
  type: 'DIRECT CREDIT',
);

Transaction internalTransfer({
  String account = 'acc_anz_everyday',
  String date = '2026-07-12T00:00:00.000Z',
  num amount = -500.00,
}) => _tx(
  id: 'txn_transfer_${date.substring(0, 10)}_${amount.abs()}',
  account: account,
  date: date,
  description: 'TRANSFER TO ASB STREAMLINE',
  amount: amount,
  type: 'TRANSFER',
);

/// A spread of transactions across accounts, dates and categories — enough
/// for stats/aggregation tests to have real, varied data to chew on.
List<Transaction> sampleTransactions() => [
  mcdonaldsBurger(),
  uberTrip(),
  bpFuel(),
  netflixSubscription(),
  mercuryEnergyBill(),
  payday(),
  internalTransfer(),
];

// ---------------------------------------------------------------------------
// App-level test doubles
// ---------------------------------------------------------------------------

AkahuApi fakeApi({MockClient? client}) => AkahuApi(
  userToken: 'user_test_token',
  appToken: 'app_test_token',
  client:
      client ??
      MockClient((req) async => http.Response('{"success":false}', 404)),
);

Future<AppSettings> testSettings() async {
  SharedPreferences.setMockInitialValues({});
  final settings = AppSettings();
  await settings.load();
  return settings;
}

/// Seeds an in-memory [AppDatabase] with the given accounts/transactions and
/// builds a real [AppState] wired to it, waiting for the reactive streams to
/// deliver their first values before returning.
///
/// Pass [tester] when calling this from a `testWidgets` body: widget tests
/// run under a fake-time binding where a bare `Future.delayed`/microtask-pump
/// never fires (nothing advances the fake clock), so the flush is done via
/// `tester.pump()` instead, which does. Plain `test()` bodies (no tester)
/// have no such binding, so a real `Future.delayed` flush works there.
Future<AppState> seededState({
  List<Account> accounts = const [],
  List<Transaction> transactions = const [],
  AppSettings? settings,
  AkahuApi? api,
  AppDatabase? db,
  WidgetTester? tester,
}) async {
  final database = db ?? testDb();
  if (accounts.isNotEmpty) {
    await database.saveAccounts({
      for (final a in accounts) a.id: json.encode(a.toJson()),
    });
  }
  if (transactions.isNotEmpty) {
    await database.saveTransactions([
      for (final t in transactions)
        (id: t.id, accountId: t.account, json: json.encode(t.toJson())),
    ]);
  }
  final state = AppState(
    api ?? fakeApi(),
    settings ?? await testSettings(),
    db: database,
  );
  if (tester != null) {
    await tester.pump();
    await tester.pump();
  } else {
    await Future.delayed(Duration.zero);
    await Future.delayed(Duration.zero);
  }
  return state;
}

const _secureStorageChannel = MethodChannel(
  'plugins.it_nomads.com/flutter_secure_storage',
);

/// Installs an in-memory fake for the flutter_secure_storage platform
/// channel, so tests exercising [SecureStore]/`SettingsScreen._disconnect`
/// don't touch a real keychain/keystore.
void mockSecureStorage() {
  final store = <String, String>{};
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(_secureStorageChannel, (call) async {
        switch (call.method) {
          case 'write':
            final args = (call.arguments as Map).cast<String, dynamic>();
            store[args['key'] as String] = args['value'] as String;
            return null;
          case 'read':
            final args = (call.arguments as Map).cast<String, dynamic>();
            return store[args['key'] as String];
          case 'delete':
            final args = (call.arguments as Map).cast<String, dynamic>();
            store.remove(args['key'] as String);
            return null;
          case 'deleteAll':
            store.clear();
            return null;
          case 'readAll':
            return store;
          case 'containsKey':
            final args = (call.arguments as Map).cast<String, dynamic>();
            return store.containsKey(args['key'] as String);
          default:
            return null;
        }
      });
}

// A 1x1 transparent PNG, returned in place of any real network image so
// screen tests never depend on (or hang on) real connectivity, and render
// deterministically in a single frame.
final _transparentPng = Uint8List.fromList([
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
  0x42,
  0x60,
  0x82,
]);

class _FakeImageHttpClient implements HttpClient {
  @override
  bool autoUncompress = true;
  @override
  Duration idleTimeout = Duration.zero;
  @override
  Duration? connectionTimeout;
  @override
  int? maxConnectionsPerHost;
  @override
  String? userAgent;

  @override
  Future<HttpClientRequest> getUrl(Uri url) async => _FakeImageHttpRequest();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeImageHttpRequest implements HttpClientRequest {
  @override
  Future<HttpClientResponse> close() async => _FakeImageHttpResponse();

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeImageHttpResponse extends Stream<List<int>>
    implements HttpClientResponse {
  @override
  int get statusCode => 200;
  @override
  int get contentLength => _transparentPng.length;

  @override
  StreamSubscription<List<int>> listen(
    void Function(List<int> event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    return Stream<List<int>>.fromIterable([_transparentPng]).listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeImageHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) =>
      _FakeImageHttpClient();
}

/// Prevents [Image.network] (used for real bank/connection logo URLs in
/// account fixtures) from making real network calls in widget tests, which
/// would otherwise hang or fail depending on sandbox connectivity. Call once
/// per test file, e.g. in `setUpAll`.
void mockNetworkImages() {
  HttpOverrides.global = _FakeImageHttpOverrides();
}
