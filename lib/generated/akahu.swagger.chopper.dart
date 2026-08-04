// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

part of 'akahu.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$Akahu extends Akahu {
  _$Akahu([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = Akahu;

  @override
  Future<Response<AccountsGet$Response>> _accountsGet({
    String? xAkahuId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get a list of all accounts that the user has connected to your application.

> ℹ️
>
> The format for the returned account depends on the permissions you have!

For more details see:
  - [📚 Accessing account data guide](/docs/accessing-account-data)
  - [📖 Account model](/docs/the-account-model)''',
      summary: 'List all accounts',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Accounts"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/accounts');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<AccountsGet$Response, AccountsGet$Response>($request);
  }

  @override
  Future<Response<AccountsIdGet$Response>> _accountsIdGet({
    String? xAkahuId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get an individual account that the user has connected to your application.

> ℹ️
>
> The format for the returned account depends on the permissions you have!

For more details see:
  - [📚 Accessing account data guide](/docs/accessing-account-data)
  - [📖 Account model](/docs/the-account-model)''',
      summary: 'Get account',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Accounts"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/accounts/${id}');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<AccountsIdGet$Response, AccountsIdGet$Response>(
      $request,
    );
  }

  @override
  Future<Response<AccountsIdVerificationTokenGet$Response>>
  _accountsIdVerificationTokenGet({
    String? xAkahuId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get an account verification token for an account so it can be used as a payee in either a one-off payment or enduring payment consent request.

Account verification tokens can only be generated for BECS-identifiable bank accounts (i.e. regular NZ bank accounts) and require that your application has permission to read the account holder name.''',
      summary: 'Get account verification token',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Accounts"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/accounts/${id}/verification-token');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<
      AccountsIdVerificationTokenGet$Response,
      AccountsIdVerificationTokenGet$Response
    >($request);
  }

  @override
  Future<Response<AccountsIdVerificationTokenDelete$Response>>
  _accountsIdVerificationTokenDelete({
    String? xAkahuId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''> ⚠️
>
> This endpoint is deprecated.
> <pre></pre>
> Accounts connected via an official open banking connection can\'t be revoked on an individual basis via API. Calling this endpoint for accounts that have a `connection_type` of `official` will result in a 400 error response.
> <pre></pre>
> Use one of these alternative options to the update the accounts connected via `official` connections:
>  - Send the user to the [📚 authorisation flow](/docs/authorizing-with-oauth2) where they can reduce the scope of the authorisation via their bank.
>  - Use the [Revoke Access To Authorisation](/reference/delete_authorisations-id) endpoint to revoke the entire authorisation.

Revoke your application\'s access to one of the user\'s connected accounts and its associated data, including transactions.

Use this if you no longer require access to the consented account data.

For more details see:
  - [📚 Accessing account data guide](/docs/accessing-account-data)
  - [📖 Account model](/docs/the-account-model)''',
      summary: 'Revoke access to account',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Accounts"],
      deprecated: true,
    ),
  }) {
    final Uri $url = Uri.parse('/accounts/${id}/verification-token');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<
      AccountsIdVerificationTokenDelete$Response,
      AccountsIdVerificationTokenDelete$Response
    >($request);
  }

  @override
  Future<Response<AccountsIdPaymentConsentsConsentIdDelete$Response>>
  _accountsIdPaymentConsentsConsentIdDelete({
    String? xAkahuId,
    required String? id,
    required String? consentId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Revoke one of the enduring payment consents granted for an account.

You can find the `_id` of a consent by looking at the `payment_consents` array on the [account](/reference/get_accounts-id) it belongs to.

Revoking a consent immediately prevents it from being used to initiate any further payments. This does not affect any other consents on the account, or the account\'s connection to your application.

For more details see:
  - [📚 Requesting Payment Consent guide](/docs/enduring-payments-authorisation)
  - [📖 Account model](/docs/the-account-model)''',
      summary: 'Revoke a payment consent',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Accounts"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/accounts/${id}/payment-consents/${consentId}');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<
      AccountsIdPaymentConsentsConsentIdDelete$Response,
      AccountsIdPaymentConsentsConsentIdDelete$Response
    >($request);
  }

  @override
  Future<Response<AuthorisationsIdDelete$Response>> _authorisationsIdDelete({
    String? xAkahuId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''A user\'s accounts are connected to Akahu via an authorisation with their financial institution. Multiple accounts can be connected using a single authorisation.

This endpoint will revoke your application\'s access to one of the user\'s consented authorisations. After calling this endpoint, your application will no longer have access to the accounts connected via that authorisation (including their associated data and transactions).

You can find an authorisation for an account by looking at the `_authorisation` field on each account.

> ℹ️
>
> Users can also update their authorisations via the [📚 authorisation flow](/docs/authorizing-with-oauth2). The authorisation flow is the only way that users can add or remove access for individual accounts rather than a whole authorisation.

For more details see:
  - [📚 Accessing account data guide](/docs/accessing-account-data)
  - [📖 Account model](/docs/the-account-model)''',
      summary: 'Revoke access to authorisation',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Authorisations"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/authorisations/${id}');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client
        .send<AuthorisationsIdDelete$Response, AuthorisationsIdDelete$Response>(
          $request,
        );
  }

  @override
  Future<Response<Token>> _tokenPost({
    required TokenPost$RequestBody? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint is the final step in our [📖 OAuth Authentication Flow](/docs/authorizing-with-oauth2).

Use this endpoint to exchange an **Authorization Code** for a **User Access Token**, which can be used to access the rest of this API.

To ensure that your application does not retain unnecessary access to user data, [revoke](./delete_token) this access token in the event that is no longer required (e.g. the user deletes their account).

**Endpoint not applicable for Personal Apps**. See our [📚 Getting started guide](/docs/getting-started) to set up your Personal App.

> 📘
>
> **OAuth2 Error Responses**
>
> In keeping with the OAuth2 specification, error responses from this endpoint contain an error in the `error` field, rather than the `message` field used by other Akahu endpoints.

For more details see:
- [📚 OAuth Authentication Flow](/docs/authorizing-with-oauth2).
- [📖 Auth scopes](/docs/scopes)
- [📖 Token webhooks](/docs/reference-webhooks#token)
- [📚 Accessing transactional data guide](/docs/accessing-transactional-data)
- [📚 Accessing account data guide](/docs/accessing-account-data)''',
      summary: 'Exchange an Authorization Code',
      operationId: '',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Auth"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/token');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<Token, Token>($request);
  }

  @override
  Future<Response<TokenDelete$Response>> _tokenDelete({
    String? xAkahuId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Revokes the **User Access Token** that is included in the `Authorization` header of the request.

Revoking a User Access Token will remove your access to **all** of a user\'s connected account data including transactions.

> ℹ️
>
> Users can re-authorize your application\'s access to their accounts via the [📚 authorisation flow](/docs/authorizing-with-oauth2).''',
      summary: 'Revoke a token',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Auth"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/token');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<TokenDelete$Response, TokenDelete$Response>($request);
  }

  @override
  Future<Response<AuthorisationRequestSuccessResponse>> _parPost({
    required ParPost$RequestBody? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '',
      summary: 'Create a pushed authorisation request',
      operationId: '',
      consumes: [],
      produces: [],
      security: [],
      tags: ["Auth"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/par');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<
      AuthorisationRequestSuccessResponse,
      AuthorisationRequestSuccessResponse
    >($request);
  }

  @override
  Future<Response<ConnectionsGet$Response>> _connectionsGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''> ⚠️
>
> **Authentication**
> This endpoint requires [app-scoped](/reference/api-akahu-io-authentication#app-scoped-endpoints) authentication.

Gets a list of all connected financial institutions that users can connect to your Akahu application.

- [📚 Supported Integrations List](/docs/integrations#supported-integrations)''',
      summary: 'Get all connections',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["app_auth"],
      tags: ["Connections"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/connections');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<ConnectionsGet$Response, ConnectionsGet$Response>(
      $request,
    );
  }

  @override
  Future<Response<ConnectionsIdGet$Response>> _connectionsIdGet({
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''> ⚠️
>
> **Authentication**
> This endpoint requires [app-scoped](/reference/api-akahu-io-authentication#app-scoped-endpoints) authentication.

Get an individual financial institution connection.

- [📚 Supported Integrations List](/docs/integrations#supported-integrations)''',
      summary: 'Get a connection',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["app_auth"],
      tags: ["Connections"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/connections/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<ConnectionsIdGet$Response, ConnectionsIdGet$Response>(
      $request,
    );
  }

  @override
  Future<Response<CategoriesGet$Response>> _categoriesGet({
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''> ⚠️
>
> **Authentication**
> This endpoint requires [app-scoped](/reference/api-akahu-io-authentication#app-scoped-endpoints) authentication.

Gets a list of all NZFCC categories that may be returned on a transaction.

- [📚 Explore NZFCC Categories](https://nzfcc.org)''',
      summary: 'Get all categories',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["app_auth"],
      tags: ["Categories"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/categories');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<CategoriesGet$Response, CategoriesGet$Response>(
      $request,
    );
  }

  @override
  Future<Response<CategoriesIdGet$Response>> _categoriesIdGet({
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''> ⚠️
>
> **Authentication**
> This endpoint requires [app-scoped](/reference/api-akahu-io-authentication#app-scoped-endpoints) authentication.

Get an individual NZFCC Category.

- [📚 Explore NZFCC Categories](https://nzfcc.org)''',
      summary: 'Get category',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["app_auth"],
      tags: ["Categories"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/categories/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<CategoriesIdGet$Response, CategoriesIdGet$Response>(
      $request,
    );
  }

  @override
  Future<Response<RefreshPost$Response>> _refreshPost({
    String? xAkahuId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint requests a data refresh for all accounts that the user has connected to your application.

Account data such as balance and transactions are periodically refreshed by Akahu and enriched **asynchronously**, providing clean and consistent data across financial institutions.

However, there may be certain times that your app requires the most up-to-date account data possible, this endpoint allows you to request a refresh on-demand for these cases.

For more details see:
- [📚 Data Refreshes guide](/docs/data-refreshes)''',
      summary: 'Refresh all accounts',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Data Refresh"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/refresh');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<RefreshPost$Response, RefreshPost$Response>($request);
  }

  @override
  Future<Response<RefreshIdPost$Response>> _refreshIdPost({
    String? xAkahuId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint requests a data refresh for a specific financial institution or a specific account that the user has connected to your application.

#### Connection ID

Calling this endpoint with a **Connection** ID will request that Akahu performs a data refresh for all of the user\'s connected accounts that are held at the financial institution corresponding to that Connection.

#### Account ID

Calling this endpoint with an **Account** ID will request that Akahu performs a data refresh for that specific connected account and any other connected accounts that are associated with the same login credentials.

For example, if the user has shared three ASB accounts from a single set of login credentials and you request a refresh for one, the other two accounts will also be refreshed.

For more details see:
- [📚 Data Refreshes guide](/docs/data-refreshes)''',
      summary: 'Refresh Individual Accounts or Connections',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Data Refresh"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/refresh/${id}');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<RefreshIdPost$Response, RefreshIdPost$Response>(
      $request,
    );
  }

  @override
  Future<Response<IdentityIdGet$Response>> _identityIdGet({
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''> ⚠️
>
> **Authentication**
> This endpoint requires [app-scoped](/reference/api-akahu-io-authentication#app-scoped-endpoints) authentication.

Get the results of an Identity OAuth result using the authorization `code` provided upon redirection to your `redirect_uri` after the user\'s successful completion of the authorisation flow.

This can be used to verify a user\'s identity using the data that is held about them by their financial institution.

For more information about our Identity OAuth flow see our:
  - [📚 One-off Identity guide](/docs/oneoff-identity-verification)
  - [📚 Identity verification guide](/docs/identity-verification)
  - [📖 Identity model](/docs/the-oneoff-identity-result-model)''',
      summary: '[One-off access] Get identity result',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["app_auth"],
      tags: ["Identity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/identity/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<IdentityIdGet$Response, IdentityIdGet$Response>(
      $request,
    );
  }

  @override
  Future<Response<OneOffVerifyNameResult>> _identityIdVerifyNamePost({
    required String? id,
    required VerifyNameData? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''> ⚠️
>
> **Authentication**
> This endpoint requires [app-scoped](/reference/api-akahu-io-authentication#app-scoped-endpoints) authentication.

To verify your user\'s identity, you may wish to match the name that you have on file against an official record such as the bank account holder name or Party name, returned via the Identity Response.

For more details about the data returned, see:
  - [📚 One-Off Verify Name](/docs/oneoff-verify-name)
  - [📖 Identity model](/docs/the-oneoff-identity-result-model)''',
      summary: '[One-off access] Verify a name',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["app_auth"],
      tags: ["Identity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/identity/${id}/verify/name');
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      tag: swaggerMetaData,
    );
    return client.send<OneOffVerifyNameResult, OneOffVerifyNameResult>(
      $request,
    );
  }

  @override
  Future<Response<VerifyNameResult>> _verifyNamePost({
    String? xAkahuId,
    required VerifyNameData? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''To verify your user\'s identity, you may wish to match the name that you have on file against an official record such as the bank account holder name or Party name.

This will match against all available sources from all accounts that the user has connected to your app.

For more details about the data returned, see:
  - [📚 Enduring Verify Name](/docs/enduring-verify-name)''',
      summary: '[Enduring access] Verify a name',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Identity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/verify/name');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<VerifyNameResult, VerifyNameResult>($request);
  }

  @override
  Future<Response<VerifyNameResult>> _verifyNameIdPost({
    String? xAkahuId,
    required String? id,
    required VerifyNameData? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''To verify your user\'s identity, you may wish to match the name that you have on file against an official record such as the bank account holder name or Party name.

This will only use identity sources derived from the specified account, rather than all accounts.

For more details about the data returned, see:
  - [📚 Enduring Verify Name](/docs/enduring-verify-name)''',
      summary: '[Enduring access] Verify a name against an account',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Identity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/verify/name/${id}');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<VerifyNameResult, VerifyNameResult>($request);
  }

  @override
  Future<Response<PartiesGet$Response>> _partiesGet({
    String? xAkahuId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get a list of the parties who have authorised financial account connections with your app. This data is sourced from the customer profile information held by the financial institution rather than any specific account held within.

> ⚠️
>
> This data relates to the party that authorised the account connection as reported by the financial institution. Due to some quirks with the data held in bank systems, it is possible in rare cases that company details are returned instead of an individual person\'s. This can happen for small business bank accounts where a single shared login is set up for the company (rather than a proper company setup where staff have separate logins).''',
      summary: '[Enduring access] Get user identity data',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Identity"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/parties');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<PartiesGet$Response, PartiesGet$Response>($request);
  }

  @override
  Future<Response<PaymentsGet$Response>> _paymentsGet({
    String? xAkahuId,
    DateTime? start,
    DateTime? end,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get a list of the payments that your application has initiated on behalf of the user within the `start` and `end` time range.

>️ ℹ️ Time range defaults to the last 30 days.

For more details about payments see:
  - [📖 Making a payment guide](/docs/making-a-payment)
  - [📚 Payment lifecycle guide](/docs/making-a-payment#payment-lifecycle)
  - [📚 Payment webhooks](/docs/reference-webhooks#payment)''',
      summary: 'List payments',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Payments"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/payments');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
    };
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<PaymentsGet$Response, PaymentsGet$Response>($request);
  }

  @override
  Future<Response<PaymentsPost$Response>> _paymentsPost({
    String? xAkahuId,
    String? contentType,
    required PaymentsPost$RequestBody? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Initiate a payment from the user\'s connected bank account to another New Zealand bank account.

The payee bank account is not required to be connected to Akahu.

For more details about payments see:
  - [📚 Making a payment guide](/docs/making-a-payment)
  - [📚 Payment lifecycle guide](/docs/making-a-payment#payment-lifecycle)
  - [📖 Payment webhooks](/docs/reference-webhooks#payment)''',
      summary: 'Make a payment',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Payments"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/payments');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
      if (contentType != null) 'Content-Type': contentType,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<PaymentsPost$Response, PaymentsPost$Response>($request);
  }

  @override
  Future<Response<PaymentsIrdPost$Response>> _paymentsIrdPost({
    String? xAkahuId,
    String? contentType,
    required PaymentsIrdPost$RequestBody? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Initiate a tax payment from user\'s connected bank account to [🔗 Inland Revenue Department](https://www.ird.govt.nz/).

For more details about payments see:
  - [📚 Making a payment guide](/docs/making-a-payment)
  - [📚 Payment lifecycle guide](/docs/making-a-payment#payment-lifecycle)
  - [📖 Payment webhooks](/docs/reference-webhooks#payment)''',
      summary: 'Make a payment to IRD',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Payments"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/payments/ird');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
      if (contentType != null) 'Content-Type': contentType,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<PaymentsIrdPost$Response, PaymentsIrdPost$Response>(
      $request,
    );
  }

  @override
  Future<Response<PaymentsIdGet$Response>> _paymentsIdGet({
    String? xAkahuId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get an individual payment that your application has initiated on behalf of the user.

For more details about payments see:
  - [📖 Making a payment guide](/docs/making-a-payment)
  - [📚 Payment lifecycle guide](/docs/making-a-payment#payment-lifecycle)
  - [📚 Payment webhooks](/docs/reference-webhooks#payment)''',
      summary: 'Get a payment',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Payments"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/payments/${id}');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<PaymentsIdGet$Response, PaymentsIdGet$Response>(
      $request,
    );
  }

  @override
  Future<Response<PaymentsIdCancelPut$Response>> _paymentsIdCancelPut({
    String? xAkahuId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''This endpoint cancels a user\'s payment that is in the `PENDING_APPROVAL` state.

For more details about payments see:
  - [📚 Payment lifecycle guide](/docs/making-a-payment#payment-lifecycle)
  - [📚 Payment webhooks](/docs/reference-webhooks#payment)
  - [📖 Making a payment guide](/docs/making-a-payment)''',
      summary: 'Cancel a payment',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Payments"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/payments/${id}/cancel');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'PUT',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client
        .send<PaymentsIdCancelPut$Response, PaymentsIdCancelPut$Response>(
          $request,
        );
  }

  @override
  Future<Response<TransactionsGet$Response>> _transactionsGet({
    String? xAkahuId,
    DateTime? start,
    DateTime? end,
    String? cursor,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get a list of the user\'s transactions within the `start` and `end` time range.

This endpoint returns **settled**\* transactions for all accounts that the user has connected to your application. See [`GET /transactions/pending`](/reference/get_transactions-pending) to also query **pending** transactions.

**Some important things to know about this endpoint**:
- The data returned may vary depending on your app\'s permissions.
- All transactions timestamps are in **UTC**.
- If `start` and `end` are not provided, all available transactions will be returned.
- The `start` query parameter is **exclusive**.
- The `end` query parameter is **inclusive**.
- All timestamps use **millisecond** resolution (i.e. `2025-01-01T11:59:59.999Z` is the instant before `2025-01-01T12:00:00.000Z`).

**Further reading**:
- [📚 Accessing transactional data guide](/docs/accessing-transactional-data)
- [📚 Pagination guide](/docs/accessing-transactional-data#pagination)
- [📖 Transaction model](/docs/the-transaction-model)
- [📖 Transaction webhooks](/docs/reference-webhooks#transaction)

> \*Both inbound and outbound transactions relating to [payments](/docs/making-a-payment) initiated via Akahu skip the `/transactions/pending` endpoint and are immediately available at this endpoint instead. This ensures that such transactions receive a stable `_id` field to assist with reconciliation. Their availability at this endpoint does not guarantee that the bank has undertaken final processing of the transaction.''',
      summary: 'Get transactions',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Transactions"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'cursor': cursor,
    };
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<TransactionsGet$Response, TransactionsGet$Response>(
      $request,
    );
  }

  @override
  Future<Response<TransactionsPendingGet$Response>> _transactionsPendingGet({
    String? xAkahuId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get a list of pending transactions from a user\'s connected accounts.

This endpoint returns pending transactions from all of a user\'s accounts that the user has connected to your application.

Pending transactions are not stable (eg. the date or description may change) due to the unreliable nature of the underlying NZ bank data.

>️ ℹ️ You can tell when we last fetched a transaction by looking at it\'s `updated_at` key.

- All transactions timestamps are in **UTC**.

For more details see:
- [📚 Accessing transactional data guide](/docs/accessing-transactional-data)
- [📚 Pending transactions guide](/docs/accessing-transactional-data#pending-transactions)
- [📖 Transaction model](/docs/the-transaction-model)''',
      summary: 'Get pending transactions',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Transactions"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/transactions/pending');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client
        .send<TransactionsPendingGet$Response, TransactionsPendingGet$Response>(
          $request,
        );
  }

  @override
  Future<Response<TransactionsIdGet$Response>> _transactionsIdGet({
    String? xAkahuId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get a single transaction from one of the user\'s connected accounts.

- Transactions will look different depending on your app\'s permissions.
- All times on the transaction are in **UTC**.

For more details see:
- [📚 Accessing transactional data guide](/docs/accessing-transactional-data)
- [📖 Transaction model](/docs/the-transaction-model)
- [📖 Transaction webhooks](/docs/reference-webhooks#transaction)''',
      summary: 'Get a transaction by ID',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Transactions"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/transactions/${id}');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<TransactionsIdGet$Response, TransactionsIdGet$Response>(
      $request,
    );
  }

  @override
  Future<Response<AccountsIdTransactionsGet$Response>>
  _accountsIdTransactionsGet({
    String? xAkahuId,
    DateTime? start,
    DateTime? end,
    String? cursor,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get a list of the user\'s transactions for a specific connected account within the `start` and `end` time range.

This endpoint returns **settled** transactions. See [`GET /accounts/{id}/transactions/pending`](/reference/get_accounts-id-transactions) to also query **pending** transactions for the account.

>️ ℹ️ Time range defaults to the entire range [accessible to your app](/docs/accessing-transactional-data#getting-a-date-range).

Some important things to know when querying transactions:
- Transactions will look different depending on your app\'s permissions.
- All transactions timestamps are in **UTC**.
- The `start` query parameter is **exclusive**.
- The `end` query parameter is **inclusive**.
- All Akahu timestamps use **millisecond** resolution (i.e. `2025-01-01T11:59:59.999Z` is the instant before `2025-01-01T12:00:00.000Z`).

For more details see:
- [📚 Accessing transactional data guide](/docs/accessing-transactional-data)
- [📚 Pagination guide](/docs/accessing-transactional-data#pagination)
- [📖 Transaction model](/docs/the-transaction-model)
- [📖 Transaction webhooks](/docs/reference-webhooks#transaction)''',
      summary: 'Get transactions by account',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Transactions"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/accounts/${id}/transactions');
    final Map<String, dynamic> $params = <String, dynamic>{
      'start': start,
      'end': end,
      'cursor': cursor,
    };
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<
      AccountsIdTransactionsGet$Response,
      AccountsIdTransactionsGet$Response
    >($request);
  }

  @override
  Future<Response<AccountsIdTransactionsPendingGet$Response>>
  _accountsIdTransactionsPendingGet({
    String? xAkahuId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get a list of the user\'s pending transactions for a specific connected account.

Pending transactions are not stable (eg. the date or description may change) due to the unreliable nature of the underlying NZ bank data.

>️ ℹ️ You can tell when we last fetched a transaction by looking at it\'s `updated_at` key.

- All transactions timestamps are in **UTC**.

For more details see:
- [📚 Accessing transactional data guide](/docs/accessing-transactional-data)
- [📚 Pending transactions guide](/docs/accessing-transactional-data#pending-transactions)
- [📖 Transaction model](/docs/the-transaction-model)''',
      summary: 'Get pending transactions by account',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Transactions"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/accounts/${id}/transactions/pending');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<
      AccountsIdTransactionsPendingGet$Response,
      AccountsIdTransactionsPendingGet$Response
    >($request);
  }

  @override
  Future<Response<TransactionsIdsPost$Response>> _transactionsIdsPost({
    String? xAkahuId,
    String? contentType,
    required List<String>? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Gets a list of the user\'s transactions that match the provided list of Akahu transaction identifiers.

The intended use for this endpoint is to assist in [📖 transaction webhooks](/docs/reference-webhooks#transaction).
When a webhook arrives it contains a list of changed transaction identifiers, which you can simply pass unchanged to this endpoint to retrieve the full transactions.

This endpoint is unusual, in that it is really a `GET`, dressed up as a `POST`.
The reason we do this is to avoid having to put all of the IDs in query parameters, which could potentially come up against maximum URL length constraints.

- Transactions will look different depending on your app\'s permissions.
- All times on the transaction are in **UTC**.

For more details see:
- [📚 Accessing transactional data guide](/docs/accessing-transactional-data)
- [📖 Transaction model](/docs/the-transaction-model)
- [📖 Transaction webhooks](/docs/reference-webhooks#transaction)''',
      summary: 'Get transactions by IDs',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Transactions"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/transactions/ids');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
      if (contentType != null) 'Content-Type': contentType,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client
        .send<TransactionsIdsPost$Response, TransactionsIdsPost$Response>(
          $request,
        );
  }

  @override
  Future<Response<MeGet$Response>> _meGet({
    String? xAkahuId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Get information about the Akahu user and the access they have provided.

> ℹ️
>
> The `email` key will only be visible if you have the required permissions.''',
      summary: 'Get current user',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Me"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/me');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<MeGet$Response, MeGet$Response>($request);
  }

  @override
  Future<Response<WebhooksGet$Response>> _webhooksGet({
    String? xAkahuId,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Gets the active webhook subscriptions that your app has created for the user.

For more details about webhooks see:
  - [📖 Webhooks reference](/docs/reference-webhooks)
  - [📖 Webhooks events](/reference-webhooks#token)''',
      summary: 'Get all webhooks',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Webhooks"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/webhooks');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<WebhooksGet$Response, WebhooksGet$Response>($request);
  }

  @override
  Future<Response<WebhooksPost$Response>> _webhooksPost({
    String? xAkahuId,
    String? contentType,
    required WebhooksPost$RequestBody? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''> ℹ️
>
> Akahu\'s webhooks are unusual in that they need to be initialised **per user**, requiring a new webhook subscription for each event type you wish to receive for each user.

Register a new webhook subscription for the user, allowing your application to receive events on the following webhook types:

  - `TOKEN`
  - `ACCOUNT`
  - `TRANSACTION`
  - `PAYMENT`
  - `TRANSFER`

> ℹ️
>
> It is a good idea to use the `state` field to store a unique identifier related to your end user, allowing you to determine on an arrival of a webhook event which user of your application needs to be updated or notified.


For more details about webhooks see:
  - [📖 Webhooks reference](/docs/reference-webhooks)
  - [📖 Webhooks events](/reference-webhooks#token)''',
      summary: 'Subscribe to webhook',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Webhooks"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/webhooks');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
      if (contentType != null) 'Content-Type': contentType,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<WebhooksPost$Response, WebhooksPost$Response>($request);
  }

  @override
  Future<Response<KeysIdGet$Response>> _keysIdGet({
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''> ⚠️
>
> **Authentication**
> This endpoint requires [app-scoped](/reference/api-akahu-io-authentication#app-scoped-endpoints) authentication.

Get one of the public keys that Akahu uses to sign webhooks.''',
      summary: 'Get public key',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["app_auth"],
      tags: ["Webhooks"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/keys/${id}');
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      tag: swaggerMetaData,
    );
    return client.send<KeysIdGet$Response, KeysIdGet$Response>($request);
  }

  @override
  Future<Response<WebhooksIdDelete$Response>> _webhooksIdDelete({
    String? xAkahuId,
    required String? id,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description:
          '''Delete a webhook subscription that your application has previously created for the user.

For more details about webhooks see:
  - [📖 Webhooks reference](/docs/reference-webhooks)
  - [📖 Webhooks events](/reference-webhooks#token)''',
      summary: 'Unsubscribe from webhook',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Webhooks"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/webhooks/${id}');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'DELETE',
      $url,
      client.baseUrl,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<WebhooksIdDelete$Response, WebhooksIdDelete$Response>(
      $request,
    );
  }

  @override
  Future<Response<WebhookEventsGet$Response>> _webhookEventsGet({
    String? xAkahuId,
    String? status,
    DateTime? start,
    DateTime? end,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''> ⚠️
>
> **Authentication**
> This endpoint requires [app-scoped](/reference/api-akahu-io-authentication#app-scoped-endpoints) authentication.

Returns a list of webhook events that have been published to your application by Akahu within the `start` and `end` time range.

>️ ℹ️ Time range defaults to the last 30 days.

For more details about webhooks see:
  - [📖 Webhooks reference](/docs/reference-webhooks)
  - [📖 Webhooks events](/reference-webhooks#token)''',
      summary: 'Get webhook events',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["app_auth"],
      tags: ["Webhooks"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/webhook-events');
    final Map<String, dynamic> $params = <String, dynamic>{
      'status': status,
      'start': start,
      'end': end,
    };
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<WebhookEventsGet$Response, WebhookEventsGet$Response>(
      $request,
    );
  }

  @override
  Future<Response<SupportTransactionIdPost$Response>>
  _supportTransactionIdPost({
    String? xAkahuId,
    required String? transactionId,
    required SupportTransactionIdPost$RequestBody? body,
    SwaggerMetaData swaggerMetaData = const SwaggerMetaData(
      description: '''Let us know when we get something wrong 🙏.
The request body should match the type of request you are making:

### Notify Us Of A Duplicate ###

| Parameter  | Example                             | Description                                                                            |
|:-----------|:------------------------------------|:---------------------------------------------------------------------------------------|
| `type`     | `"DUPLICATE"`                       | Let us know that two Akahu transactions are actually the same transaction in the bank. |
| `other_id` | `"trans_1111111111111111111111111"` | The duplicate transaction ID.                                                          |

### Notify Us Of An Enrichment Error ###

| Parameter  | Example                              | Description                                           |
|:-----------|:-------------------------------------|:------------------------------------------------------|
| `type`     | `"ENRICHMENT_ERROR"`                 | Let us know when we get something wrong.              |
| `fields`   | `[ "merchant.name"]`                 | A list of dot-separated paths to the incorrect values |
| `comment`  | `"X should be Y"`                    | Additional info you want to include.                  |

### Suggest An Improvement To Enrichment Data ###

| Parameter  | Example                        | Description                                                                                           |
|:-----------|:-------------------------------|:------------------------------------------------------------------------------------------------------|
| `type`     | `"ENRICHMENT_SUGGESTION"`      | Let us know about further enrichment that can be applied to this transaction transaction in the bank. |
| `comment`  | `"Can you please add X to Y?"` | The enrichment information you want to tell us about.                                                 |''',
      summary: 'Transaction support',
      operationId: '',
      consumes: [],
      produces: [],
      security: ["user_token"],
      tags: ["Support"],
      deprecated: false,
    ),
  }) {
    final Uri $url = Uri.parse('/support/${transactionId}');
    final Map<String, String> $headers = {
      if (xAkahuId != null) 'X-Akahu-Id': xAkahuId,
    };
    final $body = body;
    final Request $request = Request(
      'POST',
      $url,
      client.baseUrl,
      body: $body,
      headers: $headers,
      tag: swaggerMetaData,
    );
    return client.send<
      SupportTransactionIdPost$Response,
      SupportTransactionIdPost$Response
    >($request);
  }
}
