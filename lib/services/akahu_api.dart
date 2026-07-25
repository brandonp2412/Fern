import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/account.dart';
import '../models/category.dart';
import '../models/connection.dart';
import '../models/page.dart';
import '../models/party.dart';
import '../models/transaction.dart';
import '../models/user.dart';

class AkahuApi {
  static const _baseUrl = 'https://api.akahu.io/v1';

  final String _userToken;
  final String _appToken;
  final String _appSecret;

  AkahuApi({
    required String userToken,
    required String appToken,
    String appSecret = '',
  })  : _userToken = userToken,
        _appToken = appToken,
        _appSecret = appSecret;

  bool get hasAppSecret => _appSecret.isNotEmpty;

  Map<String, String> get _userHeaders => {
        'Authorization': 'Bearer $_userToken',
        'X-Akahu-Id': _appToken,
      };

  Map<String, String> get _appHeaders => {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$_appToken:$_appSecret'))}',
        'X-Akahu-Id': _appToken,
      };

  Future<Map<String, dynamic>> _request(
    String method,
    String path, {
    Map<String, String>? params,
    Object? body,
    bool appAuth = false,
    bool noAuth = false,
  }) async {
    final uri = Uri.parse('$_baseUrl$path')
        .replace(queryParameters: params != null && params.isNotEmpty ? params : null);
    final headers = <String, String>{
      if (!noAuth) ...(appAuth ? _appHeaders : _userHeaders),
      if (body != null) 'Content-Type': 'application/json',
    };
    final res = await switch (method) {
      'GET' => http.get(uri, headers: headers),
      'POST' => http.post(uri, headers: headers,
          body: body != null ? json.encode(body) : null),
      'PUT' => http.put(uri, headers: headers,
          body: body != null ? json.encode(body) : null),
      'DELETE' => http.delete(uri, headers: headers),
      _ => throw ArgumentError('Unsupported method $method'),
    };
    return _parseResponse(res);
  }

  Future<Map<String, dynamic>> _get(String path,
          {Map<String, String>? params, bool appAuth = false}) =>
      _request('GET', path, params: params, appAuth: appAuth);

  Future<Map<String, dynamic>> _post(String path,
          {Object? body, bool noAuth = false}) =>
      _request('POST', path, body: body, noAuth: noAuth);

  Future<Map<String, dynamic>> _delete(String path, {bool appAuth = false}) =>
      _request('DELETE', path, appAuth: appAuth);

  Map<String, dynamic> _parseResponse(http.Response res) {
    Map<String, dynamic> data;
    try {
      data = json.decode(res.body) as Map<String, dynamic>;
    } catch (_) {
      throw ApiException('HTTP ${res.statusCode}: ${res.body}', res.statusCode);
    }
    if (res.statusCode >= 200 && res.statusCode < 300 && data['success'] == true) {
      return data;
    }
    throw ApiException(
        data['message']?.toString() ?? 'HTTP ${res.statusCode}', res.statusCode);
  }

  static Map<String, String> _range(String? start, String? end,
          {String? cursor}) =>
      {
        if (start != null) 'start': start,
        if (end != null) 'end': end,
        if (cursor != null) 'cursor': cursor,
      };

  Future<User> getMe() async =>
      User.fromJson((await _get('/me'))['item']);

  Future<List<Account>> getAccounts() async {
    final items = (await _get('/accounts'))['items'] as List<dynamic>;
    return items.map((e) => Account.fromJson(e)).toList();
  }

  Future<Account> getAccount(String id) async =>
      Account.fromJson((await _get('/accounts/$id'))['item']);

  Future<Page<Transaction>> getAccountTransactions(
    String accountId, {
    String? start,
    String? end,
    String? cursor,
  }) async {
    final data = await _get('/accounts/$accountId/transactions',
        params: _range(start, end, cursor: cursor));
    return Page(
      items: (data['items'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e))
          .toList(),
      nextCursor: data['cursor']?['next'],
    );
  }

  Future<List<PendingTransaction>> getAccountPendingTransactions(
      String accountId) async {
    final data = await _get('/accounts/$accountId/transactions/pending');
    return (data['items'] as List<dynamic>)
        .map((e) => PendingTransaction.fromJson(e))
        .toList();
  }

  Future<String> getVerificationToken(String accountId) async =>
      (await _get('/accounts/$accountId/verification-token'))['item'];

