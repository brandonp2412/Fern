import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/account.dart';
import '../models/transaction.dart';
import '../models/user.dart';

class AkahuApi {
  static const _baseUrl = 'https://api.akahu.io/v1';

  final String _userToken;
  final String _appToken;
  final String _appSecret;

  // ignore: unused_element
  String get _basicAuth => 'Basic ${base64Encode(utf8.encode('$_appToken:$_appSecret'))}';

  AkahuApi({
    required this._userToken,
    required this._appToken,
    required this._appSecret,
  });

  Map<String, String> get _headers => {
        'Authorization': 'Bearer $_userToken',
        'X-Akahu-Id': _appToken,
      };

  Future<User> getMe() async {
    final res = await http.get(
      Uri.parse('$_baseUrl/me'),
      headers: _headers,
    );
    final data = _parseResponse(res);
    return User.fromJson(data['item']);
  }

  Future<List<Account>> getAccounts() async {
    final res = await http.get(
      Uri.parse('$_baseUrl/accounts'),
      headers: _headers,
    );
    final data = _parseResponse(res);
    final items = data['items'] as List<dynamic>;
    return items.map((e) => Account.fromJson(e)).toList();
  }

  Future<List<Transaction>> getAccountTransactions(
    String accountId, {
    int limit = 5,
  }) async {
    final uri = Uri.parse('$_baseUrl/accounts/$accountId/transactions');
    final res = await http.get(uri, headers: _headers);
    final data = _parseResponse(res);
    final items = data['items'] as List<dynamic>;
    final txns = items.map((e) => Transaction.fromJson(e)).toList();
    return txns.take(limit).toList();
  }

  Future<List<Transaction>> getTransactions({
    String? start,
    String? end,
    String? cursor,
    int? limit,
  }) async {
    final params = <String, String>{};
    if (start != null) params['start'] = start;
    if (end != null) params['end'] = end;
    if (cursor != null) params['cursor'] = cursor;
    final uri = Uri.parse('$_baseUrl/transactions')
        .replace(queryParameters: params.isNotEmpty ? params : null);
    final res = await http.get(uri, headers: _headers);
    final data = _parseResponse(res);
    final items = data['items'] as List<dynamic>;
    final txns = items.map((e) => Transaction.fromJson(e)).toList();
    return limit != null ? txns.take(limit).toList() : txns;
  }

  Map<String, dynamic> _parseResponse(http.Response res) {
    if (res.statusCode == 200) {
      final data = json.decode(res.body) as Map<String, dynamic>;
      if (data['success'] == true) {
        return data;
      }
      throw ApiException(
          data['message'] ?? 'Unknown API error', res.statusCode);
    }
    throw ApiException('HTTP ${res.statusCode}: ${res.body}', res.statusCode);
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => 'ApiException($statusCode): $message';
}
