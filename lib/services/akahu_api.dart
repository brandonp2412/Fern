import 'package:chopper/chopper.dart' as chopper;
import 'package:http/http.dart' as http;

import '../generated/akahu.enums.swagger.dart' as gen_enums;
import '../generated/akahu.swagger.dart' as gen;
import '../models/account.dart';
import '../models/page.dart';
import '../models/transaction.dart';
import '../models/user.dart';

class AkahuApi {
  static const _baseUrl = 'https://api.akahu.io/v1';

  final String _appToken;
  final gen.Akahu _service;
  final http.Client _httpClient;

  factory AkahuApi({
    required String userToken,
    required String appToken,
    http.Client? client,
  }) {
    final c = client ?? http.Client();
    return AkahuApi._(
      appToken: appToken,
      client: c,
      service: gen.Akahu.create(
        baseUrl: Uri.parse(_baseUrl),
        httpClient: c,
        interceptors: [
          chopper.HeadersInterceptor({'Authorization': 'Bearer $userToken'}),
        ],
      ),
    );
  }

  AkahuApi._({
    required this._appToken,
    required http.Client client,
    required this._service,
  }) : _httpClient = client;

  T _ok<T>(chopper.Response<T> res) {
    final body = res.body;
    final code = res.base.statusCode;
    if (code >= 200 && code < 300 && (body as dynamic).success == true) {
      return body!;
    }
    throw ApiException(
      (body as dynamic)?.message?.toString() ?? 'HTTP $code',
      code,
    );
  }

  Future<User> getMe() async {
    final body = _ok(await _service.meGet(xAkahuId: _appToken));
    return User.fromJson(body.item!.toJson());
  }

  Future<List<Account>> getAccounts() async {
    final body = _ok(await _service.accountsGet(xAkahuId: _appToken));
    return body.items!.map((e) => Account.fromJson(e.toJson())).toList();
  }

  Future<Account> getAccount(String id) async {
    final body = _ok(await _service.accountsIdGet(xAkahuId: _appToken, id: id));
    return Account.fromJson(body.item!.toJson());
  }

  Future<Page<Transaction>> getAccountTransactions(
    String accountId, {
    String? start,
    String? end,
    String? cursor,
  }) async {
    final body = _ok(
      await _service.accountsIdTransactionsGet(
        xAkahuId: _appToken,
        id: accountId,
        start: start != null ? DateTime.tryParse(start) : null,
        end: end != null ? DateTime.tryParse(end) : null,
        cursor: cursor,
      ),
    );
    return Page(
      items: body.items!.map((e) => Transaction.fromJson(e.toJson())).toList(),
      nextCursor: body.cursor?.next,
    );
  }

  Future<List<PendingTransaction>> getAccountPendingTransactions(
    String accountId,
  ) async {
    final body = _ok(
      await _service.accountsIdTransactionsPendingGet(
        xAkahuId: _appToken,
        id: accountId,
      ),
    );
    return body.items!
        .map((e) => PendingTransaction.fromJson(e.toJson()))
        .toList();
  }

  Future<void> deleteAuthorisation(String id) async {
    _ok(await _service.authorisationsIdDelete(xAkahuId: _appToken, id: id));
  }

  Future<Page<Transaction>> getTransactions({
    String? start,
    String? end,
    String? cursor,
  }) async {
    final body = _ok(
      await _service.transactionsGet(
        xAkahuId: _appToken,
        start: start != null ? DateTime.tryParse(start) : null,
        end: end != null ? DateTime.tryParse(end) : null,
        cursor: cursor,
      ),
    );
    return Page(
      items: body.items!.map((e) => Transaction.fromJson(e.toJson())).toList(),
      nextCursor: body.cursor?.next,
    );
  }

  Future<Transaction> getTransaction(String id) async {
    final body = _ok(
      await _service.transactionsIdGet(xAkahuId: _appToken, id: id),
    );
    return Transaction.fromJson(body.item!.toJson());
  }

  Future<List<PendingTransaction>> getPendingTransactions() async {
    final body = _ok(
      await _service.transactionsPendingGet(xAkahuId: _appToken),
    );
    return body.items!
        .map((e) => PendingTransaction.fromJson(e.toJson()))
        .toList();
  }

  Future<List<Transaction>> getTransactionsByIds(List<String> ids) async {
    final body = _ok(
      await _service.transactionsIdsPost(xAkahuId: _appToken, body: ids),
    );
    return body.items!.map((e) => Transaction.fromJson(e.toJson())).toList();
  }

  Future<void> refreshAll() async {
    _ok(await _service.refreshPost(xAkahuId: _appToken));
  }

  Future<void> refresh(String id) async {
    _ok(await _service.refreshIdPost(xAkahuId: _appToken, id: id));
  }

  Future<void> reportTransaction(
    String transactionId, {
    required String type,
    String? otherId,
    List<String>? fields,
    String? comment,
  }) async {
    _ok(
      await _service.supportTransactionIdPost(
        xAkahuId: _appToken,
        transactionId: transactionId,
        body: gen.SupportTransactionIdPost$RequestBody(
          type: gen_enums.SupportTransactionIdPost$RequestBodyType.values
              .firstWhere(
                (e) => e.value == type,
                orElse: () =>
                    throw ArgumentError('Unknown support type: $type'),
              ),
          otherId: otherId,
          fields: fields,
          comment: comment,
        ),
      ),
    );
  }

  Future<void> revokeToken() async {
    _ok(await _service.tokenDelete(xAkahuId: _appToken));
  }

  void close() => _httpClient.close();
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => 'ApiException($statusCode): $message';
}