  Future<void> deleteVerificationToken(String accountId) =>
      _delete('/accounts/$accountId/verification-token').then((_) {});

  Future<void> deleteAuthorisation(String id) =>
      _delete('/authorisations/$id').then((_) {});

  Future<Page<Transaction>> getTransactions({
    String? start,
    String? end,
    String? cursor,
  }) async {
    final data =
        await _get('/transactions', params: _range(start, end, cursor: cursor));
    return Page(
      items: (data['items'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e))
          .toList(),
      nextCursor: data['cursor']?['next'],
    );
  }

  Future<Transaction> getTransaction(String id) async =>
      Transaction.fromJson((await _get('/transactions/$id'))['item']);

  Future<List<PendingTransaction>> getPendingTransactions() async {
    final data = await _get('/transactions/pending');
    return (data['items'] as List<dynamic>)
        .map((e) => PendingTransaction.fromJson(e))
        .toList();
  }

  Future<List<Transaction>> getTransactionsByIds(List<String> ids) async {
    final data = await _post('/transactions/ids', body: ids);
    return (data['items'] as List<dynamic>)
        .map((e) => Transaction.fromJson(e))
        .toList();
  }

  Future<List<Party>> getParties() async {
    final data = await _get('/parties');
    return (data['items'] as List<dynamic>)
        .map((e) => Party.fromJson(e))
        .toList();
  }

  Future<void> refreshAll() => _post('/refresh').then((_) {});

  Future<void> refresh(String id) => _post('/refresh/$id').then((_) {});

  Future<void> reportTransaction(
    String transactionId, {
    required String type,
    String? otherId,
    List<String>? fields,
    String? comment,
  }) =>
      _post('/support/$transactionId', body: {
        'type': type,
        if (otherId != null) 'other_id': otherId,
        if (fields != null && fields.isNotEmpty) 'fields': fields,
        if (comment != null) 'comment': comment,
      }).then((_) {});

  Future<void> revokeToken() => _delete('/token').then((_) {});

  Future<Map<String, dynamic>> verifyName({
    String? givenName,
    String? middleName,
    required String familyName,
    List<String>? initials,
  }) =>
      _post('/verify/name', body: {
        if (givenName != null && givenName.isNotEmpty) 'given_name': givenName,
        if (middleName != null && middleName.isNotEmpty)
          'middle_name': middleName,
        'family_name': familyName,
        if (initials != null && initials.isNotEmpty) 'initials': initials,
      });

  Future<Map<String, dynamic>> verifyNameForAccount(
    String accountId, {
    String? givenName,
    String? middleName,
    required String familyName,
    List<String>? initials,
  }) =>
      _post('/verify/name/$accountId', body: {
        if (givenName != null && givenName.isNotEmpty) 'given_name': givenName,
        if (middleName != null && middleName.isNotEmpty)
          'middle_name': middleName,
        'family_name': familyName,
        if (initials != null && initials.isNotEmpty) 'initials': initials,
      });

  Future<List<NzfccCategory>> getCategories() async {
    final data = await _get('/categories', appAuth: true);
    return (data['items'] as List<dynamic>)
        .map((e) => NzfccCategory.fromJson(e))
        .toList();
  }

  Future<NzfccCategory> getCategory(String id) async =>
      NzfccCategory.fromJson((await _get('/categories/$id', appAuth: true))['item']);

  Future<List<Connection>> getConnections() async {
    final data = await _get('/connections', appAuth: true);
    return (data['items'] as List<dynamic>)
        .map((e) => Connection.fromJson(e))
        .toList();
  }

  Future<Connection> getConnection(String id) async =>
      Connection.fromJson((await _get('/connections/$id', appAuth: true))['item']);

  Future<Map<String, dynamic>> getIdentity(String id) =>
      _get('/identity/$id', appAuth: true);

  Future<Map<String, dynamic>> getKey(String id) =>
      _get('/keys/$id', appAuth: true);

  static Future<Map<String, dynamic>> exchangeToken({
    required String code,
    required String redirectUri,
    required String appToken,
    required String appSecret,
  }) async {
    final res = await http.post(
      Uri.parse('$_baseUrl/token'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
        'client_id': appToken,
        'client_secret': appSecret,
      }),
    );
    return json.decode(res.body) as Map<String, dynamic>;
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => 'ApiException($statusCode): $message';
}
