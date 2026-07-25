import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/account.dart';
import '../models/page.dart';
import '../models/transaction.dart';
import '../models/user.dart';

class AkahuApi {
  static const _baseUrl = 'https://api.akahu.io/v1';

  final String _userToken;
  final String _appToken;
  final http.Client _client = http.Client();

  AkahuApi({
    required String userToken,
    required String appToken,
  })  : _userToken = userToken,
        _appToken = appToken;

  Map<String, String> get _userHeaders => {
        'Authorization': 'Bearer $_userToken',
        'X-Akahu-Id': _appToken,
      };

  Future<Map<String, dynamic>> _request(
    String method,
    String path, {
    Map<String, String>? params,
    Object? body,
    bool noAuth = false,
  }) async {
    final uri = Uri.parse('$_baseUrl$path')
        .replace(queryParameters: params != null && params.isNotEmpty ? params : null);
    final headers = <String, String>{
      if (!noAuth) ..._userHeaders,
      if (body != null) 'Content-Type': 'application/json',
    };
    final res = await switch (method) {
      'GET' => _client.get(uri, headers: headers),
      'POST' => _client.post(uri, headers: headers,
          body: body != null ? json.encode(body) : null),
      'PUT' => _client.put(uri, headers: headers,
          body: body != null ? json.encode(body) : null),
      'DELETE' => _client.delete(uri, headers: headers),
      _ => throw ArgumentError('Unsupported method $method'),
    };
    return _parseResponse(res);
  }

  Future<Map<String, dynamic>> _get(String path,
          {Map<String, String>? params}) =>
      _request('GET', path, params: params);

  Future<Map<String, dynamic>> _post(String path,
          {Object? body, bool noAuth = false}) =>
      _request('POST', path, body: body, noAuth: noAuth);

  Future<Map<String, dynamic>> _delete(String path) =>
      _request('DELETE', path);

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

  void close() => _client.close();
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => 'ApiException($statusCode): $message';
}
