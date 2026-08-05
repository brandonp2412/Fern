// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element_parameter

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';

import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:chopper/chopper.dart' as chopper;
import 'akahu.enums.swagger.dart' as enums;
import 'akahu.metadata.swagger.dart';
export 'akahu.enums.swagger.dart';

part 'akahu.swagger.chopper.dart';
part 'akahu.swagger.g.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Akahu extends ChopperService {
  static Akahu create({
    ChopperClient? client,
    http.Client? httpClient,
    Authenticator? authenticator,
    ErrorConverter? errorConverter,
    Converter? converter,
    Uri? baseUrl,
    List<Interceptor>? interceptors,
  }) {
    if (client != null) {
      return _$Akahu(client);
    }

    final newClient = ChopperClient(
      services: [_$Akahu()],
      converter: converter ?? $JsonSerializableConverter(),
      interceptors: interceptors ?? [],
      client: httpClient,
      authenticator: authenticator,
      errorConverter: errorConverter,
      baseUrl: baseUrl ?? Uri.parse('http://'),
    );
    return _$Akahu(newClient);
  }

  ///List all accounts
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<AccountsGet$Response>> accountsGet({
    String? xAkahuId,
  }) {
    generatedMapping.putIfAbsent(
      AccountsGet$Response,
      () => AccountsGet$Response.fromJsonFactory,
    );

    return _accountsGet(xAkahuId: xAkahuId?.toString());
  }

  ///List all accounts
  ///@param X-Akahu-Id Your **App ID Token**.
  @GET(path: '/accounts')
  Future<chopper.Response<AccountsGet$Response>> _accountsGet({
    @Header('X-Akahu-Id') String? xAkahuId,
    @chopper.Tag()
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
  });

  ///Get account
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<AccountsIdGet$Response>> accountsIdGet({
    String? xAkahuId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      AccountsIdGet$Response,
      () => AccountsIdGet$Response.fromJsonFactory,
    );

    return _accountsIdGet(xAkahuId: xAkahuId?.toString(), id: id);
  }

  ///Get account
  ///@param X-Akahu-Id Your **App ID Token**.
  @GET(path: '/accounts/{id}')
  Future<chopper.Response<AccountsIdGet$Response>> _accountsIdGet({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///Get account verification token
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<AccountsIdVerificationTokenGet$Response>>
  accountsIdVerificationTokenGet({String? xAkahuId, required String? id}) {
    generatedMapping.putIfAbsent(
      AccountsIdVerificationTokenGet$Response,
      () => AccountsIdVerificationTokenGet$Response.fromJsonFactory,
    );

    return _accountsIdVerificationTokenGet(
      xAkahuId: xAkahuId?.toString(),
      id: id,
    );
  }

  ///Get account verification token
  ///@param X-Akahu-Id Your **App ID Token**.
  @GET(path: '/accounts/{id}/verification-token')
  Future<chopper.Response<AccountsIdVerificationTokenGet$Response>>
  _accountsIdVerificationTokenGet({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///Revoke access to account
  ///@param X-Akahu-Id Your **App ID Token**.
  @deprecated
  Future<chopper.Response<AccountsIdVerificationTokenDelete$Response>>
  accountsIdVerificationTokenDelete({String? xAkahuId, required String? id}) {
    generatedMapping.putIfAbsent(
      AccountsIdVerificationTokenDelete$Response,
      () => AccountsIdVerificationTokenDelete$Response.fromJsonFactory,
    );

    return _accountsIdVerificationTokenDelete(
      xAkahuId: xAkahuId?.toString(),
      id: id,
    );
  }

  ///Revoke access to account
  ///@param X-Akahu-Id Your **App ID Token**.
  @deprecated
  @DELETE(path: '/accounts/{id}/verification-token')
  Future<chopper.Response<AccountsIdVerificationTokenDelete$Response>>
  _accountsIdVerificationTokenDelete({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///Revoke a payment consent
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<AccountsIdPaymentConsentsConsentIdDelete$Response>>
  accountsIdPaymentConsentsConsentIdDelete({
    String? xAkahuId,
    required String? id,
    required String? consentId,
  }) {
    generatedMapping.putIfAbsent(
      AccountsIdPaymentConsentsConsentIdDelete$Response,
      () => AccountsIdPaymentConsentsConsentIdDelete$Response.fromJsonFactory,
    );

    return _accountsIdPaymentConsentsConsentIdDelete(
      xAkahuId: xAkahuId?.toString(),
      id: id,
      consentId: consentId,
    );
  }

  ///Revoke a payment consent
  ///@param X-Akahu-Id Your **App ID Token**.
  @DELETE(path: '/accounts/{id}/payment-consents/{consent_id}')
  Future<chopper.Response<AccountsIdPaymentConsentsConsentIdDelete$Response>>
  _accountsIdPaymentConsentsConsentIdDelete({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Path('id') required String? id,
    @Path('consent_id') required String? consentId,
    @chopper.Tag()
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
  });

  ///Revoke access to authorisation
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<AuthorisationsIdDelete$Response>>
  authorisationsIdDelete({String? xAkahuId, required String? id}) {
    generatedMapping.putIfAbsent(
      AuthorisationsIdDelete$Response,
      () => AuthorisationsIdDelete$Response.fromJsonFactory,
    );

    return _authorisationsIdDelete(xAkahuId: xAkahuId?.toString(), id: id);
  }

  ///Revoke access to authorisation
  ///@param X-Akahu-Id Your **App ID Token**.
  @DELETE(path: '/authorisations/{id}')
  Future<chopper.Response<AuthorisationsIdDelete$Response>>
  _authorisationsIdDelete({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///Exchange an Authorization Code
  Future<chopper.Response<Token>> tokenPost({
    required TokenPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(Token, () => Token.fromJsonFactory);

    return _tokenPost(body: body);
  }

  ///Exchange an Authorization Code
  @POST(path: '/token', optionalBody: true)
  Future<chopper.Response<Token>> _tokenPost({
    @Body() required TokenPost$RequestBody? body,
    @chopper.Tag()
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
  });

  ///Revoke a token
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<TokenDelete$Response>> tokenDelete({
    String? xAkahuId,
  }) {
    generatedMapping.putIfAbsent(
      TokenDelete$Response,
      () => TokenDelete$Response.fromJsonFactory,
    );

    return _tokenDelete(xAkahuId: xAkahuId?.toString());
  }

  ///Revoke a token
  ///@param X-Akahu-Id Your **App ID Token**.
  @DELETE(path: '/token')
  Future<chopper.Response<TokenDelete$Response>> _tokenDelete({
    @Header('X-Akahu-Id') String? xAkahuId,
    @chopper.Tag()
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
  });

  ///Create a pushed authorisation request
  Future<chopper.Response<AuthorisationRequestSuccessResponse>> parPost({
    required ParPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      AuthorisationRequestSuccessResponse,
      () => AuthorisationRequestSuccessResponse.fromJsonFactory,
    );

    return _parPost(body: body);
  }

  ///Create a pushed authorisation request
  @POST(path: '/par', optionalBody: true)
  Future<chopper.Response<AuthorisationRequestSuccessResponse>> _parPost({
    @Body() required ParPost$RequestBody? body,
    @chopper.Tag()
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
  });

  ///Get all connections
  Future<chopper.Response<ConnectionsGet$Response>> connectionsGet() {
    generatedMapping.putIfAbsent(
      ConnectionsGet$Response,
      () => ConnectionsGet$Response.fromJsonFactory,
    );

    return _connectionsGet();
  }

  ///Get all connections
  @GET(path: '/connections')
  Future<chopper.Response<ConnectionsGet$Response>> _connectionsGet({
    @chopper.Tag()
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
  });

  ///Get a connection
  Future<chopper.Response<ConnectionsIdGet$Response>> connectionsIdGet({
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      ConnectionsIdGet$Response,
      () => ConnectionsIdGet$Response.fromJsonFactory,
    );

    return _connectionsIdGet(id: id);
  }

  ///Get a connection
  @GET(path: '/connections/{id}')
  Future<chopper.Response<ConnectionsIdGet$Response>> _connectionsIdGet({
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///Get all categories
  Future<chopper.Response<CategoriesGet$Response>> categoriesGet() {
    generatedMapping.putIfAbsent(
      CategoriesGet$Response,
      () => CategoriesGet$Response.fromJsonFactory,
    );

    return _categoriesGet();
  }

  ///Get all categories
  @GET(path: '/categories')
  Future<chopper.Response<CategoriesGet$Response>> _categoriesGet({
    @chopper.Tag()
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
  });

  ///Get category
  Future<chopper.Response<CategoriesIdGet$Response>> categoriesIdGet({
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      CategoriesIdGet$Response,
      () => CategoriesIdGet$Response.fromJsonFactory,
    );

    return _categoriesIdGet(id: id);
  }

  ///Get category
  @GET(path: '/categories/{id}')
  Future<chopper.Response<CategoriesIdGet$Response>> _categoriesIdGet({
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///Refresh all accounts
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<RefreshPost$Response>> refreshPost({
    String? xAkahuId,
  }) {
    generatedMapping.putIfAbsent(
      RefreshPost$Response,
      () => RefreshPost$Response.fromJsonFactory,
    );

    return _refreshPost(xAkahuId: xAkahuId?.toString());
  }

  ///Refresh all accounts
  ///@param X-Akahu-Id Your **App ID Token**.
  @POST(path: '/refresh', optionalBody: true)
  Future<chopper.Response<RefreshPost$Response>> _refreshPost({
    @Header('X-Akahu-Id') String? xAkahuId,
    @chopper.Tag()
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
  });

  ///Refresh Individual Accounts or Connections
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<RefreshIdPost$Response>> refreshIdPost({
    String? xAkahuId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      RefreshIdPost$Response,
      () => RefreshIdPost$Response.fromJsonFactory,
    );

    return _refreshIdPost(xAkahuId: xAkahuId?.toString(), id: id);
  }

  ///Refresh Individual Accounts or Connections
  ///@param X-Akahu-Id Your **App ID Token**.
  @POST(path: '/refresh/{id}', optionalBody: true)
  Future<chopper.Response<RefreshIdPost$Response>> _refreshIdPost({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///[One-off access] Get identity result
  Future<chopper.Response<IdentityIdGet$Response>> identityIdGet({
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      IdentityIdGet$Response,
      () => IdentityIdGet$Response.fromJsonFactory,
    );

    return _identityIdGet(id: id);
  }

  ///[One-off access] Get identity result
  @GET(path: '/identity/{id}')
  Future<chopper.Response<IdentityIdGet$Response>> _identityIdGet({
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///[One-off access] Verify a name
  ///@param id
  Future<chopper.Response<OneOffVerifyNameResult>> identityIdVerifyNamePost({
    required String? id,
    required VerifyNameData? body,
  }) {
    generatedMapping.putIfAbsent(
      OneOffVerifyNameResult,
      () => OneOffVerifyNameResult.fromJsonFactory,
    );

    return _identityIdVerifyNamePost(id: id, body: body);
  }

  ///[One-off access] Verify a name
  ///@param id
  @POST(path: '/identity/{id}/verify/name', optionalBody: true)
  Future<chopper.Response<OneOffVerifyNameResult>> _identityIdVerifyNamePost({
    @Path('id') required String? id,
    @Body() required VerifyNameData? body,
    @chopper.Tag()
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
  });

  ///[Enduring access] Verify a name
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<VerifyNameResult>> verifyNamePost({
    String? xAkahuId,
    required VerifyNameData? body,
  }) {
    generatedMapping.putIfAbsent(
      VerifyNameResult,
      () => VerifyNameResult.fromJsonFactory,
    );

    return _verifyNamePost(xAkahuId: xAkahuId?.toString(), body: body);
  }

  ///[Enduring access] Verify a name
  ///@param X-Akahu-Id Your **App ID Token**.
  @POST(path: '/verify/name', optionalBody: true)
  Future<chopper.Response<VerifyNameResult>> _verifyNamePost({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Body() required VerifyNameData? body,
    @chopper.Tag()
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
  });

  ///[Enduring access] Verify a name against an account
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param id
  Future<chopper.Response<VerifyNameResult>> verifyNameIdPost({
    String? xAkahuId,
    required String? id,
    required VerifyNameData? body,
  }) {
    generatedMapping.putIfAbsent(
      VerifyNameResult,
      () => VerifyNameResult.fromJsonFactory,
    );

    return _verifyNameIdPost(
      xAkahuId: xAkahuId?.toString(),
      id: id,
      body: body,
    );
  }

  ///[Enduring access] Verify a name against an account
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param id
  @POST(path: '/verify/name/{id}', optionalBody: true)
  Future<chopper.Response<VerifyNameResult>> _verifyNameIdPost({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Path('id') required String? id,
    @Body() required VerifyNameData? body,
    @chopper.Tag()
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
  });

  ///[Enduring access] Get user identity data
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<PartiesGet$Response>> partiesGet({String? xAkahuId}) {
    generatedMapping.putIfAbsent(
      PartiesGet$Response,
      () => PartiesGet$Response.fromJsonFactory,
    );

    return _partiesGet(xAkahuId: xAkahuId?.toString());
  }

  ///[Enduring access] Get user identity data
  ///@param X-Akahu-Id Your **App ID Token**.
  @GET(path: '/parties')
  Future<chopper.Response<PartiesGet$Response>> _partiesGet({
    @Header('X-Akahu-Id') String? xAkahuId,
    @chopper.Tag()
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
  });

  ///List payments
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param start ISO 8601 Date
  ///@param end ISO 8601 Date
  Future<chopper.Response<PaymentsGet$Response>> paymentsGet({
    String? xAkahuId,
    DateTime? start,
    DateTime? end,
  }) {
    generatedMapping.putIfAbsent(
      PaymentsGet$Response,
      () => PaymentsGet$Response.fromJsonFactory,
    );

    return _paymentsGet(xAkahuId: xAkahuId?.toString(), start: start, end: end);
  }

  ///List payments
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param start ISO 8601 Date
  ///@param end ISO 8601 Date
  @GET(path: '/payments')
  Future<chopper.Response<PaymentsGet$Response>> _paymentsGet({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @chopper.Tag()
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
  });

  ///Make a payment
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param Content-Type
  Future<chopper.Response<PaymentsPost$Response>> paymentsPost({
    String? xAkahuId,
    String? contentType,
    required PaymentsPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      PaymentsPost$Response,
      () => PaymentsPost$Response.fromJsonFactory,
    );

    return _paymentsPost(
      xAkahuId: xAkahuId?.toString(),
      contentType: contentType?.toString(),
      body: body,
    );
  }

  ///Make a payment
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param Content-Type
  @POST(path: '/payments', optionalBody: true)
  Future<chopper.Response<PaymentsPost$Response>> _paymentsPost({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Header('Content-Type') String? contentType,
    @Body() required PaymentsPost$RequestBody? body,
    @chopper.Tag()
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
  });

  ///Make a payment to IRD
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param Content-Type
  Future<chopper.Response<PaymentsIrdPost$Response>> paymentsIrdPost({
    String? xAkahuId,
    String? contentType,
    required PaymentsIrdPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      PaymentsIrdPost$Response,
      () => PaymentsIrdPost$Response.fromJsonFactory,
    );

    return _paymentsIrdPost(
      xAkahuId: xAkahuId?.toString(),
      contentType: contentType?.toString(),
      body: body,
    );
  }

  ///Make a payment to IRD
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param Content-Type
  @POST(path: '/payments/ird', optionalBody: true)
  Future<chopper.Response<PaymentsIrdPost$Response>> _paymentsIrdPost({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Header('Content-Type') String? contentType,
    @Body() required PaymentsIrdPost$RequestBody? body,
    @chopper.Tag()
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
  });

  ///Get a payment
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<PaymentsIdGet$Response>> paymentsIdGet({
    String? xAkahuId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      PaymentsIdGet$Response,
      () => PaymentsIdGet$Response.fromJsonFactory,
    );

    return _paymentsIdGet(xAkahuId: xAkahuId?.toString(), id: id);
  }

  ///Get a payment
  ///@param X-Akahu-Id Your **App ID Token**.
  @GET(path: '/payments/{id}')
  Future<chopper.Response<PaymentsIdGet$Response>> _paymentsIdGet({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///Cancel a payment
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<PaymentsIdCancelPut$Response>> paymentsIdCancelPut({
    String? xAkahuId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      PaymentsIdCancelPut$Response,
      () => PaymentsIdCancelPut$Response.fromJsonFactory,
    );

    return _paymentsIdCancelPut(xAkahuId: xAkahuId?.toString(), id: id);
  }

  ///Cancel a payment
  ///@param X-Akahu-Id Your **App ID Token**.
  @PUT(path: '/payments/{id}/cancel', optionalBody: true)
  Future<chopper.Response<PaymentsIdCancelPut$Response>> _paymentsIdCancelPut({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///Get transactions
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param start ISO 8601 formatted date
  ///@param end ISO 8601 formatted date
  ///@param cursor Cursor from an earlier query
  Future<chopper.Response<TransactionsGet$Response>> transactionsGet({
    String? xAkahuId,
    DateTime? start,
    DateTime? end,
    String? cursor,
  }) {
    generatedMapping.putIfAbsent(
      TransactionsGet$Response,
      () => TransactionsGet$Response.fromJsonFactory,
    );

    return _transactionsGet(
      xAkahuId: xAkahuId?.toString(),
      start: start,
      end: end,
      cursor: cursor,
    );
  }

  ///Get transactions
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param start ISO 8601 formatted date
  ///@param end ISO 8601 formatted date
  ///@param cursor Cursor from an earlier query
  @GET(path: '/transactions')
  Future<chopper.Response<TransactionsGet$Response>> _transactionsGet({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('cursor') String? cursor,
    @chopper.Tag()
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
  });

  ///Get pending transactions
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<TransactionsPendingGet$Response>>
  transactionsPendingGet({String? xAkahuId}) {
    generatedMapping.putIfAbsent(
      TransactionsPendingGet$Response,
      () => TransactionsPendingGet$Response.fromJsonFactory,
    );

    return _transactionsPendingGet(xAkahuId: xAkahuId?.toString());
  }

  ///Get pending transactions
  ///@param X-Akahu-Id Your **App ID Token**.
  @GET(path: '/transactions/pending')
  Future<chopper.Response<TransactionsPendingGet$Response>>
  _transactionsPendingGet({
    @Header('X-Akahu-Id') String? xAkahuId,
    @chopper.Tag()
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
  });

  ///Get a transaction by ID
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<TransactionsIdGet$Response>> transactionsIdGet({
    String? xAkahuId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      TransactionsIdGet$Response,
      () => TransactionsIdGet$Response.fromJsonFactory,
    );

    return _transactionsIdGet(xAkahuId: xAkahuId?.toString(), id: id);
  }

  ///Get a transaction by ID
  ///@param X-Akahu-Id Your **App ID Token**.
  @GET(path: '/transactions/{id}')
  Future<chopper.Response<TransactionsIdGet$Response>> _transactionsIdGet({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///Get transactions by account
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param start ISO 8601 formatted date
  ///@param end ISO 8601 formatted date
  ///@param cursor Cursor from an earlier query
  Future<chopper.Response<AccountsIdTransactionsGet$Response>>
  accountsIdTransactionsGet({
    String? xAkahuId,
    DateTime? start,
    DateTime? end,
    String? cursor,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      AccountsIdTransactionsGet$Response,
      () => AccountsIdTransactionsGet$Response.fromJsonFactory,
    );

    return _accountsIdTransactionsGet(
      xAkahuId: xAkahuId?.toString(),
      start: start,
      end: end,
      cursor: cursor,
      id: id,
    );
  }

  ///Get transactions by account
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param start ISO 8601 formatted date
  ///@param end ISO 8601 formatted date
  ///@param cursor Cursor from an earlier query
  @GET(path: '/accounts/{id}/transactions')
  Future<chopper.Response<AccountsIdTransactionsGet$Response>>
  _accountsIdTransactionsGet({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @Query('cursor') String? cursor,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///Get pending transactions by account
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<AccountsIdTransactionsPendingGet$Response>>
  accountsIdTransactionsPendingGet({String? xAkahuId, required String? id}) {
    generatedMapping.putIfAbsent(
      AccountsIdTransactionsPendingGet$Response,
      () => AccountsIdTransactionsPendingGet$Response.fromJsonFactory,
    );

    return _accountsIdTransactionsPendingGet(
      xAkahuId: xAkahuId?.toString(),
      id: id,
    );
  }

  ///Get pending transactions by account
  ///@param X-Akahu-Id Your **App ID Token**.
  @GET(path: '/accounts/{id}/transactions/pending')
  Future<chopper.Response<AccountsIdTransactionsPendingGet$Response>>
  _accountsIdTransactionsPendingGet({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///Get transactions by IDs
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param Content-Type
  Future<chopper.Response<TransactionsIdsPost$Response>> transactionsIdsPost({
    String? xAkahuId,
    String? contentType,
    required List<String>? body,
  }) {
    generatedMapping.putIfAbsent(
      TransactionsIdsPost$Response,
      () => TransactionsIdsPost$Response.fromJsonFactory,
    );

    return _transactionsIdsPost(
      xAkahuId: xAkahuId?.toString(),
      contentType: contentType?.toString(),
      body: body,
    );
  }

  ///Get transactions by IDs
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param Content-Type
  @POST(path: '/transactions/ids', optionalBody: true)
  Future<chopper.Response<TransactionsIdsPost$Response>> _transactionsIdsPost({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Header('Content-Type') String? contentType,
    @Body() required List<String>? body,
    @chopper.Tag()
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
  });

  ///Get current user
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<MeGet$Response>> meGet({String? xAkahuId}) {
    generatedMapping.putIfAbsent(
      MeGet$Response,
      () => MeGet$Response.fromJsonFactory,
    );

    return _meGet(xAkahuId: xAkahuId?.toString());
  }

  ///Get current user
  ///@param X-Akahu-Id Your **App ID Token**.
  @GET(path: '/me')
  Future<chopper.Response<MeGet$Response>> _meGet({
    @Header('X-Akahu-Id') String? xAkahuId,
    @chopper.Tag()
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
  });

  ///Get all webhooks
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<WebhooksGet$Response>> webhooksGet({
    String? xAkahuId,
  }) {
    generatedMapping.putIfAbsent(
      WebhooksGet$Response,
      () => WebhooksGet$Response.fromJsonFactory,
    );

    return _webhooksGet(xAkahuId: xAkahuId?.toString());
  }

  ///Get all webhooks
  ///@param X-Akahu-Id Your **App ID Token**.
  @GET(path: '/webhooks')
  Future<chopper.Response<WebhooksGet$Response>> _webhooksGet({
    @Header('X-Akahu-Id') String? xAkahuId,
    @chopper.Tag()
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
  });

  ///Subscribe to webhook
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param Content-Type
  Future<chopper.Response<WebhooksPost$Response>> webhooksPost({
    String? xAkahuId,
    String? contentType,
    required WebhooksPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      WebhooksPost$Response,
      () => WebhooksPost$Response.fromJsonFactory,
    );

    return _webhooksPost(
      xAkahuId: xAkahuId?.toString(),
      contentType: contentType?.toString(),
      body: body,
    );
  }

  ///Subscribe to webhook
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param Content-Type
  @POST(path: '/webhooks', optionalBody: true)
  Future<chopper.Response<WebhooksPost$Response>> _webhooksPost({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Header('Content-Type') String? contentType,
    @Body() required WebhooksPost$RequestBody? body,
    @chopper.Tag()
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
  });

  ///Get public key
  Future<chopper.Response<KeysIdGet$Response>> keysIdGet({
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      KeysIdGet$Response,
      () => KeysIdGet$Response.fromJsonFactory,
    );

    return _keysIdGet(id: id);
  }

  ///Get public key
  @GET(path: '/keys/{id}')
  Future<chopper.Response<KeysIdGet$Response>> _keysIdGet({
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///Unsubscribe from webhook
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<WebhooksIdDelete$Response>> webhooksIdDelete({
    String? xAkahuId,
    required String? id,
  }) {
    generatedMapping.putIfAbsent(
      WebhooksIdDelete$Response,
      () => WebhooksIdDelete$Response.fromJsonFactory,
    );

    return _webhooksIdDelete(xAkahuId: xAkahuId?.toString(), id: id);
  }

  ///Unsubscribe from webhook
  ///@param X-Akahu-Id Your **App ID Token**.
  @DELETE(path: '/webhooks/{id}')
  Future<chopper.Response<WebhooksIdDelete$Response>> _webhooksIdDelete({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Path('id') required String? id,
    @chopper.Tag()
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
  });

  ///Get webhook events
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param status State of the webhook event
  ///@param start ISO 8601 formatted date
  ///@param end ISO 8601 formatted date
  Future<chopper.Response<WebhookEventsGet$Response>> webhookEventsGet({
    String? xAkahuId,
    enums.WebhookEventsGetStatus? status,
    DateTime? start,
    DateTime? end,
  }) {
    generatedMapping.putIfAbsent(
      WebhookEventsGet$Response,
      () => WebhookEventsGet$Response.fromJsonFactory,
    );

    return _webhookEventsGet(
      xAkahuId: xAkahuId?.toString(),
      status: status?.value?.toString(),
      start: start,
      end: end,
    );
  }

  ///Get webhook events
  ///@param X-Akahu-Id Your **App ID Token**.
  ///@param status State of the webhook event
  ///@param start ISO 8601 formatted date
  ///@param end ISO 8601 formatted date
  @GET(path: '/webhook-events')
  Future<chopper.Response<WebhookEventsGet$Response>> _webhookEventsGet({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Query('status') String? status,
    @Query('start') DateTime? start,
    @Query('end') DateTime? end,
    @chopper.Tag()
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
  });

  ///Transaction support
  ///@param X-Akahu-Id Your **App ID Token**.
  Future<chopper.Response<SupportTransactionIdPost$Response>>
  supportTransactionIdPost({
    String? xAkahuId,
    required String? transactionId,
    required SupportTransactionIdPost$RequestBody? body,
  }) {
    generatedMapping.putIfAbsent(
      SupportTransactionIdPost$Response,
      () => SupportTransactionIdPost$Response.fromJsonFactory,
    );

    return _supportTransactionIdPost(
      xAkahuId: xAkahuId?.toString(),
      transactionId: transactionId,
      body: body,
    );
  }

  ///Transaction support
  ///@param X-Akahu-Id Your **App ID Token**.
  @POST(path: '/support/{transaction_id}', optionalBody: true)
  Future<chopper.Response<SupportTransactionIdPost$Response>>
  _supportTransactionIdPost({
    @Header('X-Akahu-Id') String? xAkahuId,
    @Path('transaction_id') required String? transactionId,
    @Body() required SupportTransactionIdPost$RequestBody? body,
    @chopper.Tag()
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
  });
}

@JsonSerializable(explicitToJson: true)
class ConnectionInfo {
  const ConnectionInfo({
    required this.id,
    required this.name,
    required this.logo,
    required this.connectionType,
  });

  factory ConnectionInfo.fromJson(Map<String, dynamic> json) =>
      _$ConnectionInfoFromJson(json);

  static const toJsonFactory = _$ConnectionInfoToJson;
  Map<String, dynamic> toJson() => _$ConnectionInfoToJson(this);

  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'logo')
  final String logo;
  @JsonKey(
    name: 'connection_type',
    toJson: connectionTypeToJson,
    fromJson: connectionTypeFromJson,
  )
  final enums.ConnectionType connectionType;
  static const fromJsonFactory = _$ConnectionInfoFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ConnectionInfo &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.logo, logo) ||
                const DeepCollectionEquality().equals(other.logo, logo)) &&
            (identical(other.connectionType, connectionType) ||
                const DeepCollectionEquality().equals(
                  other.connectionType,
                  connectionType,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(logo) ^
      const DeepCollectionEquality().hash(connectionType) ^
      runtimeType.hashCode;
}

extension $ConnectionInfoExtension on ConnectionInfo {
  ConnectionInfo copyWith({
    String? id,
    String? name,
    String? logo,
    enums.ConnectionType? connectionType,
  }) {
    return ConnectionInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      connectionType: connectionType ?? this.connectionType,
    );
  }

  ConnectionInfo copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String>? logo,
    Wrapped<enums.ConnectionType>? connectionType,
  }) {
    return ConnectionInfo(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      logo: (logo != null ? logo.value : this.logo),
      connectionType: (connectionType != null
          ? connectionType.value
          : this.connectionType),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Connection {
  const Connection({
    required this.id,
    this.classic,
    required this.name,
    required this.logo,
    required this.connectionType,
    required this.newConnectionsEnabled,
    this.mode,
    this.deadline,
  });

  factory Connection.fromJson(Map<String, dynamic> json) =>
      _$ConnectionFromJson(json);

  static const toJsonFactory = _$ConnectionToJson;
  Map<String, dynamic> toJson() => _$ConnectionToJson(this);

  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: '_classic')
  final String? classic;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'logo')
  final String logo;
  @JsonKey(
    name: 'connection_type',
    toJson: connectionTypeToJson,
    fromJson: connectionTypeFromJson,
  )
  final enums.ConnectionType connectionType;
  @JsonKey(name: 'new_connections_enabled')
  final bool newConnectionsEnabled;
  @JsonKey(
    name: 'mode',
    toJson: connectionModeNullableToJson,
    fromJson: connectionModeNullableFromJson,
  )
  final enums.ConnectionMode? mode;
  @JsonKey(name: 'deadline')
  final String? deadline;
  static const fromJsonFactory = _$ConnectionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Connection &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.classic, classic) ||
                const DeepCollectionEquality().equals(
                  other.classic,
                  classic,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.logo, logo) ||
                const DeepCollectionEquality().equals(other.logo, logo)) &&
            (identical(other.connectionType, connectionType) ||
                const DeepCollectionEquality().equals(
                  other.connectionType,
                  connectionType,
                )) &&
            (identical(other.newConnectionsEnabled, newConnectionsEnabled) ||
                const DeepCollectionEquality().equals(
                  other.newConnectionsEnabled,
                  newConnectionsEnabled,
                )) &&
            (identical(other.mode, mode) ||
                const DeepCollectionEquality().equals(other.mode, mode)) &&
            (identical(other.deadline, deadline) ||
                const DeepCollectionEquality().equals(
                  other.deadline,
                  deadline,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(classic) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(logo) ^
      const DeepCollectionEquality().hash(connectionType) ^
      const DeepCollectionEquality().hash(newConnectionsEnabled) ^
      const DeepCollectionEquality().hash(mode) ^
      const DeepCollectionEquality().hash(deadline) ^
      runtimeType.hashCode;
}

extension $ConnectionExtension on Connection {
  Connection copyWith({
    String? id,
    String? classic,
    String? name,
    String? logo,
    enums.ConnectionType? connectionType,
    bool? newConnectionsEnabled,
    enums.ConnectionMode? mode,
    String? deadline,
  }) {
    return Connection(
      id: id ?? this.id,
      classic: classic ?? this.classic,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      connectionType: connectionType ?? this.connectionType,
      newConnectionsEnabled:
          newConnectionsEnabled ?? this.newConnectionsEnabled,
      mode: mode ?? this.mode,
      deadline: deadline ?? this.deadline,
    );
  }

  Connection copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String?>? classic,
    Wrapped<String>? name,
    Wrapped<String>? logo,
    Wrapped<enums.ConnectionType>? connectionType,
    Wrapped<bool>? newConnectionsEnabled,
    Wrapped<enums.ConnectionMode?>? mode,
    Wrapped<String?>? deadline,
  }) {
    return Connection(
      id: (id != null ? id.value : this.id),
      classic: (classic != null ? classic.value : this.classic),
      name: (name != null ? name.value : this.name),
      logo: (logo != null ? logo.value : this.logo),
      connectionType: (connectionType != null
          ? connectionType.value
          : this.connectionType),
      newConnectionsEnabled: (newConnectionsEnabled != null
          ? newConnectionsEnabled.value
          : this.newConnectionsEnabled),
      mode: (mode != null ? mode.value : this.mode),
      deadline: (deadline != null ? deadline.value : this.deadline),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentConsentPeriodicLimit {
  const PaymentConsentPeriodicLimit({
    required this.amount,
    required this.frequency,
  });

  factory PaymentConsentPeriodicLimit.fromJson(Map<String, dynamic> json) =>
      _$PaymentConsentPeriodicLimitFromJson(json);

  static const toJsonFactory = _$PaymentConsentPeriodicLimitToJson;
  Map<String, dynamic> toJson() => _$PaymentConsentPeriodicLimitToJson(this);

  @JsonKey(name: 'amount')
  final double amount;
  @JsonKey(
    name: 'frequency',
    toJson: paymentPeriodFrequencyToJson,
    fromJson: paymentPeriodFrequencyFromJson,
  )
  final enums.PaymentPeriodFrequency frequency;
  static const fromJsonFactory = _$PaymentConsentPeriodicLimitFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentConsentPeriodicLimit &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.frequency, frequency) ||
                const DeepCollectionEquality().equals(
                  other.frequency,
                  frequency,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(frequency) ^
      runtimeType.hashCode;
}

extension $PaymentConsentPeriodicLimitExtension on PaymentConsentPeriodicLimit {
  PaymentConsentPeriodicLimit copyWith({
    double? amount,
    enums.PaymentPeriodFrequency? frequency,
  }) {
    return PaymentConsentPeriodicLimit(
      amount: amount ?? this.amount,
      frequency: frequency ?? this.frequency,
    );
  }

  PaymentConsentPeriodicLimit copyWithWrapped({
    Wrapped<double>? amount,
    Wrapped<enums.PaymentPeriodFrequency>? frequency,
  }) {
    return PaymentConsentPeriodicLimit(
      amount: (amount != null ? amount.value : this.amount),
      frequency: (frequency != null ? frequency.value : this.frequency),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentConsentPayee {
  const PaymentConsentPayee({required this.name, required this.accountNumber});

  factory PaymentConsentPayee.fromJson(Map<String, dynamic> json) =>
      _$PaymentConsentPayeeFromJson(json);

  static const toJsonFactory = _$PaymentConsentPayeeToJson;
  Map<String, dynamic> toJson() => _$PaymentConsentPayeeToJson(this);

  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'account_number')
  final String accountNumber;
  static const fromJsonFactory = _$PaymentConsentPayeeFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentConsentPayee &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.accountNumber, accountNumber) ||
                const DeepCollectionEquality().equals(
                  other.accountNumber,
                  accountNumber,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(accountNumber) ^
      runtimeType.hashCode;
}

extension $PaymentConsentPayeeExtension on PaymentConsentPayee {
  PaymentConsentPayee copyWith({String? name, String? accountNumber}) {
    return PaymentConsentPayee(
      name: name ?? this.name,
      accountNumber: accountNumber ?? this.accountNumber,
    );
  }

  PaymentConsentPayee copyWithWrapped({
    Wrapped<String>? name,
    Wrapped<String>? accountNumber,
  }) {
    return PaymentConsentPayee(
      name: (name != null ? name.value : this.name),
      accountNumber: (accountNumber != null
          ? accountNumber.value
          : this.accountNumber),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AccountPaymentConsent {
  const AccountPaymentConsent({
    required this.id,
    required this.singleLimit,
    required this.periodicLimit,
    required this.payees,
  });

  factory AccountPaymentConsent.fromJson(Map<String, dynamic> json) =>
      _$AccountPaymentConsentFromJson(json);

  static const toJsonFactory = _$AccountPaymentConsentToJson;
  Map<String, dynamic> toJson() => _$AccountPaymentConsentToJson(this);

  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'single_limit')
  final double singleLimit;
  @JsonKey(name: 'periodic_limit')
  final PaymentConsentPeriodicLimit periodicLimit;
  @JsonKey(name: 'payees', defaultValue: <PaymentConsentPayee>[])
  final List<PaymentConsentPayee> payees;
  static const fromJsonFactory = _$AccountPaymentConsentFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AccountPaymentConsent &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.singleLimit, singleLimit) ||
                const DeepCollectionEquality().equals(
                  other.singleLimit,
                  singleLimit,
                )) &&
            (identical(other.periodicLimit, periodicLimit) ||
                const DeepCollectionEquality().equals(
                  other.periodicLimit,
                  periodicLimit,
                )) &&
            (identical(other.payees, payees) ||
                const DeepCollectionEquality().equals(other.payees, payees)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(singleLimit) ^
      const DeepCollectionEquality().hash(periodicLimit) ^
      const DeepCollectionEquality().hash(payees) ^
      runtimeType.hashCode;
}

extension $AccountPaymentConsentExtension on AccountPaymentConsent {
  AccountPaymentConsent copyWith({
    String? id,
    double? singleLimit,
    PaymentConsentPeriodicLimit? periodicLimit,
    List<PaymentConsentPayee>? payees,
  }) {
    return AccountPaymentConsent(
      id: id ?? this.id,
      singleLimit: singleLimit ?? this.singleLimit,
      periodicLimit: periodicLimit ?? this.periodicLimit,
      payees: payees ?? this.payees,
    );
  }

  AccountPaymentConsent copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<double>? singleLimit,
    Wrapped<PaymentConsentPeriodicLimit>? periodicLimit,
    Wrapped<List<PaymentConsentPayee>>? payees,
  }) {
    return AccountPaymentConsent(
      id: (id != null ? id.value : this.id),
      singleLimit: (singleLimit != null ? singleLimit.value : this.singleLimit),
      periodicLimit: (periodicLimit != null
          ? periodicLimit.value
          : this.periodicLimit),
      payees: (payees != null ? payees.value : this.payees),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Account {
  const Account({
    required this.id,
    this.migrated,
    required this.authorisation,
    this.credentials,
    required this.connection,
    required this.name,
    required this.status,
    this.balance,
    required this.type,
    required this.attributes,
    this.formattedAccount,
    this.paymentConsents,
    this.meta,
    this.refreshed,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  static const toJsonFactory = _$AccountToJson;
  Map<String, dynamic> toJson() => _$AccountToJson(this);

  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: '_migrated')
  final String? migrated;
  @JsonKey(name: '_authorisation')
  final String authorisation;
  @JsonKey(name: '_credentials')
  @deprecated
  final String? credentials;
  @JsonKey(name: 'connection')
  final ConnectionInfo connection;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(
    name: 'status',
    toJson: accountStatusToJson,
    fromJson: accountStatusFromJson,
  )
  final enums.AccountStatus status;
  @JsonKey(name: 'balance')
  final Account$Balance? balance;
  @JsonKey(
    name: 'type',
    toJson: accountTypeToJson,
    fromJson: accountTypeFromJson,
  )
  final enums.AccountType type;
  @JsonKey(
    name: 'attributes',
    toJson: accountAttributesListToJson,
    fromJson: accountAttributesListFromJson,
  )
  final List<enums.AccountAttributes> attributes;
  @JsonKey(name: 'formatted_account')
  final String? formattedAccount;
  @JsonKey(name: 'payment_consents', defaultValue: <AccountPaymentConsent>[])
  final List<AccountPaymentConsent>? paymentConsents;
  @JsonKey(name: 'meta')
  final Map<String, dynamic>? meta;
  @JsonKey(name: 'refreshed')
  final Account$Refreshed? refreshed;
  static const fromJsonFactory = _$AccountFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Account &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.migrated, migrated) ||
                const DeepCollectionEquality().equals(
                  other.migrated,
                  migrated,
                )) &&
            (identical(other.authorisation, authorisation) ||
                const DeepCollectionEquality().equals(
                  other.authorisation,
                  authorisation,
                )) &&
            (identical(other.credentials, credentials) ||
                const DeepCollectionEquality().equals(
                  other.credentials,
                  credentials,
                )) &&
            (identical(other.connection, connection) ||
                const DeepCollectionEquality().equals(
                  other.connection,
                  connection,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality().equals(
                  other.balance,
                  balance,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.attributes, attributes) ||
                const DeepCollectionEquality().equals(
                  other.attributes,
                  attributes,
                )) &&
            (identical(other.formattedAccount, formattedAccount) ||
                const DeepCollectionEquality().equals(
                  other.formattedAccount,
                  formattedAccount,
                )) &&
            (identical(other.paymentConsents, paymentConsents) ||
                const DeepCollectionEquality().equals(
                  other.paymentConsents,
                  paymentConsents,
                )) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)) &&
            (identical(other.refreshed, refreshed) ||
                const DeepCollectionEquality().equals(
                  other.refreshed,
                  refreshed,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(migrated) ^
      const DeepCollectionEquality().hash(authorisation) ^
      const DeepCollectionEquality().hash(credentials) ^
      const DeepCollectionEquality().hash(connection) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(balance) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(attributes) ^
      const DeepCollectionEquality().hash(formattedAccount) ^
      const DeepCollectionEquality().hash(paymentConsents) ^
      const DeepCollectionEquality().hash(meta) ^
      const DeepCollectionEquality().hash(refreshed) ^
      runtimeType.hashCode;
}

extension $AccountExtension on Account {
  Account copyWith({
    String? id,
    String? migrated,
    String? authorisation,
    String? credentials,
    ConnectionInfo? connection,
    String? name,
    enums.AccountStatus? status,
    Account$Balance? balance,
    enums.AccountType? type,
    List<enums.AccountAttributes>? attributes,
    String? formattedAccount,
    List<AccountPaymentConsent>? paymentConsents,
    Map<String, dynamic>? meta,
    Account$Refreshed? refreshed,
  }) {
    return Account(
      id: id ?? this.id,
      migrated: migrated ?? this.migrated,
      authorisation: authorisation ?? this.authorisation,
      credentials: credentials ?? this.credentials,
      connection: connection ?? this.connection,
      name: name ?? this.name,
      status: status ?? this.status,
      balance: balance ?? this.balance,
      type: type ?? this.type,
      attributes: attributes ?? this.attributes,
      formattedAccount: formattedAccount ?? this.formattedAccount,
      paymentConsents: paymentConsents ?? this.paymentConsents,
      meta: meta ?? this.meta,
      refreshed: refreshed ?? this.refreshed,
    );
  }

  Account copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String?>? migrated,
    Wrapped<String>? authorisation,
    Wrapped<String?>? credentials,
    Wrapped<ConnectionInfo>? connection,
    Wrapped<String>? name,
    Wrapped<enums.AccountStatus>? status,
    Wrapped<Account$Balance?>? balance,
    Wrapped<enums.AccountType>? type,
    Wrapped<List<enums.AccountAttributes>>? attributes,
    Wrapped<String?>? formattedAccount,
    Wrapped<List<AccountPaymentConsent>?>? paymentConsents,
    Wrapped<Map<String, dynamic>?>? meta,
    Wrapped<Account$Refreshed?>? refreshed,
  }) {
    return Account(
      id: (id != null ? id.value : this.id),
      migrated: (migrated != null ? migrated.value : this.migrated),
      authorisation: (authorisation != null
          ? authorisation.value
          : this.authorisation),
      credentials: (credentials != null ? credentials.value : this.credentials),
      connection: (connection != null ? connection.value : this.connection),
      name: (name != null ? name.value : this.name),
      status: (status != null ? status.value : this.status),
      balance: (balance != null ? balance.value : this.balance),
      type: (type != null ? type.value : this.type),
      attributes: (attributes != null ? attributes.value : this.attributes),
      formattedAccount: (formattedAccount != null
          ? formattedAccount.value
          : this.formattedAccount),
      paymentConsents: (paymentConsents != null
          ? paymentConsents.value
          : this.paymentConsents),
      meta: (meta != null ? meta.value : this.meta),
      refreshed: (refreshed != null ? refreshed.value : this.refreshed),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Token {
  const Token({this.success, this.accessToken, this.tokenType, this.scope});

  factory Token.fromJson(Map<String, dynamic> json) => _$TokenFromJson(json);

  static const toJsonFactory = _$TokenToJson;
  Map<String, dynamic> toJson() => _$TokenToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @JsonKey(name: 'token_type')
  final String? tokenType;
  @JsonKey(name: 'scope')
  final String? scope;
  static const fromJsonFactory = _$TokenFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Token &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.accessToken, accessToken) ||
                const DeepCollectionEquality().equals(
                  other.accessToken,
                  accessToken,
                )) &&
            (identical(other.tokenType, tokenType) ||
                const DeepCollectionEquality().equals(
                  other.tokenType,
                  tokenType,
                )) &&
            (identical(other.scope, scope) ||
                const DeepCollectionEquality().equals(other.scope, scope)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(accessToken) ^
      const DeepCollectionEquality().hash(tokenType) ^
      const DeepCollectionEquality().hash(scope) ^
      runtimeType.hashCode;
}

extension $TokenExtension on Token {
  Token copyWith({
    bool? success,
    String? accessToken,
    String? tokenType,
    String? scope,
  }) {
    return Token(
      success: success ?? this.success,
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      scope: scope ?? this.scope,
    );
  }

  Token copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<String?>? accessToken,
    Wrapped<String?>? tokenType,
    Wrapped<String?>? scope,
  }) {
    return Token(
      success: (success != null ? success.value : this.success),
      accessToken: (accessToken != null ? accessToken.value : this.accessToken),
      tokenType: (tokenType != null ? tokenType.value : this.tokenType),
      scope: (scope != null ? scope.value : this.scope),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OneOffIdentityAccount {
  const OneOffIdentityAccount({
    this.bank,
    this.accountNumber,
    this.holder,
    this.hasUnlistedHolders,
  });

  factory OneOffIdentityAccount.fromJson(Map<String, dynamic> json) =>
      _$OneOffIdentityAccountFromJson(json);

  static const toJsonFactory = _$OneOffIdentityAccountToJson;
  Map<String, dynamic> toJson() => _$OneOffIdentityAccountToJson(this);

  @JsonKey(name: 'bank')
  final String? bank;
  @JsonKey(name: 'account_number')
  final String? accountNumber;
  @JsonKey(name: 'holder')
  final String? holder;
  @JsonKey(name: 'has_unlisted_holders')
  final bool? hasUnlistedHolders;
  static const fromJsonFactory = _$OneOffIdentityAccountFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OneOffIdentityAccount &&
            (identical(other.bank, bank) ||
                const DeepCollectionEquality().equals(other.bank, bank)) &&
            (identical(other.accountNumber, accountNumber) ||
                const DeepCollectionEquality().equals(
                  other.accountNumber,
                  accountNumber,
                )) &&
            (identical(other.holder, holder) ||
                const DeepCollectionEquality().equals(other.holder, holder)) &&
            (identical(other.hasUnlistedHolders, hasUnlistedHolders) ||
                const DeepCollectionEquality().equals(
                  other.hasUnlistedHolders,
                  hasUnlistedHolders,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(bank) ^
      const DeepCollectionEquality().hash(accountNumber) ^
      const DeepCollectionEquality().hash(holder) ^
      const DeepCollectionEquality().hash(hasUnlistedHolders) ^
      runtimeType.hashCode;
}

extension $OneOffIdentityAccountExtension on OneOffIdentityAccount {
  OneOffIdentityAccount copyWith({
    String? bank,
    String? accountNumber,
    String? holder,
    bool? hasUnlistedHolders,
  }) {
    return OneOffIdentityAccount(
      bank: bank ?? this.bank,
      accountNumber: accountNumber ?? this.accountNumber,
      holder: holder ?? this.holder,
      hasUnlistedHolders: hasUnlistedHolders ?? this.hasUnlistedHolders,
    );
  }

  OneOffIdentityAccount copyWithWrapped({
    Wrapped<String?>? bank,
    Wrapped<String?>? accountNumber,
    Wrapped<String?>? holder,
    Wrapped<bool?>? hasUnlistedHolders,
  }) {
    return OneOffIdentityAccount(
      bank: (bank != null ? bank.value : this.bank),
      accountNumber: (accountNumber != null
          ? accountNumber.value
          : this.accountNumber),
      holder: (holder != null ? holder.value : this.holder),
      hasUnlistedHolders: (hasUnlistedHolders != null
          ? hasUnlistedHolders.value
          : this.hasUnlistedHolders),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Identities {
  const Identities({this.name, this.formattedAccount, this.meta});

  factory Identities.fromJson(Map<String, dynamic> json) =>
      _$IdentitiesFromJson(json);

  static const toJsonFactory = _$IdentitiesToJson;
  Map<String, dynamic> toJson() => _$IdentitiesToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'formatted_account')
  final String? formattedAccount;
  @JsonKey(name: 'meta')
  final Object? meta;
  static const fromJsonFactory = _$IdentitiesFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Identities &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.formattedAccount, formattedAccount) ||
                const DeepCollectionEquality().equals(
                  other.formattedAccount,
                  formattedAccount,
                )) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(formattedAccount) ^
      const DeepCollectionEquality().hash(meta) ^
      runtimeType.hashCode;
}

extension $IdentitiesExtension on Identities {
  Identities copyWith({String? name, String? formattedAccount, Object? meta}) {
    return Identities(
      name: name ?? this.name,
      formattedAccount: formattedAccount ?? this.formattedAccount,
      meta: meta ?? this.meta,
    );
  }

  Identities copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? formattedAccount,
    Wrapped<Object?>? meta,
  }) {
    return Identities(
      name: (name != null ? name.value : this.name),
      formattedAccount: (formattedAccount != null
          ? formattedAccount.value
          : this.formattedAccount),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AddressComponents {
  const AddressComponents({
    this.street,
    this.suburb,
    this.city,
    this.region,
    this.postalCode,
    this.country,
  });

  factory AddressComponents.fromJson(Map<String, dynamic> json) =>
      _$AddressComponentsFromJson(json);

  static const toJsonFactory = _$AddressComponentsToJson;
  Map<String, dynamic> toJson() => _$AddressComponentsToJson(this);

  @JsonKey(name: 'street')
  final String? street;
  @JsonKey(name: 'suburb')
  final String? suburb;
  @JsonKey(name: 'city')
  final String? city;
  @JsonKey(name: 'region')
  final String? region;
  @JsonKey(name: 'postal_code')
  final String? postalCode;
  @JsonKey(name: 'country')
  final String? country;
  static const fromJsonFactory = _$AddressComponentsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AddressComponents &&
            (identical(other.street, street) ||
                const DeepCollectionEquality().equals(other.street, street)) &&
            (identical(other.suburb, suburb) ||
                const DeepCollectionEquality().equals(other.suburb, suburb)) &&
            (identical(other.city, city) ||
                const DeepCollectionEquality().equals(other.city, city)) &&
            (identical(other.region, region) ||
                const DeepCollectionEquality().equals(other.region, region)) &&
            (identical(other.postalCode, postalCode) ||
                const DeepCollectionEquality().equals(
                  other.postalCode,
                  postalCode,
                )) &&
            (identical(other.country, country) ||
                const DeepCollectionEquality().equals(other.country, country)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(street) ^
      const DeepCollectionEquality().hash(suburb) ^
      const DeepCollectionEquality().hash(city) ^
      const DeepCollectionEquality().hash(region) ^
      const DeepCollectionEquality().hash(postalCode) ^
      const DeepCollectionEquality().hash(country) ^
      runtimeType.hashCode;
}

extension $AddressComponentsExtension on AddressComponents {
  AddressComponents copyWith({
    String? street,
    String? suburb,
    String? city,
    String? region,
    String? postalCode,
    String? country,
  }) {
    return AddressComponents(
      street: street ?? this.street,
      suburb: suburb ?? this.suburb,
      city: city ?? this.city,
      region: region ?? this.region,
      postalCode: postalCode ?? this.postalCode,
      country: country ?? this.country,
    );
  }

  AddressComponents copyWithWrapped({
    Wrapped<String?>? street,
    Wrapped<String?>? suburb,
    Wrapped<String?>? city,
    Wrapped<String?>? region,
    Wrapped<String?>? postalCode,
    Wrapped<String?>? country,
  }) {
    return AddressComponents(
      street: (street != null ? street.value : this.street),
      suburb: (suburb != null ? suburb.value : this.suburb),
      city: (city != null ? city.value : this.city),
      region: (region != null ? region.value : this.region),
      postalCode: (postalCode != null ? postalCode.value : this.postalCode),
      country: (country != null ? country.value : this.country),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Addresses {
  const Addresses({
    this.type,
    this.value,
    this.formattedAddress,
    this.placeId,
    this.components,
  });

  factory Addresses.fromJson(Map<String, dynamic> json) =>
      _$AddressesFromJson(json);

  static const toJsonFactory = _$AddressesToJson;
  Map<String, dynamic> toJson() => _$AddressesToJson(this);

  @JsonKey(
    name: 'type',
    toJson: addressTypeNullableToJson,
    fromJson: addressTypeNullableFromJson,
  )
  final enums.AddressType? type;
  @JsonKey(name: 'value')
  final String? value;
  @JsonKey(name: 'formatted_address')
  final String? formattedAddress;
  @JsonKey(name: 'place_id')
  final String? placeId;
  @JsonKey(name: 'components')
  final AddressComponents? components;
  static const fromJsonFactory = _$AddressesFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Addresses &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.formattedAddress, formattedAddress) ||
                const DeepCollectionEquality().equals(
                  other.formattedAddress,
                  formattedAddress,
                )) &&
            (identical(other.placeId, placeId) ||
                const DeepCollectionEquality().equals(
                  other.placeId,
                  placeId,
                )) &&
            (identical(other.components, components) ||
                const DeepCollectionEquality().equals(
                  other.components,
                  components,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(formattedAddress) ^
      const DeepCollectionEquality().hash(placeId) ^
      const DeepCollectionEquality().hash(components) ^
      runtimeType.hashCode;
}

extension $AddressesExtension on Addresses {
  Addresses copyWith({
    enums.AddressType? type,
    String? value,
    String? formattedAddress,
    String? placeId,
    AddressComponents? components,
  }) {
    return Addresses(
      type: type ?? this.type,
      value: value ?? this.value,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      placeId: placeId ?? this.placeId,
      components: components ?? this.components,
    );
  }

  Addresses copyWithWrapped({
    Wrapped<enums.AddressType?>? type,
    Wrapped<String?>? value,
    Wrapped<String?>? formattedAddress,
    Wrapped<String?>? placeId,
    Wrapped<AddressComponents?>? components,
  }) {
    return Addresses(
      type: (type != null ? type.value : this.type),
      value: (value != null ? value.value : this.value),
      formattedAddress: (formattedAddress != null
          ? formattedAddress.value
          : this.formattedAddress),
      placeId: (placeId != null ? placeId.value : this.placeId),
      components: (components != null ? components.value : this.components),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OneOffIdentity {
  const OneOffIdentity({
    this.id,
    this.status,
    this.source,
    this.accounts,
    this.identities,
    this.addresses,
  });

  factory OneOffIdentity.fromJson(Map<String, dynamic> json) =>
      _$OneOffIdentityFromJson(json);

  static const toJsonFactory = _$OneOffIdentityToJson;
  Map<String, dynamic> toJson() => _$OneOffIdentityToJson(this);

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(
    name: 'status',
    toJson: oneOffIdentityStatusNullableToJson,
    fromJson: oneOffIdentityStatusNullableFromJson,
  )
  final enums.OneOffIdentityStatus? status;
  @JsonKey(name: 'source')
  final ConnectionInfo? source;
  @JsonKey(name: 'accounts', defaultValue: <OneOffIdentityAccount>[])
  final List<OneOffIdentityAccount>? accounts;
  @JsonKey(name: 'identities', defaultValue: <Identities>[])
  final List<Identities>? identities;
  @JsonKey(name: 'addresses', defaultValue: <Addresses>[])
  final List<Addresses>? addresses;
  static const fromJsonFactory = _$OneOffIdentityFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OneOffIdentity &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.accounts, accounts) ||
                const DeepCollectionEquality().equals(
                  other.accounts,
                  accounts,
                )) &&
            (identical(other.identities, identities) ||
                const DeepCollectionEquality().equals(
                  other.identities,
                  identities,
                )) &&
            (identical(other.addresses, addresses) ||
                const DeepCollectionEquality().equals(
                  other.addresses,
                  addresses,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(source) ^
      const DeepCollectionEquality().hash(accounts) ^
      const DeepCollectionEquality().hash(identities) ^
      const DeepCollectionEquality().hash(addresses) ^
      runtimeType.hashCode;
}

extension $OneOffIdentityExtension on OneOffIdentity {
  OneOffIdentity copyWith({
    String? id,
    enums.OneOffIdentityStatus? status,
    ConnectionInfo? source,
    List<OneOffIdentityAccount>? accounts,
    List<Identities>? identities,
    List<Addresses>? addresses,
  }) {
    return OneOffIdentity(
      id: id ?? this.id,
      status: status ?? this.status,
      source: source ?? this.source,
      accounts: accounts ?? this.accounts,
      identities: identities ?? this.identities,
      addresses: addresses ?? this.addresses,
    );
  }

  OneOffIdentity copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<enums.OneOffIdentityStatus?>? status,
    Wrapped<ConnectionInfo?>? source,
    Wrapped<List<OneOffIdentityAccount>?>? accounts,
    Wrapped<List<Identities>?>? identities,
    Wrapped<List<Addresses>?>? addresses,
  }) {
    return OneOffIdentity(
      id: (id != null ? id.value : this.id),
      status: (status != null ? status.value : this.status),
      source: (source != null ? source.value : this.source),
      accounts: (accounts != null ? accounts.value : this.accounts),
      identities: (identities != null ? identities.value : this.identities),
      addresses: (addresses != null ? addresses.value : this.addresses),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class VerifyNameData {
  const VerifyNameData({
    this.givenName,
    this.middleName,
    required this.familyName,
    this.initials,
  });

  factory VerifyNameData.fromJson(Map<String, dynamic> json) =>
      _$VerifyNameDataFromJson(json);

  static const toJsonFactory = _$VerifyNameDataToJson;
  Map<String, dynamic> toJson() => _$VerifyNameDataToJson(this);

  @JsonKey(name: 'given_name')
  final String? givenName;
  @JsonKey(name: 'middle_name')
  final String? middleName;
  @JsonKey(name: 'family_name')
  final String familyName;
  @JsonKey(name: 'initials', defaultValue: <String>[])
  final List<String>? initials;
  static const fromJsonFactory = _$VerifyNameDataFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is VerifyNameData &&
            (identical(other.givenName, givenName) ||
                const DeepCollectionEquality().equals(
                  other.givenName,
                  givenName,
                )) &&
            (identical(other.middleName, middleName) ||
                const DeepCollectionEquality().equals(
                  other.middleName,
                  middleName,
                )) &&
            (identical(other.familyName, familyName) ||
                const DeepCollectionEquality().equals(
                  other.familyName,
                  familyName,
                )) &&
            (identical(other.initials, initials) ||
                const DeepCollectionEquality().equals(
                  other.initials,
                  initials,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(givenName) ^
      const DeepCollectionEquality().hash(middleName) ^
      const DeepCollectionEquality().hash(familyName) ^
      const DeepCollectionEquality().hash(initials) ^
      runtimeType.hashCode;
}

extension $VerifyNameDataExtension on VerifyNameData {
  VerifyNameData copyWith({
    String? givenName,
    String? middleName,
    String? familyName,
    List<String>? initials,
  }) {
    return VerifyNameData(
      givenName: givenName ?? this.givenName,
      middleName: middleName ?? this.middleName,
      familyName: familyName ?? this.familyName,
      initials: initials ?? this.initials,
    );
  }

  VerifyNameData copyWithWrapped({
    Wrapped<String?>? givenName,
    Wrapped<String?>? middleName,
    Wrapped<String>? familyName,
    Wrapped<List<String>?>? initials,
  }) {
    return VerifyNameData(
      givenName: (givenName != null ? givenName.value : this.givenName),
      middleName: (middleName != null ? middleName.value : this.middleName),
      familyName: (familyName != null ? familyName.value : this.familyName),
      initials: (initials != null ? initials.value : this.initials),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class VerifyNameMatchedComponents {
  const VerifyNameMatchedComponents({
    required this.givenName,
    required this.middleName,
    required this.familyName,
    required this.middleInitial,
    required this.givenInitial,
  });

  factory VerifyNameMatchedComponents.fromJson(Map<String, dynamic> json) =>
      _$VerifyNameMatchedComponentsFromJson(json);

  static const toJsonFactory = _$VerifyNameMatchedComponentsToJson;
  Map<String, dynamic> toJson() => _$VerifyNameMatchedComponentsToJson(this);

  @JsonKey(name: 'given_name')
  final bool givenName;
  @JsonKey(name: 'middle_name')
  final bool middleName;
  @JsonKey(name: 'family_name')
  final bool familyName;
  @JsonKey(name: 'middle_initial')
  final bool middleInitial;
  @JsonKey(name: 'given_initial')
  final bool givenInitial;
  static const fromJsonFactory = _$VerifyNameMatchedComponentsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is VerifyNameMatchedComponents &&
            (identical(other.givenName, givenName) ||
                const DeepCollectionEquality().equals(
                  other.givenName,
                  givenName,
                )) &&
            (identical(other.middleName, middleName) ||
                const DeepCollectionEquality().equals(
                  other.middleName,
                  middleName,
                )) &&
            (identical(other.familyName, familyName) ||
                const DeepCollectionEquality().equals(
                  other.familyName,
                  familyName,
                )) &&
            (identical(other.middleInitial, middleInitial) ||
                const DeepCollectionEquality().equals(
                  other.middleInitial,
                  middleInitial,
                )) &&
            (identical(other.givenInitial, givenInitial) ||
                const DeepCollectionEquality().equals(
                  other.givenInitial,
                  givenInitial,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(givenName) ^
      const DeepCollectionEquality().hash(middleName) ^
      const DeepCollectionEquality().hash(familyName) ^
      const DeepCollectionEquality().hash(middleInitial) ^
      const DeepCollectionEquality().hash(givenInitial) ^
      runtimeType.hashCode;
}

extension $VerifyNameMatchedComponentsExtension on VerifyNameMatchedComponents {
  VerifyNameMatchedComponents copyWith({
    bool? givenName,
    bool? middleName,
    bool? familyName,
    bool? middleInitial,
    bool? givenInitial,
  }) {
    return VerifyNameMatchedComponents(
      givenName: givenName ?? this.givenName,
      middleName: middleName ?? this.middleName,
      familyName: familyName ?? this.familyName,
      middleInitial: middleInitial ?? this.middleInitial,
      givenInitial: givenInitial ?? this.givenInitial,
    );
  }

  VerifyNameMatchedComponents copyWithWrapped({
    Wrapped<bool>? givenName,
    Wrapped<bool>? middleName,
    Wrapped<bool>? familyName,
    Wrapped<bool>? middleInitial,
    Wrapped<bool>? givenInitial,
  }) {
    return VerifyNameMatchedComponents(
      givenName: (givenName != null ? givenName.value : this.givenName),
      middleName: (middleName != null ? middleName.value : this.middleName),
      familyName: (familyName != null ? familyName.value : this.familyName),
      middleInitial: (middleInitial != null
          ? middleInitial.value
          : this.middleInitial),
      givenInitial: (givenInitial != null
          ? givenInitial.value
          : this.givenInitial),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class VerifyNamePartySource {
  const VerifyNamePartySource({
    required this.type,
    required this.meta,
    required this.matchResult,
    required this.verification,
  });

  factory VerifyNamePartySource.fromJson(Map<String, dynamic> json) =>
      _$VerifyNamePartySourceFromJson(json);

  static const toJsonFactory = _$VerifyNamePartySourceToJson;
  Map<String, dynamic> toJson() => _$VerifyNamePartySourceToJson(this);

  @JsonKey(
    name: 'type',
    toJson: verifyNamePartySourceTypeToJson,
    fromJson: verifyNamePartySourceTypeFromJson,
  )
  final enums.VerifyNamePartySourceType type;
  @JsonKey(name: 'meta')
  final VerifyNamePartySource$Meta meta;
  @JsonKey(
    name: 'match_result',
    toJson: verifyNameMatchTypeToJson,
    fromJson: verifyNameMatchTypeFromJson,
  )
  final enums.VerifyNameMatchType matchResult;
  @JsonKey(name: 'verification')
  final VerifyNameMatchedComponents verification;
  static const fromJsonFactory = _$VerifyNamePartySourceFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is VerifyNamePartySource &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)) &&
            (identical(other.matchResult, matchResult) ||
                const DeepCollectionEquality().equals(
                  other.matchResult,
                  matchResult,
                )) &&
            (identical(other.verification, verification) ||
                const DeepCollectionEquality().equals(
                  other.verification,
                  verification,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(meta) ^
      const DeepCollectionEquality().hash(matchResult) ^
      const DeepCollectionEquality().hash(verification) ^
      runtimeType.hashCode;
}

extension $VerifyNamePartySourceExtension on VerifyNamePartySource {
  VerifyNamePartySource copyWith({
    enums.VerifyNamePartySourceType? type,
    VerifyNamePartySource$Meta? meta,
    enums.VerifyNameMatchType? matchResult,
    VerifyNameMatchedComponents? verification,
  }) {
    return VerifyNamePartySource(
      type: type ?? this.type,
      meta: meta ?? this.meta,
      matchResult: matchResult ?? this.matchResult,
      verification: verification ?? this.verification,
    );
  }

  VerifyNamePartySource copyWithWrapped({
    Wrapped<enums.VerifyNamePartySourceType>? type,
    Wrapped<VerifyNamePartySource$Meta>? meta,
    Wrapped<enums.VerifyNameMatchType>? matchResult,
    Wrapped<VerifyNameMatchedComponents>? verification,
  }) {
    return VerifyNamePartySource(
      type: (type != null ? type.value : this.type),
      meta: (meta != null ? meta.value : this.meta),
      matchResult: (matchResult != null ? matchResult.value : this.matchResult),
      verification: (verification != null
          ? verification.value
          : this.verification),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class VerifyNameHolderSource {
  const VerifyNameHolderSource({
    required this.type,
    required this.meta,
    required this.matchResult,
    required this.verification,
  });

  factory VerifyNameHolderSource.fromJson(Map<String, dynamic> json) =>
      _$VerifyNameHolderSourceFromJson(json);

  static const toJsonFactory = _$VerifyNameHolderSourceToJson;
  Map<String, dynamic> toJson() => _$VerifyNameHolderSourceToJson(this);

  @JsonKey(
    name: 'type',
    toJson: verifyNameHolderSourceTypeToJson,
    fromJson: verifyNameHolderSourceTypeFromJson,
  )
  final enums.VerifyNameHolderSourceType type;
  @JsonKey(name: 'meta')
  final VerifyNameHolderSource$Meta meta;
  @JsonKey(
    name: 'match_result',
    toJson: verifyNameMatchTypeToJson,
    fromJson: verifyNameMatchTypeFromJson,
  )
  final enums.VerifyNameMatchType matchResult;
  @JsonKey(name: 'verification')
  final VerifyNameMatchedComponents verification;
  static const fromJsonFactory = _$VerifyNameHolderSourceFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is VerifyNameHolderSource &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)) &&
            (identical(other.matchResult, matchResult) ||
                const DeepCollectionEquality().equals(
                  other.matchResult,
                  matchResult,
                )) &&
            (identical(other.verification, verification) ||
                const DeepCollectionEquality().equals(
                  other.verification,
                  verification,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(meta) ^
      const DeepCollectionEquality().hash(matchResult) ^
      const DeepCollectionEquality().hash(verification) ^
      runtimeType.hashCode;
}

extension $VerifyNameHolderSourceExtension on VerifyNameHolderSource {
  VerifyNameHolderSource copyWith({
    enums.VerifyNameHolderSourceType? type,
    VerifyNameHolderSource$Meta? meta,
    enums.VerifyNameMatchType? matchResult,
    VerifyNameMatchedComponents? verification,
  }) {
    return VerifyNameHolderSource(
      type: type ?? this.type,
      meta: meta ?? this.meta,
      matchResult: matchResult ?? this.matchResult,
      verification: verification ?? this.verification,
    );
  }

  VerifyNameHolderSource copyWithWrapped({
    Wrapped<enums.VerifyNameHolderSourceType>? type,
    Wrapped<VerifyNameHolderSource$Meta>? meta,
    Wrapped<enums.VerifyNameMatchType>? matchResult,
    Wrapped<VerifyNameMatchedComponents>? verification,
  }) {
    return VerifyNameHolderSource(
      type: (type != null ? type.value : this.type),
      meta: (meta != null ? meta.value : this.meta),
      matchResult: (matchResult != null ? matchResult.value : this.matchResult),
      verification: (verification != null
          ? verification.value
          : this.verification),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class VerifyNameSource {
  const VerifyNameSource();

  factory VerifyNameSource.fromJson(Map<String, dynamic> json) =>
      _$VerifyNameSourceFromJson(json);

  static const toJsonFactory = _$VerifyNameSourceToJson;
  Map<String, dynamic> toJson() => _$VerifyNameSourceToJson(this);

  static const fromJsonFactory = _$VerifyNameSourceFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class VerifyNameResult {
  const VerifyNameResult();

  factory VerifyNameResult.fromJson(Map<String, dynamic> json) =>
      _$VerifyNameResultFromJson(json);

  static const toJsonFactory = _$VerifyNameResultToJson;
  Map<String, dynamic> toJson() => _$VerifyNameResultToJson(this);

  static const fromJsonFactory = _$VerifyNameResultFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class OneOffIdentityParty {
  const OneOffIdentityParty({
    this.givenName,
    this.middleName,
    this.familyName,
    this.initials,
    this.prefix,
    this.gender,
  });

  factory OneOffIdentityParty.fromJson(Map<String, dynamic> json) =>
      _$OneOffIdentityPartyFromJson(json);

  static const toJsonFactory = _$OneOffIdentityPartyToJson;
  Map<String, dynamic> toJson() => _$OneOffIdentityPartyToJson(this);

  @JsonKey(name: 'given_name')
  final String? givenName;
  @JsonKey(name: 'middle_name')
  final String? middleName;
  @JsonKey(name: 'family_name')
  final String? familyName;
  @JsonKey(name: 'initials', defaultValue: <String>[])
  final List<String>? initials;
  @JsonKey(name: 'prefix')
  final String? prefix;
  @JsonKey(
    name: 'gender',
    toJson: oneOffIdentityPartyGenderNullableToJson,
    fromJson: oneOffIdentityPartyGenderNullableFromJson,
  )
  final enums.OneOffIdentityPartyGender? gender;
  static const fromJsonFactory = _$OneOffIdentityPartyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OneOffIdentityParty &&
            (identical(other.givenName, givenName) ||
                const DeepCollectionEquality().equals(
                  other.givenName,
                  givenName,
                )) &&
            (identical(other.middleName, middleName) ||
                const DeepCollectionEquality().equals(
                  other.middleName,
                  middleName,
                )) &&
            (identical(other.familyName, familyName) ||
                const DeepCollectionEquality().equals(
                  other.familyName,
                  familyName,
                )) &&
            (identical(other.initials, initials) ||
                const DeepCollectionEquality().equals(
                  other.initials,
                  initials,
                )) &&
            (identical(other.prefix, prefix) ||
                const DeepCollectionEquality().equals(other.prefix, prefix)) &&
            (identical(other.gender, gender) ||
                const DeepCollectionEquality().equals(other.gender, gender)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(givenName) ^
      const DeepCollectionEquality().hash(middleName) ^
      const DeepCollectionEquality().hash(familyName) ^
      const DeepCollectionEquality().hash(initials) ^
      const DeepCollectionEquality().hash(prefix) ^
      const DeepCollectionEquality().hash(gender) ^
      runtimeType.hashCode;
}

extension $OneOffIdentityPartyExtension on OneOffIdentityParty {
  OneOffIdentityParty copyWith({
    String? givenName,
    String? middleName,
    String? familyName,
    List<String>? initials,
    String? prefix,
    enums.OneOffIdentityPartyGender? gender,
  }) {
    return OneOffIdentityParty(
      givenName: givenName ?? this.givenName,
      middleName: middleName ?? this.middleName,
      familyName: familyName ?? this.familyName,
      initials: initials ?? this.initials,
      prefix: prefix ?? this.prefix,
      gender: gender ?? this.gender,
    );
  }

  OneOffIdentityParty copyWithWrapped({
    Wrapped<String?>? givenName,
    Wrapped<String?>? middleName,
    Wrapped<String?>? familyName,
    Wrapped<List<String>?>? initials,
    Wrapped<String?>? prefix,
    Wrapped<enums.OneOffIdentityPartyGender?>? gender,
  }) {
    return OneOffIdentityParty(
      givenName: (givenName != null ? givenName.value : this.givenName),
      middleName: (middleName != null ? middleName.value : this.middleName),
      familyName: (familyName != null ? familyName.value : this.familyName),
      initials: (initials != null ? initials.value : this.initials),
      prefix: (prefix != null ? prefix.value : this.prefix),
      gender: (gender != null ? gender.value : this.gender),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OneOffVerifyNamePartySource {
  const OneOffVerifyNamePartySource({
    required this.type,
    required this.meta,
    required this.matchResult,
    required this.verification,
  });

  factory OneOffVerifyNamePartySource.fromJson(Map<String, dynamic> json) =>
      _$OneOffVerifyNamePartySourceFromJson(json);

  static const toJsonFactory = _$OneOffVerifyNamePartySourceToJson;
  Map<String, dynamic> toJson() => _$OneOffVerifyNamePartySourceToJson(this);

  @JsonKey(
    name: 'type',
    toJson: oneOffVerifyNamePartySourceTypeToJson,
    fromJson: oneOffVerifyNamePartySourceTypeFromJson,
  )
  final enums.OneOffVerifyNamePartySourceType type;
  @JsonKey(name: 'meta')
  final OneOffIdentityParty meta;
  @JsonKey(
    name: 'match_result',
    toJson: verifyNameMatchTypeToJson,
    fromJson: verifyNameMatchTypeFromJson,
  )
  final enums.VerifyNameMatchType matchResult;
  @JsonKey(name: 'verification')
  final VerifyNameMatchedComponents verification;
  static const fromJsonFactory = _$OneOffVerifyNamePartySourceFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OneOffVerifyNamePartySource &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)) &&
            (identical(other.matchResult, matchResult) ||
                const DeepCollectionEquality().equals(
                  other.matchResult,
                  matchResult,
                )) &&
            (identical(other.verification, verification) ||
                const DeepCollectionEquality().equals(
                  other.verification,
                  verification,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(meta) ^
      const DeepCollectionEquality().hash(matchResult) ^
      const DeepCollectionEquality().hash(verification) ^
      runtimeType.hashCode;
}

extension $OneOffVerifyNamePartySourceExtension on OneOffVerifyNamePartySource {
  OneOffVerifyNamePartySource copyWith({
    enums.OneOffVerifyNamePartySourceType? type,
    OneOffIdentityParty? meta,
    enums.VerifyNameMatchType? matchResult,
    VerifyNameMatchedComponents? verification,
  }) {
    return OneOffVerifyNamePartySource(
      type: type ?? this.type,
      meta: meta ?? this.meta,
      matchResult: matchResult ?? this.matchResult,
      verification: verification ?? this.verification,
    );
  }

  OneOffVerifyNamePartySource copyWithWrapped({
    Wrapped<enums.OneOffVerifyNamePartySourceType>? type,
    Wrapped<OneOffIdentityParty>? meta,
    Wrapped<enums.VerifyNameMatchType>? matchResult,
    Wrapped<VerifyNameMatchedComponents>? verification,
  }) {
    return OneOffVerifyNamePartySource(
      type: (type != null ? type.value : this.type),
      meta: (meta != null ? meta.value : this.meta),
      matchResult: (matchResult != null ? matchResult.value : this.matchResult),
      verification: (verification != null
          ? verification.value
          : this.verification),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OneOffVerifyNameHolderSource {
  const OneOffVerifyNameHolderSource({
    required this.type,
    required this.meta,
    required this.matchResult,
    required this.verification,
  });

  factory OneOffVerifyNameHolderSource.fromJson(Map<String, dynamic> json) =>
      _$OneOffVerifyNameHolderSourceFromJson(json);

  static const toJsonFactory = _$OneOffVerifyNameHolderSourceToJson;
  Map<String, dynamic> toJson() => _$OneOffVerifyNameHolderSourceToJson(this);

  @JsonKey(
    name: 'type',
    toJson: oneOffVerifyNameHolderSourceTypeToJson,
    fromJson: oneOffVerifyNameHolderSourceTypeFromJson,
  )
  final enums.OneOffVerifyNameHolderSourceType type;
  @JsonKey(name: 'meta')
  final OneOffIdentityAccount meta;
  @JsonKey(
    name: 'match_result',
    toJson: verifyNameMatchTypeToJson,
    fromJson: verifyNameMatchTypeFromJson,
  )
  final enums.VerifyNameMatchType matchResult;
  @JsonKey(name: 'verification')
  final VerifyNameMatchedComponents verification;
  static const fromJsonFactory = _$OneOffVerifyNameHolderSourceFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OneOffVerifyNameHolderSource &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)) &&
            (identical(other.matchResult, matchResult) ||
                const DeepCollectionEquality().equals(
                  other.matchResult,
                  matchResult,
                )) &&
            (identical(other.verification, verification) ||
                const DeepCollectionEquality().equals(
                  other.verification,
                  verification,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(meta) ^
      const DeepCollectionEquality().hash(matchResult) ^
      const DeepCollectionEquality().hash(verification) ^
      runtimeType.hashCode;
}

extension $OneOffVerifyNameHolderSourceExtension
    on OneOffVerifyNameHolderSource {
  OneOffVerifyNameHolderSource copyWith({
    enums.OneOffVerifyNameHolderSourceType? type,
    OneOffIdentityAccount? meta,
    enums.VerifyNameMatchType? matchResult,
    VerifyNameMatchedComponents? verification,
  }) {
    return OneOffVerifyNameHolderSource(
      type: type ?? this.type,
      meta: meta ?? this.meta,
      matchResult: matchResult ?? this.matchResult,
      verification: verification ?? this.verification,
    );
  }

  OneOffVerifyNameHolderSource copyWithWrapped({
    Wrapped<enums.OneOffVerifyNameHolderSourceType>? type,
    Wrapped<OneOffIdentityAccount>? meta,
    Wrapped<enums.VerifyNameMatchType>? matchResult,
    Wrapped<VerifyNameMatchedComponents>? verification,
  }) {
    return OneOffVerifyNameHolderSource(
      type: (type != null ? type.value : this.type),
      meta: (meta != null ? meta.value : this.meta),
      matchResult: (matchResult != null ? matchResult.value : this.matchResult),
      verification: (verification != null
          ? verification.value
          : this.verification),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OneOffVerifyNameSource {
  const OneOffVerifyNameSource();

  factory OneOffVerifyNameSource.fromJson(Map<String, dynamic> json) =>
      _$OneOffVerifyNameSourceFromJson(json);

  static const toJsonFactory = _$OneOffVerifyNameSourceToJson;
  Map<String, dynamic> toJson() => _$OneOffVerifyNameSourceToJson(this);

  static const fromJsonFactory = _$OneOffVerifyNameSourceFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class OneOffVerifyNameResult {
  const OneOffVerifyNameResult();

  factory OneOffVerifyNameResult.fromJson(Map<String, dynamic> json) =>
      _$OneOffVerifyNameResultFromJson(json);

  static const toJsonFactory = _$OneOffVerifyNameResultToJson;
  Map<String, dynamic> toJson() => _$OneOffVerifyNameResultToJson(this);

  static const fromJsonFactory = _$OneOffVerifyNameResultFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class CategoryGroups {
  const CategoryGroups();

  factory CategoryGroups.fromJson(Map<String, dynamic> json) =>
      _$CategoryGroupsFromJson(json);

  static const toJsonFactory = _$CategoryGroupsToJson;
  Map<String, dynamic> toJson() => _$CategoryGroupsToJson(this);

  static const fromJsonFactory = _$CategoryGroupsFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class Transaction {
  const Transaction({
    required this.id,
    required this.account,
    required this.connection,
    required this.user,
    this.migrated,
    this.migratedAccount,
    required this.createdAt,
    required this.updatedAt,
    required this.date,
    required this.description,
    required this.amount,
    this.balance,
    required this.type,
    this.hash,
    this.merchant,
    this.category,
    this.meta,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  static const toJsonFactory = _$TransactionToJson;
  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: '_account')
  final String account;
  @JsonKey(name: '_connection')
  final String connection;
  @JsonKey(name: '_user')
  final String user;
  @JsonKey(name: '_migrated')
  final String? migrated;
  @JsonKey(name: '_migrated_account')
  final String? migratedAccount;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'date')
  final DateTime date;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'amount')
  final double amount;
  @JsonKey(name: 'balance')
  final double? balance;
  @JsonKey(
    name: 'type',
    toJson: transactionTypeToJson,
    fromJson: transactionTypeFromJson,
  )
  final enums.TransactionType type;
  @JsonKey(name: 'hash')
  @deprecated
  final String? hash;
  @JsonKey(name: 'merchant')
  final Transaction$Merchant? merchant;
  @JsonKey(name: 'category')
  final Transaction$Category? category;
  @JsonKey(name: 'meta')
  final Transaction$Meta? meta;
  static const fromJsonFactory = _$TransactionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Transaction &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.account, account) ||
                const DeepCollectionEquality().equals(
                  other.account,
                  account,
                )) &&
            (identical(other.connection, connection) ||
                const DeepCollectionEquality().equals(
                  other.connection,
                  connection,
                )) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.migrated, migrated) ||
                const DeepCollectionEquality().equals(
                  other.migrated,
                  migrated,
                )) &&
            (identical(other.migratedAccount, migratedAccount) ||
                const DeepCollectionEquality().equals(
                  other.migratedAccount,
                  migratedAccount,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality().equals(
                  other.balance,
                  balance,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.hash, hash) ||
                const DeepCollectionEquality().equals(other.hash, hash)) &&
            (identical(other.merchant, merchant) ||
                const DeepCollectionEquality().equals(
                  other.merchant,
                  merchant,
                )) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality().equals(
                  other.category,
                  category,
                )) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(account) ^
      const DeepCollectionEquality().hash(connection) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(migrated) ^
      const DeepCollectionEquality().hash(migratedAccount) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(balance) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(hash) ^
      const DeepCollectionEquality().hash(merchant) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(meta) ^
      runtimeType.hashCode;
}

extension $TransactionExtension on Transaction {
  Transaction copyWith({
    String? id,
    String? account,
    String? connection,
    String? user,
    String? migrated,
    String? migratedAccount,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? date,
    String? description,
    double? amount,
    double? balance,
    enums.TransactionType? type,
    String? hash,
    Transaction$Merchant? merchant,
    Transaction$Category? category,
    Transaction$Meta? meta,
  }) {
    return Transaction(
      id: id ?? this.id,
      account: account ?? this.account,
      connection: connection ?? this.connection,
      user: user ?? this.user,
      migrated: migrated ?? this.migrated,
      migratedAccount: migratedAccount ?? this.migratedAccount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      date: date ?? this.date,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      balance: balance ?? this.balance,
      type: type ?? this.type,
      hash: hash ?? this.hash,
      merchant: merchant ?? this.merchant,
      category: category ?? this.category,
      meta: meta ?? this.meta,
    );
  }

  Transaction copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? account,
    Wrapped<String>? connection,
    Wrapped<String>? user,
    Wrapped<String?>? migrated,
    Wrapped<String?>? migratedAccount,
    Wrapped<DateTime>? createdAt,
    Wrapped<DateTime>? updatedAt,
    Wrapped<DateTime>? date,
    Wrapped<String>? description,
    Wrapped<double>? amount,
    Wrapped<double?>? balance,
    Wrapped<enums.TransactionType>? type,
    Wrapped<String?>? hash,
    Wrapped<Transaction$Merchant?>? merchant,
    Wrapped<Transaction$Category?>? category,
    Wrapped<Transaction$Meta?>? meta,
  }) {
    return Transaction(
      id: (id != null ? id.value : this.id),
      account: (account != null ? account.value : this.account),
      connection: (connection != null ? connection.value : this.connection),
      user: (user != null ? user.value : this.user),
      migrated: (migrated != null ? migrated.value : this.migrated),
      migratedAccount: (migratedAccount != null
          ? migratedAccount.value
          : this.migratedAccount),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      date: (date != null ? date.value : this.date),
      description: (description != null ? description.value : this.description),
      amount: (amount != null ? amount.value : this.amount),
      balance: (balance != null ? balance.value : this.balance),
      type: (type != null ? type.value : this.type),
      hash: (hash != null ? hash.value : this.hash),
      merchant: (merchant != null ? merchant.value : this.merchant),
      category: (category != null ? category.value : this.category),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Category {
  const Category({this.id, this.name, this.groups});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  static const toJsonFactory = _$CategoryToJson;
  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'groups')
  final CategoryGroups? groups;
  static const fromJsonFactory = _$CategoryFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Category &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groups, groups) ||
                const DeepCollectionEquality().equals(other.groups, groups)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(groups) ^
      runtimeType.hashCode;
}

extension $CategoryExtension on Category {
  Category copyWith({String? id, String? name, CategoryGroups? groups}) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      groups: groups ?? this.groups,
    );
  }

  Category copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<String?>? name,
    Wrapped<CategoryGroups?>? groups,
  }) {
    return Category(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      groups: (groups != null ? groups.value : this.groups),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PendingTransaction {
  const PendingTransaction({
    this.account,
    this.connection,
    this.user,
    this.updatedAt,
    this.date,
    this.description,
    this.amount,
    this.type,
    this.meta,
  });

  factory PendingTransaction.fromJson(Map<String, dynamic> json) =>
      _$PendingTransactionFromJson(json);

  static const toJsonFactory = _$PendingTransactionToJson;
  Map<String, dynamic> toJson() => _$PendingTransactionToJson(this);

  @JsonKey(name: '_account')
  final String? account;
  @JsonKey(name: '_connection')
  final String? connection;
  @JsonKey(name: '_user')
  final String? user;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'date')
  final DateTime? date;
  @JsonKey(name: 'description')
  final String? description;
  @JsonKey(name: 'amount')
  final double? amount;
  @JsonKey(
    name: 'type',
    toJson: transactionTypeNullableToJson,
    fromJson: transactionTypeNullableFromJson,
  )
  final enums.TransactionType? type;
  @JsonKey(name: 'meta')
  final PendingTransaction$Meta? meta;
  static const fromJsonFactory = _$PendingTransactionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PendingTransaction &&
            (identical(other.account, account) ||
                const DeepCollectionEquality().equals(
                  other.account,
                  account,
                )) &&
            (identical(other.connection, connection) ||
                const DeepCollectionEquality().equals(
                  other.connection,
                  connection,
                )) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality().equals(
                  other.description,
                  description,
                )) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(account) ^
      const DeepCollectionEquality().hash(connection) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(meta) ^
      runtimeType.hashCode;
}

extension $PendingTransactionExtension on PendingTransaction {
  PendingTransaction copyWith({
    String? account,
    String? connection,
    String? user,
    DateTime? updatedAt,
    DateTime? date,
    String? description,
    double? amount,
    enums.TransactionType? type,
    PendingTransaction$Meta? meta,
  }) {
    return PendingTransaction(
      account: account ?? this.account,
      connection: connection ?? this.connection,
      user: user ?? this.user,
      updatedAt: updatedAt ?? this.updatedAt,
      date: date ?? this.date,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      meta: meta ?? this.meta,
    );
  }

  PendingTransaction copyWithWrapped({
    Wrapped<String?>? account,
    Wrapped<String?>? connection,
    Wrapped<String?>? user,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<DateTime?>? date,
    Wrapped<String?>? description,
    Wrapped<double?>? amount,
    Wrapped<enums.TransactionType?>? type,
    Wrapped<PendingTransaction$Meta?>? meta,
  }) {
    return PendingTransaction(
      account: (account != null ? account.value : this.account),
      connection: (connection != null ? connection.value : this.connection),
      user: (user != null ? user.value : this.user),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      date: (date != null ? date.value : this.date),
      description: (description != null ? description.value : this.description),
      amount: (amount != null ? amount.value : this.amount),
      type: (type != null ? type.value : this.type),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Payment {
  const Payment({
    this.id,
    this.from,
    this.to,
    this.amount,
    this.meta,
    this.sid,
    this.status,
    this.statusText,
    this.$final,
    this.timeline,
    this.createdAt,
    this.updatedAt,
    this.receivedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  static const toJsonFactory = _$PaymentToJson;
  Map<String, dynamic> toJson() => _$PaymentToJson(this);

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'from')
  final String? from;
  @JsonKey(name: 'to')
  final Payment$To? to;
  @JsonKey(name: 'amount')
  final double? amount;
  @JsonKey(name: 'meta')
  final Payment$Meta? meta;
  @JsonKey(name: 'sid')
  final String? sid;
  @JsonKey(
    name: 'status',
    toJson: paymentStatusNullableToJson,
    fromJson: paymentStatusNullableFromJson,
  )
  final enums.PaymentStatus? status;
  @JsonKey(name: 'status_text')
  final String? statusText;
  @JsonKey(name: 'final')
  final bool? $final;
  @JsonKey(name: 'timeline')
  final List<Payment$Timeline$Item>? timeline;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'received_at')
  final DateTime? receivedAt;
  static const fromJsonFactory = _$PaymentFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Payment &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.from, from) ||
                const DeepCollectionEquality().equals(other.from, from)) &&
            (identical(other.to, to) ||
                const DeepCollectionEquality().equals(other.to, to)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)) &&
            (identical(other.sid, sid) ||
                const DeepCollectionEquality().equals(other.sid, sid)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.statusText, statusText) ||
                const DeepCollectionEquality().equals(
                  other.statusText,
                  statusText,
                )) &&
            (identical(other.$final, $final) ||
                const DeepCollectionEquality().equals(other.$final, $final)) &&
            (identical(other.timeline, timeline) ||
                const DeepCollectionEquality().equals(
                  other.timeline,
                  timeline,
                )) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.receivedAt, receivedAt) ||
                const DeepCollectionEquality().equals(
                  other.receivedAt,
                  receivedAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(from) ^
      const DeepCollectionEquality().hash(to) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(meta) ^
      const DeepCollectionEquality().hash(sid) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(statusText) ^
      const DeepCollectionEquality().hash($final) ^
      const DeepCollectionEquality().hash(timeline) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(receivedAt) ^
      runtimeType.hashCode;
}

extension $PaymentExtension on Payment {
  Payment copyWith({
    String? id,
    String? from,
    Payment$To? to,
    double? amount,
    Payment$Meta? meta,
    String? sid,
    enums.PaymentStatus? status,
    String? statusText,
    bool? $final,
    List<Payment$Timeline$Item>? timeline,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? receivedAt,
  }) {
    return Payment(
      id: id ?? this.id,
      from: from ?? this.from,
      to: to ?? this.to,
      amount: amount ?? this.amount,
      meta: meta ?? this.meta,
      sid: sid ?? this.sid,
      status: status ?? this.status,
      statusText: statusText ?? this.statusText,
      $final: $final ?? this.$final,
      timeline: timeline ?? this.timeline,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      receivedAt: receivedAt ?? this.receivedAt,
    );
  }

  Payment copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<String?>? from,
    Wrapped<Payment$To?>? to,
    Wrapped<double?>? amount,
    Wrapped<Payment$Meta?>? meta,
    Wrapped<String?>? sid,
    Wrapped<enums.PaymentStatus?>? status,
    Wrapped<String?>? statusText,
    Wrapped<bool?>? $final,
    Wrapped<List<Payment$Timeline$Item>?>? timeline,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<DateTime?>? receivedAt,
  }) {
    return Payment(
      id: (id != null ? id.value : this.id),
      from: (from != null ? from.value : this.from),
      to: (to != null ? to.value : this.to),
      amount: (amount != null ? amount.value : this.amount),
      meta: (meta != null ? meta.value : this.meta),
      sid: (sid != null ? sid.value : this.sid),
      status: (status != null ? status.value : this.status),
      statusText: (statusText != null ? statusText.value : this.statusText),
      $final: ($final != null ? $final.value : this.$final),
      timeline: (timeline != null ? timeline.value : this.timeline),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      receivedAt: (receivedAt != null ? receivedAt.value : this.receivedAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Party {
  const Party({
    required this.id,
    required this.connection,
    required this.user,
    required this.authorisation,
    required this.type,
    this.name,
    this.dob,
    this.taxNumber,
    this.phoneNumbers,
    this.emailAddresses,
    this.addresses,
  });

  factory Party.fromJson(Map<String, dynamic> json) => _$PartyFromJson(json);

  static const toJsonFactory = _$PartyToJson;
  Map<String, dynamic> toJson() => _$PartyToJson(this);

  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: '_connection')
  final String connection;
  @JsonKey(name: '_user')
  final String user;
  @JsonKey(name: '_authorisation')
  final String authorisation;
  @JsonKey(name: 'type', toJson: partyTypeToJson, fromJson: partyTypeFromJson)
  @deprecated
  final enums.PartyType type;
  @JsonKey(name: 'name')
  final Party$Name? name;
  @JsonKey(name: 'dob')
  final Party$Dob? dob;
  @JsonKey(name: 'tax_number')
  final Party$TaxNumber? taxNumber;
  @JsonKey(name: 'phone_numbers')
  final List<Party$PhoneNumbers$Item>? phoneNumbers;
  @JsonKey(name: 'email_addresses')
  final List<Party$EmailAddresses$Item>? emailAddresses;
  @JsonKey(name: 'addresses')
  final List<Party$Addresses$Item>? addresses;
  static const fromJsonFactory = _$PartyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Party &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.connection, connection) ||
                const DeepCollectionEquality().equals(
                  other.connection,
                  connection,
                )) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.authorisation, authorisation) ||
                const DeepCollectionEquality().equals(
                  other.authorisation,
                  authorisation,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.dob, dob) ||
                const DeepCollectionEquality().equals(other.dob, dob)) &&
            (identical(other.taxNumber, taxNumber) ||
                const DeepCollectionEquality().equals(
                  other.taxNumber,
                  taxNumber,
                )) &&
            (identical(other.phoneNumbers, phoneNumbers) ||
                const DeepCollectionEquality().equals(
                  other.phoneNumbers,
                  phoneNumbers,
                )) &&
            (identical(other.emailAddresses, emailAddresses) ||
                const DeepCollectionEquality().equals(
                  other.emailAddresses,
                  emailAddresses,
                )) &&
            (identical(other.addresses, addresses) ||
                const DeepCollectionEquality().equals(
                  other.addresses,
                  addresses,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(connection) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(authorisation) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(dob) ^
      const DeepCollectionEquality().hash(taxNumber) ^
      const DeepCollectionEquality().hash(phoneNumbers) ^
      const DeepCollectionEquality().hash(emailAddresses) ^
      const DeepCollectionEquality().hash(addresses) ^
      runtimeType.hashCode;
}

extension $PartyExtension on Party {
  Party copyWith({
    String? id,
    String? connection,
    String? user,
    String? authorisation,
    enums.PartyType? type,
    Party$Name? name,
    Party$Dob? dob,
    Party$TaxNumber? taxNumber,
    List<Party$PhoneNumbers$Item>? phoneNumbers,
    List<Party$EmailAddresses$Item>? emailAddresses,
    List<Party$Addresses$Item>? addresses,
  }) {
    return Party(
      id: id ?? this.id,
      connection: connection ?? this.connection,
      user: user ?? this.user,
      authorisation: authorisation ?? this.authorisation,
      type: type ?? this.type,
      name: name ?? this.name,
      dob: dob ?? this.dob,
      taxNumber: taxNumber ?? this.taxNumber,
      phoneNumbers: phoneNumbers ?? this.phoneNumbers,
      emailAddresses: emailAddresses ?? this.emailAddresses,
      addresses: addresses ?? this.addresses,
    );
  }

  Party copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? connection,
    Wrapped<String>? user,
    Wrapped<String>? authorisation,
    Wrapped<enums.PartyType>? type,
    Wrapped<Party$Name?>? name,
    Wrapped<Party$Dob?>? dob,
    Wrapped<Party$TaxNumber?>? taxNumber,
    Wrapped<List<Party$PhoneNumbers$Item>?>? phoneNumbers,
    Wrapped<List<Party$EmailAddresses$Item>?>? emailAddresses,
    Wrapped<List<Party$Addresses$Item>?>? addresses,
  }) {
    return Party(
      id: (id != null ? id.value : this.id),
      connection: (connection != null ? connection.value : this.connection),
      user: (user != null ? user.value : this.user),
      authorisation: (authorisation != null
          ? authorisation.value
          : this.authorisation),
      type: (type != null ? type.value : this.type),
      name: (name != null ? name.value : this.name),
      dob: (dob != null ? dob.value : this.dob),
      taxNumber: (taxNumber != null ? taxNumber.value : this.taxNumber),
      phoneNumbers: (phoneNumbers != null
          ? phoneNumbers.value
          : this.phoneNumbers),
      emailAddresses: (emailAddresses != null
          ? emailAddresses.value
          : this.emailAddresses),
      addresses: (addresses != null ? addresses.value : this.addresses),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Me {
  const Me({this.id, this.accessGrantedAt, this.email});

  factory Me.fromJson(Map<String, dynamic> json) => _$MeFromJson(json);

  static const toJsonFactory = _$MeToJson;
  Map<String, dynamic> toJson() => _$MeToJson(this);

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'access_granted_at')
  final DateTime? accessGrantedAt;
  @JsonKey(name: 'email')
  final String? email;
  static const fromJsonFactory = _$MeFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Me &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.accessGrantedAt, accessGrantedAt) ||
                const DeepCollectionEquality().equals(
                  other.accessGrantedAt,
                  accessGrantedAt,
                )) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(accessGrantedAt) ^
      const DeepCollectionEquality().hash(email) ^
      runtimeType.hashCode;
}

extension $MeExtension on Me {
  Me copyWith({String? id, DateTime? accessGrantedAt, String? email}) {
    return Me(
      id: id ?? this.id,
      accessGrantedAt: accessGrantedAt ?? this.accessGrantedAt,
      email: email ?? this.email,
    );
  }

  Me copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<DateTime?>? accessGrantedAt,
    Wrapped<String?>? email,
  }) {
    return Me(
      id: (id != null ? id.value : this.id),
      accessGrantedAt: (accessGrantedAt != null
          ? accessGrantedAt.value
          : this.accessGrantedAt),
      email: (email != null ? email.value : this.email),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Webhook {
  const Webhook({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.lastCalledAt,
    this.state,
    this.url,
  });

  factory Webhook.fromJson(Map<String, dynamic> json) =>
      _$WebhookFromJson(json);

  static const toJsonFactory = _$WebhookToJson;
  Map<String, dynamic> toJson() => _$WebhookToJson(this);

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'last_called_at')
  final DateTime? lastCalledAt;
  @JsonKey(name: 'state')
  final String? state;
  @JsonKey(name: 'url')
  final String? url;
  static const fromJsonFactory = _$WebhookFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Webhook &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.lastCalledAt, lastCalledAt) ||
                const DeepCollectionEquality().equals(
                  other.lastCalledAt,
                  lastCalledAt,
                )) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(lastCalledAt) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(url) ^
      runtimeType.hashCode;
}

extension $WebhookExtension on Webhook {
  Webhook copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastCalledAt,
    String? state,
    String? url,
  }) {
    return Webhook(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastCalledAt: lastCalledAt ?? this.lastCalledAt,
      state: state ?? this.state,
      url: url ?? this.url,
    );
  }

  Webhook copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<DateTime?>? lastCalledAt,
    Wrapped<String?>? state,
    Wrapped<String?>? url,
  }) {
    return Webhook(
      id: (id != null ? id.value : this.id),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      lastCalledAt: (lastCalledAt != null
          ? lastCalledAt.value
          : this.lastCalledAt),
      state: (state != null ? state.value : this.state),
      url: (url != null ? url.value : this.url),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookEvent {
  const WebhookEvent({
    this.id,
    this.hook,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.lastFailedAt,
    this.payload,
  });

  factory WebhookEvent.fromJson(Map<String, dynamic> json) =>
      _$WebhookEventFromJson(json);

  static const toJsonFactory = _$WebhookEventToJson;
  Map<String, dynamic> toJson() => _$WebhookEventToJson(this);

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'hook')
  final String? hook;
  @JsonKey(
    name: 'status',
    toJson: webhookEventStatusNullableToJson,
    fromJson: webhookEventStatusNullableFromJson,
  )
  final enums.WebhookEventStatus? status;
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'last_failed_at')
  final DateTime? lastFailedAt;
  @JsonKey(name: 'payload')
  final WebhookEvent$Payload? payload;
  static const fromJsonFactory = _$WebhookEventFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WebhookEvent &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.hook, hook) ||
                const DeepCollectionEquality().equals(other.hook, hook)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality().equals(
                  other.createdAt,
                  createdAt,
                )) &&
            (identical(other.updatedAt, updatedAt) ||
                const DeepCollectionEquality().equals(
                  other.updatedAt,
                  updatedAt,
                )) &&
            (identical(other.lastFailedAt, lastFailedAt) ||
                const DeepCollectionEquality().equals(
                  other.lastFailedAt,
                  lastFailedAt,
                )) &&
            (identical(other.payload, payload) ||
                const DeepCollectionEquality().equals(other.payload, payload)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(hook) ^
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(updatedAt) ^
      const DeepCollectionEquality().hash(lastFailedAt) ^
      const DeepCollectionEquality().hash(payload) ^
      runtimeType.hashCode;
}

extension $WebhookEventExtension on WebhookEvent {
  WebhookEvent copyWith({
    String? id,
    String? hook,
    enums.WebhookEventStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastFailedAt,
    WebhookEvent$Payload? payload,
  }) {
    return WebhookEvent(
      id: id ?? this.id,
      hook: hook ?? this.hook,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastFailedAt: lastFailedAt ?? this.lastFailedAt,
      payload: payload ?? this.payload,
    );
  }

  WebhookEvent copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<String?>? hook,
    Wrapped<enums.WebhookEventStatus?>? status,
    Wrapped<DateTime?>? createdAt,
    Wrapped<DateTime?>? updatedAt,
    Wrapped<DateTime?>? lastFailedAt,
    Wrapped<WebhookEvent$Payload?>? payload,
  }) {
    return WebhookEvent(
      id: (id != null ? id.value : this.id),
      hook: (hook != null ? hook.value : this.hook),
      status: (status != null ? status.value : this.status),
      createdAt: (createdAt != null ? createdAt.value : this.createdAt),
      updatedAt: (updatedAt != null ? updatedAt.value : this.updatedAt),
      lastFailedAt: (lastFailedAt != null
          ? lastFailedAt.value
          : this.lastFailedAt),
      payload: (payload != null ? payload.value : this.payload),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AuthorisationRequestSuccessResponse {
  const AuthorisationRequestSuccessResponse({
    required this.success,
    required this.requestUri,
    required this.authorisationUrl,
    required this.expiresIn,
  });

  factory AuthorisationRequestSuccessResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$AuthorisationRequestSuccessResponseFromJson(json);

  static const toJsonFactory = _$AuthorisationRequestSuccessResponseToJson;
  Map<String, dynamic> toJson() =>
      _$AuthorisationRequestSuccessResponseToJson(this);

  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(name: 'request_uri')
  final String requestUri;
  @JsonKey(name: 'authorisation_url')
  final String authorisationUrl;
  @JsonKey(name: 'expires_in')
  final double expiresIn;
  static const fromJsonFactory = _$AuthorisationRequestSuccessResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthorisationRequestSuccessResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.requestUri, requestUri) ||
                const DeepCollectionEquality().equals(
                  other.requestUri,
                  requestUri,
                )) &&
            (identical(other.authorisationUrl, authorisationUrl) ||
                const DeepCollectionEquality().equals(
                  other.authorisationUrl,
                  authorisationUrl,
                )) &&
            (identical(other.expiresIn, expiresIn) ||
                const DeepCollectionEquality().equals(
                  other.expiresIn,
                  expiresIn,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(requestUri) ^
      const DeepCollectionEquality().hash(authorisationUrl) ^
      const DeepCollectionEquality().hash(expiresIn) ^
      runtimeType.hashCode;
}

extension $AuthorisationRequestSuccessResponseExtension
    on AuthorisationRequestSuccessResponse {
  AuthorisationRequestSuccessResponse copyWith({
    bool? success,
    String? requestUri,
    String? authorisationUrl,
    double? expiresIn,
  }) {
    return AuthorisationRequestSuccessResponse(
      success: success ?? this.success,
      requestUri: requestUri ?? this.requestUri,
      authorisationUrl: authorisationUrl ?? this.authorisationUrl,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }

  AuthorisationRequestSuccessResponse copyWithWrapped({
    Wrapped<bool>? success,
    Wrapped<String>? requestUri,
    Wrapped<String>? authorisationUrl,
    Wrapped<double>? expiresIn,
  }) {
    return AuthorisationRequestSuccessResponse(
      success: (success != null ? success.value : this.success),
      requestUri: (requestUri != null ? requestUri.value : this.requestUri),
      authorisationUrl: (authorisationUrl != null
          ? authorisationUrl.value
          : this.authorisationUrl),
      expiresIn: (expiresIn != null ? expiresIn.value : this.expiresIn),
    );
  }
}

typedef IssuePath = List<Object>;

@JsonSerializable(explicitToJson: true)
class CreateAuthorisationRequestInvalidRequestResponse {
  const CreateAuthorisationRequestInvalidRequestResponse({
    required this.success,
    required this.error,
    required this.errorDescription,
    this.issues,
  });

  factory CreateAuthorisationRequestInvalidRequestResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$CreateAuthorisationRequestInvalidRequestResponseFromJson(json);

  static const toJsonFactory =
      _$CreateAuthorisationRequestInvalidRequestResponseToJson;
  Map<String, dynamic> toJson() =>
      _$CreateAuthorisationRequestInvalidRequestResponseToJson(this);

  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(
    name: 'error',
    toJson: oAuth400ErrorCodeToJson,
    fromJson: oAuth400ErrorCodeFromJson,
  )
  final enums.OAuth400ErrorCode error;
  @JsonKey(name: 'error_description')
  final String errorDescription;
  @JsonKey(name: 'issues')
  final List<CreateAuthorisationRequestInvalidRequestResponse$Issues$Item>?
  issues;
  static const fromJsonFactory =
      _$CreateAuthorisationRequestInvalidRequestResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateAuthorisationRequestInvalidRequestResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)) &&
            (identical(other.errorDescription, errorDescription) ||
                const DeepCollectionEquality().equals(
                  other.errorDescription,
                  errorDescription,
                )) &&
            (identical(other.issues, issues) ||
                const DeepCollectionEquality().equals(other.issues, issues)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(error) ^
      const DeepCollectionEquality().hash(errorDescription) ^
      const DeepCollectionEquality().hash(issues) ^
      runtimeType.hashCode;
}

extension $CreateAuthorisationRequestInvalidRequestResponseExtension
    on CreateAuthorisationRequestInvalidRequestResponse {
  CreateAuthorisationRequestInvalidRequestResponse copyWith({
    bool? success,
    enums.OAuth400ErrorCode? error,
    String? errorDescription,
    List<CreateAuthorisationRequestInvalidRequestResponse$Issues$Item>? issues,
  }) {
    return CreateAuthorisationRequestInvalidRequestResponse(
      success: success ?? this.success,
      error: error ?? this.error,
      errorDescription: errorDescription ?? this.errorDescription,
      issues: issues ?? this.issues,
    );
  }

  CreateAuthorisationRequestInvalidRequestResponse copyWithWrapped({
    Wrapped<bool>? success,
    Wrapped<enums.OAuth400ErrorCode>? error,
    Wrapped<String>? errorDescription,
    Wrapped<
      List<CreateAuthorisationRequestInvalidRequestResponse$Issues$Item>?
    >?
    issues,
  }) {
    return CreateAuthorisationRequestInvalidRequestResponse(
      success: (success != null ? success.value : this.success),
      error: (error != null ? error.value : this.error),
      errorDescription: (errorDescription != null
          ? errorDescription.value
          : this.errorDescription),
      issues: (issues != null ? issues.value : this.issues),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OAuthUnauthorizedResponse {
  const OAuthUnauthorizedResponse({
    required this.success,
    required this.error,
    required this.errorDescription,
    this.issues,
  });

  factory OAuthUnauthorizedResponse.fromJson(Map<String, dynamic> json) =>
      _$OAuthUnauthorizedResponseFromJson(json);

  static const toJsonFactory = _$OAuthUnauthorizedResponseToJson;
  Map<String, dynamic> toJson() => _$OAuthUnauthorizedResponseToJson(this);

  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(
    name: 'error',
    toJson: oAuth401ErrorCodeToJson,
    fromJson: oAuth401ErrorCodeFromJson,
  )
  final enums.OAuth401ErrorCode error;
  @JsonKey(name: 'error_description')
  final String errorDescription;
  @JsonKey(name: 'issues')
  final List<OAuthUnauthorizedResponse$Issues$Item>? issues;
  static const fromJsonFactory = _$OAuthUnauthorizedResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OAuthUnauthorizedResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)) &&
            (identical(other.errorDescription, errorDescription) ||
                const DeepCollectionEquality().equals(
                  other.errorDescription,
                  errorDescription,
                )) &&
            (identical(other.issues, issues) ||
                const DeepCollectionEquality().equals(other.issues, issues)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(error) ^
      const DeepCollectionEquality().hash(errorDescription) ^
      const DeepCollectionEquality().hash(issues) ^
      runtimeType.hashCode;
}

extension $OAuthUnauthorizedResponseExtension on OAuthUnauthorizedResponse {
  OAuthUnauthorizedResponse copyWith({
    bool? success,
    enums.OAuth401ErrorCode? error,
    String? errorDescription,
    List<OAuthUnauthorizedResponse$Issues$Item>? issues,
  }) {
    return OAuthUnauthorizedResponse(
      success: success ?? this.success,
      error: error ?? this.error,
      errorDescription: errorDescription ?? this.errorDescription,
      issues: issues ?? this.issues,
    );
  }

  OAuthUnauthorizedResponse copyWithWrapped({
    Wrapped<bool>? success,
    Wrapped<enums.OAuth401ErrorCode>? error,
    Wrapped<String>? errorDescription,
    Wrapped<List<OAuthUnauthorizedResponse$Issues$Item>?>? issues,
  }) {
    return OAuthUnauthorizedResponse(
      success: (success != null ? success.value : this.success),
      error: (error != null ? error.value : this.error),
      errorDescription: (errorDescription != null
          ? errorDescription.value
          : this.errorDescription),
      issues: (issues != null ? issues.value : this.issues),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OAuthInternalServerErrorResponse {
  const OAuthInternalServerErrorResponse({
    required this.success,
    required this.error,
    required this.errorDescription,
    this.issues,
  });

  factory OAuthInternalServerErrorResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$OAuthInternalServerErrorResponseFromJson(json);

  static const toJsonFactory = _$OAuthInternalServerErrorResponseToJson;
  Map<String, dynamic> toJson() =>
      _$OAuthInternalServerErrorResponseToJson(this);

  @JsonKey(name: 'success')
  final bool success;
  @JsonKey(
    name: 'error',
    toJson: oAuth500ErrorCodeToJson,
    fromJson: oAuth500ErrorCodeFromJson,
  )
  final enums.OAuth500ErrorCode error;
  @JsonKey(name: 'error_description')
  final String errorDescription;
  @JsonKey(name: 'issues')
  final List<OAuthInternalServerErrorResponse$Issues$Item>? issues;
  static const fromJsonFactory = _$OAuthInternalServerErrorResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OAuthInternalServerErrorResponse &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)) &&
            (identical(other.errorDescription, errorDescription) ||
                const DeepCollectionEquality().equals(
                  other.errorDescription,
                  errorDescription,
                )) &&
            (identical(other.issues, issues) ||
                const DeepCollectionEquality().equals(other.issues, issues)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(error) ^
      const DeepCollectionEquality().hash(errorDescription) ^
      const DeepCollectionEquality().hash(issues) ^
      runtimeType.hashCode;
}

extension $OAuthInternalServerErrorResponseExtension
    on OAuthInternalServerErrorResponse {
  OAuthInternalServerErrorResponse copyWith({
    bool? success,
    enums.OAuth500ErrorCode? error,
    String? errorDescription,
    List<OAuthInternalServerErrorResponse$Issues$Item>? issues,
  }) {
    return OAuthInternalServerErrorResponse(
      success: success ?? this.success,
      error: error ?? this.error,
      errorDescription: errorDescription ?? this.errorDescription,
      issues: issues ?? this.issues,
    );
  }

  OAuthInternalServerErrorResponse copyWithWrapped({
    Wrapped<bool>? success,
    Wrapped<enums.OAuth500ErrorCode>? error,
    Wrapped<String>? errorDescription,
    Wrapped<List<OAuthInternalServerErrorResponse$Issues$Item>?>? issues,
  }) {
    return OAuthInternalServerErrorResponse(
      success: (success != null ? success.value : this.success),
      error: (error != null ? error.value : this.error),
      errorDescription: (errorDescription != null
          ? errorDescription.value
          : this.errorDescription),
      issues: (issues != null ? issues.value : this.issues),
    );
  }
}

typedef ConnectionIdArray = List<String>;

typedef ConnectionStubArray = List<String>;
typedef ConnectionsArray = Object;

@JsonSerializable(explicitToJson: true)
class TransactionConstraints {
  const TransactionConstraints({required this.startDate});

  factory TransactionConstraints.fromJson(Map<String, dynamic> json) =>
      _$TransactionConstraintsFromJson(json);

  static const toJsonFactory = _$TransactionConstraintsToJson;
  Map<String, dynamic> toJson() => _$TransactionConstraintsToJson(this);

  @JsonKey(name: 'start_date', toJson: _dateToJson)
  final DateTime startDate;
  static const fromJsonFactory = _$TransactionConstraintsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TransactionConstraints &&
            (identical(other.startDate, startDate) ||
                const DeepCollectionEquality().equals(
                  other.startDate,
                  startDate,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(startDate) ^ runtimeType.hashCode;
}

extension $TransactionConstraintsExtension on TransactionConstraints {
  TransactionConstraints copyWith({DateTime? startDate}) {
    return TransactionConstraints(startDate: startDate ?? this.startDate);
  }

  TransactionConstraints copyWithWrapped({Wrapped<DateTime>? startDate}) {
    return TransactionConstraints(
      startDate: (startDate != null ? startDate.value : this.startDate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class EnduringPaymentPeriodLimit {
  const EnduringPaymentPeriodLimit({
    required this.amount,
    required this.frequency,
  });

  factory EnduringPaymentPeriodLimit.fromJson(Map<String, dynamic> json) =>
      _$EnduringPaymentPeriodLimitFromJson(json);

  static const toJsonFactory = _$EnduringPaymentPeriodLimitToJson;
  Map<String, dynamic> toJson() => _$EnduringPaymentPeriodLimitToJson(this);

  @JsonKey(name: 'amount')
  final double amount;
  @JsonKey(
    name: 'frequency',
    toJson: enduringPaymentFrequencyToJson,
    fromJson: enduringPaymentFrequencyFromJson,
  )
  final enums.EnduringPaymentFrequency frequency;
  static const fromJsonFactory = _$EnduringPaymentPeriodLimitFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EnduringPaymentPeriodLimit &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.frequency, frequency) ||
                const DeepCollectionEquality().equals(
                  other.frequency,
                  frequency,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(frequency) ^
      runtimeType.hashCode;
}

extension $EnduringPaymentPeriodLimitExtension on EnduringPaymentPeriodLimit {
  EnduringPaymentPeriodLimit copyWith({
    double? amount,
    enums.EnduringPaymentFrequency? frequency,
  }) {
    return EnduringPaymentPeriodLimit(
      amount: amount ?? this.amount,
      frequency: frequency ?? this.frequency,
    );
  }

  EnduringPaymentPeriodLimit copyWithWrapped({
    Wrapped<double>? amount,
    Wrapped<enums.EnduringPaymentFrequency>? frequency,
  }) {
    return EnduringPaymentPeriodLimit(
      amount: (amount != null ? amount.value : this.amount),
      frequency: (frequency != null ? frequency.value : this.frequency),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentConsentStaticPayeeInput {
  const PaymentConsentStaticPayeeInput({
    required this.source,
    required this.accountNumber,
  });

  factory PaymentConsentStaticPayeeInput.fromJson(Map<String, dynamic> json) =>
      _$PaymentConsentStaticPayeeInputFromJson(json);

  static const toJsonFactory = _$PaymentConsentStaticPayeeInputToJson;
  Map<String, dynamic> toJson() => _$PaymentConsentStaticPayeeInputToJson(this);

  @JsonKey(
    name: 'source',
    toJson: paymentConsentStaticPayeeInputSourceToJson,
    fromJson: paymentConsentStaticPayeeInputSourceFromJson,
  )
  final enums.PaymentConsentStaticPayeeInputSource source;
  @JsonKey(name: 'account_number')
  final String accountNumber;
  static const fromJsonFactory = _$PaymentConsentStaticPayeeInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentConsentStaticPayeeInput &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.accountNumber, accountNumber) ||
                const DeepCollectionEquality().equals(
                  other.accountNumber,
                  accountNumber,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(source) ^
      const DeepCollectionEquality().hash(accountNumber) ^
      runtimeType.hashCode;
}

extension $PaymentConsentStaticPayeeInputExtension
    on PaymentConsentStaticPayeeInput {
  PaymentConsentStaticPayeeInput copyWith({
    enums.PaymentConsentStaticPayeeInputSource? source,
    String? accountNumber,
  }) {
    return PaymentConsentStaticPayeeInput(
      source: source ?? this.source,
      accountNumber: accountNumber ?? this.accountNumber,
    );
  }

  PaymentConsentStaticPayeeInput copyWithWrapped({
    Wrapped<enums.PaymentConsentStaticPayeeInputSource>? source,
    Wrapped<String>? accountNumber,
  }) {
    return PaymentConsentStaticPayeeInput(
      source: (source != null ? source.value : this.source),
      accountNumber: (accountNumber != null
          ? accountNumber.value
          : this.accountNumber),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentConsentRegisteredPayeeInput {
  const PaymentConsentRegisteredPayeeInput({
    required this.source,
    required this.payee,
  });

  factory PaymentConsentRegisteredPayeeInput.fromJson(
    Map<String, dynamic> json,
  ) => _$PaymentConsentRegisteredPayeeInputFromJson(json);

  static const toJsonFactory = _$PaymentConsentRegisteredPayeeInputToJson;
  Map<String, dynamic> toJson() =>
      _$PaymentConsentRegisteredPayeeInputToJson(this);

  @JsonKey(
    name: 'source',
    toJson: paymentConsentRegisteredPayeeInputSourceToJson,
    fromJson: paymentConsentRegisteredPayeeInputSourceFromJson,
  )
  final enums.PaymentConsentRegisteredPayeeInputSource source;
  @JsonKey(name: '_payee')
  final String payee;
  static const fromJsonFactory = _$PaymentConsentRegisteredPayeeInputFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentConsentRegisteredPayeeInput &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.payee, payee) ||
                const DeepCollectionEquality().equals(other.payee, payee)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(source) ^
      const DeepCollectionEquality().hash(payee) ^
      runtimeType.hashCode;
}

extension $PaymentConsentRegisteredPayeeInputExtension
    on PaymentConsentRegisteredPayeeInput {
  PaymentConsentRegisteredPayeeInput copyWith({
    enums.PaymentConsentRegisteredPayeeInputSource? source,
    String? payee,
  }) {
    return PaymentConsentRegisteredPayeeInput(
      source: source ?? this.source,
      payee: payee ?? this.payee,
    );
  }

  PaymentConsentRegisteredPayeeInput copyWithWrapped({
    Wrapped<enums.PaymentConsentRegisteredPayeeInputSource>? source,
    Wrapped<String>? payee,
  }) {
    return PaymentConsentRegisteredPayeeInput(
      source: (source != null ? source.value : this.source),
      payee: (payee != null ? payee.value : this.payee),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentConsentInlinePayeeInputNoneVerified {
  const PaymentConsentInlinePayeeInputNoneVerified({
    required this.source,
    required this.accountNumber,
    required this.name,
    required this.verificationMethod,
  });

  factory PaymentConsentInlinePayeeInputNoneVerified.fromJson(
    Map<String, dynamic> json,
  ) => _$PaymentConsentInlinePayeeInputNoneVerifiedFromJson(json);

  static const toJsonFactory =
      _$PaymentConsentInlinePayeeInputNoneVerifiedToJson;
  Map<String, dynamic> toJson() =>
      _$PaymentConsentInlinePayeeInputNoneVerifiedToJson(this);

  @JsonKey(
    name: 'source',
    toJson: paymentConsentInlinePayeeInputNoneVerifiedSourceToJson,
    fromJson: paymentConsentInlinePayeeInputNoneVerifiedSourceFromJson,
  )
  final enums.PaymentConsentInlinePayeeInputNoneVerifiedSource source;
  @JsonKey(name: 'account_number')
  final String accountNumber;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(
    name: 'verification_method',
    toJson: paymentConsentInlinePayeeInputNoneVerifiedVerificationMethodToJson,
    fromJson:
        paymentConsentInlinePayeeInputNoneVerifiedVerificationMethodFromJson,
  )
  final enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod
  verificationMethod;
  static const fromJsonFactory =
      _$PaymentConsentInlinePayeeInputNoneVerifiedFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentConsentInlinePayeeInputNoneVerified &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.accountNumber, accountNumber) ||
                const DeepCollectionEquality().equals(
                  other.accountNumber,
                  accountNumber,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.verificationMethod, verificationMethod) ||
                const DeepCollectionEquality().equals(
                  other.verificationMethod,
                  verificationMethod,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(source) ^
      const DeepCollectionEquality().hash(accountNumber) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(verificationMethod) ^
      runtimeType.hashCode;
}

extension $PaymentConsentInlinePayeeInputNoneVerifiedExtension
    on PaymentConsentInlinePayeeInputNoneVerified {
  PaymentConsentInlinePayeeInputNoneVerified copyWith({
    enums.PaymentConsentInlinePayeeInputNoneVerifiedSource? source,
    String? accountNumber,
    String? name,
    enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod?
    verificationMethod,
  }) {
    return PaymentConsentInlinePayeeInputNoneVerified(
      source: source ?? this.source,
      accountNumber: accountNumber ?? this.accountNumber,
      name: name ?? this.name,
      verificationMethod: verificationMethod ?? this.verificationMethod,
    );
  }

  PaymentConsentInlinePayeeInputNoneVerified copyWithWrapped({
    Wrapped<enums.PaymentConsentInlinePayeeInputNoneVerifiedSource>? source,
    Wrapped<String>? accountNumber,
    Wrapped<String>? name,
    Wrapped<enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod>?
    verificationMethod,
  }) {
    return PaymentConsentInlinePayeeInputNoneVerified(
      source: (source != null ? source.value : this.source),
      accountNumber: (accountNumber != null
          ? accountNumber.value
          : this.accountNumber),
      name: (name != null ? name.value : this.name),
      verificationMethod: (verificationMethod != null
          ? verificationMethod.value
          : this.verificationMethod),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentConsentInlinePayeeInputClientVerified {
  const PaymentConsentInlinePayeeInputClientVerified({
    required this.source,
    required this.accountNumber,
    required this.name,
    required this.verificationMethod,
  });

  factory PaymentConsentInlinePayeeInputClientVerified.fromJson(
    Map<String, dynamic> json,
  ) => _$PaymentConsentInlinePayeeInputClientVerifiedFromJson(json);

  static const toJsonFactory =
      _$PaymentConsentInlinePayeeInputClientVerifiedToJson;
  Map<String, dynamic> toJson() =>
      _$PaymentConsentInlinePayeeInputClientVerifiedToJson(this);

  @JsonKey(
    name: 'source',
    toJson: paymentConsentInlinePayeeInputClientVerifiedSourceToJson,
    fromJson: paymentConsentInlinePayeeInputClientVerifiedSourceFromJson,
  )
  final enums.PaymentConsentInlinePayeeInputClientVerifiedSource source;
  @JsonKey(name: 'account_number')
  final String accountNumber;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(
    name: 'verification_method',
    toJson:
        paymentConsentInlinePayeeInputClientVerifiedVerificationMethodToJson,
    fromJson:
        paymentConsentInlinePayeeInputClientVerifiedVerificationMethodFromJson,
  )
  final enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod
  verificationMethod;
  static const fromJsonFactory =
      _$PaymentConsentInlinePayeeInputClientVerifiedFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentConsentInlinePayeeInputClientVerified &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.accountNumber, accountNumber) ||
                const DeepCollectionEquality().equals(
                  other.accountNumber,
                  accountNumber,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.verificationMethod, verificationMethod) ||
                const DeepCollectionEquality().equals(
                  other.verificationMethod,
                  verificationMethod,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(source) ^
      const DeepCollectionEquality().hash(accountNumber) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(verificationMethod) ^
      runtimeType.hashCode;
}

extension $PaymentConsentInlinePayeeInputClientVerifiedExtension
    on PaymentConsentInlinePayeeInputClientVerified {
  PaymentConsentInlinePayeeInputClientVerified copyWith({
    enums.PaymentConsentInlinePayeeInputClientVerifiedSource? source,
    String? accountNumber,
    String? name,
    enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod?
    verificationMethod,
  }) {
    return PaymentConsentInlinePayeeInputClientVerified(
      source: source ?? this.source,
      accountNumber: accountNumber ?? this.accountNumber,
      name: name ?? this.name,
      verificationMethod: verificationMethod ?? this.verificationMethod,
    );
  }

  PaymentConsentInlinePayeeInputClientVerified copyWithWrapped({
    Wrapped<enums.PaymentConsentInlinePayeeInputClientVerifiedSource>? source,
    Wrapped<String>? accountNumber,
    Wrapped<String>? name,
    Wrapped<
      enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod
    >?
    verificationMethod,
  }) {
    return PaymentConsentInlinePayeeInputClientVerified(
      source: (source != null ? source.value : this.source),
      accountNumber: (accountNumber != null
          ? accountNumber.value
          : this.accountNumber),
      name: (name != null ? name.value : this.name),
      verificationMethod: (verificationMethod != null
          ? verificationMethod.value
          : this.verificationMethod),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentConsentInlinePayeeInputVerifiedVerified {
  const PaymentConsentInlinePayeeInputVerifiedVerified({
    required this.source,
    required this.verificationMethod,
    required this.verificationToken,
  });

  factory PaymentConsentInlinePayeeInputVerifiedVerified.fromJson(
    Map<String, dynamic> json,
  ) => _$PaymentConsentInlinePayeeInputVerifiedVerifiedFromJson(json);

  static const toJsonFactory =
      _$PaymentConsentInlinePayeeInputVerifiedVerifiedToJson;
  Map<String, dynamic> toJson() =>
      _$PaymentConsentInlinePayeeInputVerifiedVerifiedToJson(this);

  @JsonKey(
    name: 'source',
    toJson: paymentConsentInlinePayeeInputVerifiedVerifiedSourceToJson,
    fromJson: paymentConsentInlinePayeeInputVerifiedVerifiedSourceFromJson,
  )
  final enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource source;
  @JsonKey(
    name: 'verification_method',
    toJson:
        paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethodToJson,
    fromJson:
        paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethodFromJson,
  )
  final enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod
  verificationMethod;
  @JsonKey(name: 'verification_token')
  final String verificationToken;
  static const fromJsonFactory =
      _$PaymentConsentInlinePayeeInputVerifiedVerifiedFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentConsentInlinePayeeInputVerifiedVerified &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.verificationMethod, verificationMethod) ||
                const DeepCollectionEquality().equals(
                  other.verificationMethod,
                  verificationMethod,
                )) &&
            (identical(other.verificationToken, verificationToken) ||
                const DeepCollectionEquality().equals(
                  other.verificationToken,
                  verificationToken,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(source) ^
      const DeepCollectionEquality().hash(verificationMethod) ^
      const DeepCollectionEquality().hash(verificationToken) ^
      runtimeType.hashCode;
}

extension $PaymentConsentInlinePayeeInputVerifiedVerifiedExtension
    on PaymentConsentInlinePayeeInputVerifiedVerified {
  PaymentConsentInlinePayeeInputVerifiedVerified copyWith({
    enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource? source,
    enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod?
    verificationMethod,
    String? verificationToken,
  }) {
    return PaymentConsentInlinePayeeInputVerifiedVerified(
      source: source ?? this.source,
      verificationMethod: verificationMethod ?? this.verificationMethod,
      verificationToken: verificationToken ?? this.verificationToken,
    );
  }

  PaymentConsentInlinePayeeInputVerifiedVerified copyWithWrapped({
    Wrapped<enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource>? source,
    Wrapped<
      enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod
    >?
    verificationMethod,
    Wrapped<String>? verificationToken,
  }) {
    return PaymentConsentInlinePayeeInputVerifiedVerified(
      source: (source != null ? source.value : this.source),
      verificationMethod: (verificationMethod != null
          ? verificationMethod.value
          : this.verificationMethod),
      verificationToken: (verificationToken != null
          ? verificationToken.value
          : this.verificationToken),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentConsentInlinePayeeInput {
  const PaymentConsentInlinePayeeInput();

  factory PaymentConsentInlinePayeeInput.fromJson(Map<String, dynamic> json) =>
      _$PaymentConsentInlinePayeeInputFromJson(json);

  static const toJsonFactory = _$PaymentConsentInlinePayeeInputToJson;
  Map<String, dynamic> toJson() => _$PaymentConsentInlinePayeeInputToJson(this);

  static const fromJsonFactory = _$PaymentConsentInlinePayeeInputFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

typedef EnduringPayee = Object;

@JsonSerializable(explicitToJson: true)
class EnduringAccessPaymentRequestApiView {
  const EnduringAccessPaymentRequestApiView({
    required this.singleLimit,
    required this.periodicLimit,
    required this.payees,
  });

  factory EnduringAccessPaymentRequestApiView.fromJson(
    Map<String, dynamic> json,
  ) => _$EnduringAccessPaymentRequestApiViewFromJson(json);

  static const toJsonFactory = _$EnduringAccessPaymentRequestApiViewToJson;
  Map<String, dynamic> toJson() =>
      _$EnduringAccessPaymentRequestApiViewToJson(this);

  @JsonKey(name: 'single_limit')
  final double singleLimit;
  @JsonKey(name: 'periodic_limit')
  final EnduringPaymentPeriodLimit periodicLimit;
  @JsonKey(name: 'payees', defaultValue: <EnduringPayee>[])
  final List<EnduringPayee> payees;
  static const fromJsonFactory = _$EnduringAccessPaymentRequestApiViewFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EnduringAccessPaymentRequestApiView &&
            (identical(other.singleLimit, singleLimit) ||
                const DeepCollectionEquality().equals(
                  other.singleLimit,
                  singleLimit,
                )) &&
            (identical(other.periodicLimit, periodicLimit) ||
                const DeepCollectionEquality().equals(
                  other.periodicLimit,
                  periodicLimit,
                )) &&
            (identical(other.payees, payees) ||
                const DeepCollectionEquality().equals(other.payees, payees)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(singleLimit) ^
      const DeepCollectionEquality().hash(periodicLimit) ^
      const DeepCollectionEquality().hash(payees) ^
      runtimeType.hashCode;
}

extension $EnduringAccessPaymentRequestApiViewExtension
    on EnduringAccessPaymentRequestApiView {
  EnduringAccessPaymentRequestApiView copyWith({
    double? singleLimit,
    EnduringPaymentPeriodLimit? periodicLimit,
    List<EnduringPayee>? payees,
  }) {
    return EnduringAccessPaymentRequestApiView(
      singleLimit: singleLimit ?? this.singleLimit,
      periodicLimit: periodicLimit ?? this.periodicLimit,
      payees: payees ?? this.payees,
    );
  }

  EnduringAccessPaymentRequestApiView copyWithWrapped({
    Wrapped<double>? singleLimit,
    Wrapped<EnduringPaymentPeriodLimit>? periodicLimit,
    Wrapped<List<EnduringPayee>>? payees,
  }) {
    return EnduringAccessPaymentRequestApiView(
      singleLimit: (singleLimit != null ? singleLimit.value : this.singleLimit),
      periodicLimit: (periodicLimit != null
          ? periodicLimit.value
          : this.periodicLimit),
      payees: (payees != null ? payees.value : this.payees),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class EnduringAccessConstraints {
  const EnduringAccessConstraints({this.transactions, this.payments});

  factory EnduringAccessConstraints.fromJson(Map<String, dynamic> json) =>
      _$EnduringAccessConstraintsFromJson(json);

  static const toJsonFactory = _$EnduringAccessConstraintsToJson;
  Map<String, dynamic> toJson() => _$EnduringAccessConstraintsToJson(this);

  @JsonKey(name: 'transactions')
  final TransactionConstraints? transactions;
  @JsonKey(name: 'payments')
  final EnduringAccessPaymentRequestApiView? payments;
  static const fromJsonFactory = _$EnduringAccessConstraintsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EnduringAccessConstraints &&
            (identical(other.transactions, transactions) ||
                const DeepCollectionEquality().equals(
                  other.transactions,
                  transactions,
                )) &&
            (identical(other.payments, payments) ||
                const DeepCollectionEquality().equals(
                  other.payments,
                  payments,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(transactions) ^
      const DeepCollectionEquality().hash(payments) ^
      runtimeType.hashCode;
}

extension $EnduringAccessConstraintsExtension on EnduringAccessConstraints {
  EnduringAccessConstraints copyWith({
    TransactionConstraints? transactions,
    EnduringAccessPaymentRequestApiView? payments,
  }) {
    return EnduringAccessConstraints(
      transactions: transactions ?? this.transactions,
      payments: payments ?? this.payments,
    );
  }

  EnduringAccessConstraints copyWithWrapped({
    Wrapped<TransactionConstraints?>? transactions,
    Wrapped<EnduringAccessPaymentRequestApiView?>? payments,
  }) {
    return EnduringAccessConstraints(
      transactions: (transactions != null
          ? transactions.value
          : this.transactions),
      payments: (payments != null ? payments.value : this.payments),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class EnduringAccessRequest {
  const EnduringAccessRequest({
    required this.type,
    this.connections,
    this.scope,
    this.constraints,
  });

  factory EnduringAccessRequest.fromJson(Map<String, dynamic> json) =>
      _$EnduringAccessRequestFromJson(json);

  static const toJsonFactory = _$EnduringAccessRequestToJson;
  Map<String, dynamic> toJson() => _$EnduringAccessRequestToJson(this);

  @JsonKey(
    name: 'type',
    toJson: enduringAccessRequestTypeToJson,
    fromJson: enduringAccessRequestTypeFromJson,
  )
  final enums.EnduringAccessRequestType type;
  @JsonKey(name: 'connections')
  final ConnectionsArray? connections;
  @JsonKey(
    name: 'scope',
    toJson: enduringAccessScopeListToJson,
    fromJson: enduringAccessScopeListFromJson,
  )
  final List<enums.EnduringAccessScope>? scope;
  @JsonKey(name: 'constraints')
  final EnduringAccessConstraints? constraints;
  static const fromJsonFactory = _$EnduringAccessRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EnduringAccessRequest &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.connections, connections) ||
                const DeepCollectionEquality().equals(
                  other.connections,
                  connections,
                )) &&
            (identical(other.scope, scope) ||
                const DeepCollectionEquality().equals(other.scope, scope)) &&
            (identical(other.constraints, constraints) ||
                const DeepCollectionEquality().equals(
                  other.constraints,
                  constraints,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(connections) ^
      const DeepCollectionEquality().hash(scope) ^
      const DeepCollectionEquality().hash(constraints) ^
      runtimeType.hashCode;
}

extension $EnduringAccessRequestExtension on EnduringAccessRequest {
  EnduringAccessRequest copyWith({
    enums.EnduringAccessRequestType? type,
    ConnectionsArray? connections,
    List<enums.EnduringAccessScope>? scope,
    EnduringAccessConstraints? constraints,
  }) {
    return EnduringAccessRequest(
      type: type ?? this.type,
      connections: connections ?? this.connections,
      scope: scope ?? this.scope,
      constraints: constraints ?? this.constraints,
    );
  }

  EnduringAccessRequest copyWithWrapped({
    Wrapped<enums.EnduringAccessRequestType>? type,
    Wrapped<ConnectionsArray?>? connections,
    Wrapped<List<enums.EnduringAccessScope>?>? scope,
    Wrapped<EnduringAccessConstraints?>? constraints,
  }) {
    return EnduringAccessRequest(
      type: (type != null ? type.value : this.type),
      connections: (connections != null ? connections.value : this.connections),
      scope: (scope != null ? scope.value : this.scope),
      constraints: (constraints != null ? constraints.value : this.constraints),
    );
  }
}

typedef EnduringLoginHint = Object;

@JsonSerializable(explicitToJson: true)
class EnduringPaymentConstraints {
  const EnduringPaymentConstraints({
    this.label,
    required this.singleLimit,
    required this.periodicLimit,
    required this.payees,
  });

  factory EnduringPaymentConstraints.fromJson(Map<String, dynamic> json) =>
      _$EnduringPaymentConstraintsFromJson(json);

  static const toJsonFactory = _$EnduringPaymentConstraintsToJson;
  Map<String, dynamic> toJson() => _$EnduringPaymentConstraintsToJson(this);

  @JsonKey(name: 'label')
  final String? label;
  @JsonKey(name: 'single_limit')
  final double singleLimit;
  @JsonKey(name: 'periodic_limit')
  final EnduringPaymentPeriodLimit periodicLimit;
  @JsonKey(name: 'payees', defaultValue: <EnduringPayee>[])
  final List<EnduringPayee> payees;
  static const fromJsonFactory = _$EnduringPaymentConstraintsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EnduringPaymentConstraints &&
            (identical(other.label, label) ||
                const DeepCollectionEquality().equals(other.label, label)) &&
            (identical(other.singleLimit, singleLimit) ||
                const DeepCollectionEquality().equals(
                  other.singleLimit,
                  singleLimit,
                )) &&
            (identical(other.periodicLimit, periodicLimit) ||
                const DeepCollectionEquality().equals(
                  other.periodicLimit,
                  periodicLimit,
                )) &&
            (identical(other.payees, payees) ||
                const DeepCollectionEquality().equals(other.payees, payees)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(label) ^
      const DeepCollectionEquality().hash(singleLimit) ^
      const DeepCollectionEquality().hash(periodicLimit) ^
      const DeepCollectionEquality().hash(payees) ^
      runtimeType.hashCode;
}

extension $EnduringPaymentConstraintsExtension on EnduringPaymentConstraints {
  EnduringPaymentConstraints copyWith({
    String? label,
    double? singleLimit,
    EnduringPaymentPeriodLimit? periodicLimit,
    List<EnduringPayee>? payees,
  }) {
    return EnduringPaymentConstraints(
      label: label ?? this.label,
      singleLimit: singleLimit ?? this.singleLimit,
      periodicLimit: periodicLimit ?? this.periodicLimit,
      payees: payees ?? this.payees,
    );
  }

  EnduringPaymentConstraints copyWithWrapped({
    Wrapped<String?>? label,
    Wrapped<double>? singleLimit,
    Wrapped<EnduringPaymentPeriodLimit>? periodicLimit,
    Wrapped<List<EnduringPayee>>? payees,
  }) {
    return EnduringPaymentConstraints(
      label: (label != null ? label.value : this.label),
      singleLimit: (singleLimit != null ? singleLimit.value : this.singleLimit),
      periodicLimit: (periodicLimit != null
          ? periodicLimit.value
          : this.periodicLimit),
      payees: (payees != null ? payees.value : this.payees),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class EnduringPaymentConsentRequest {
  const EnduringPaymentConsentRequest({
    required this.type,
    required this.user,
    required this.account,
    this.paymentConsent,
  });

  factory EnduringPaymentConsentRequest.fromJson(Map<String, dynamic> json) =>
      _$EnduringPaymentConsentRequestFromJson(json);

  static const toJsonFactory = _$EnduringPaymentConsentRequestToJson;
  Map<String, dynamic> toJson() => _$EnduringPaymentConsentRequestToJson(this);

  @JsonKey(
    name: 'type',
    toJson: enduringPaymentConsentRequestTypeToJson,
    fromJson: enduringPaymentConsentRequestTypeFromJson,
  )
  final enums.EnduringPaymentConsentRequestType type;
  @JsonKey(name: '_user')
  final String user;
  @JsonKey(name: '_account')
  final String account;
  @JsonKey(name: 'payment_consent')
  final EnduringPaymentConstraints? paymentConsent;
  static const fromJsonFactory = _$EnduringPaymentConsentRequestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is EnduringPaymentConsentRequest &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.user, user) ||
                const DeepCollectionEquality().equals(other.user, user)) &&
            (identical(other.account, account) ||
                const DeepCollectionEquality().equals(
                  other.account,
                  account,
                )) &&
            (identical(other.paymentConsent, paymentConsent) ||
                const DeepCollectionEquality().equals(
                  other.paymentConsent,
                  paymentConsent,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(user) ^
      const DeepCollectionEquality().hash(account) ^
      const DeepCollectionEquality().hash(paymentConsent) ^
      runtimeType.hashCode;
}

extension $EnduringPaymentConsentRequestExtension
    on EnduringPaymentConsentRequest {
  EnduringPaymentConsentRequest copyWith({
    enums.EnduringPaymentConsentRequestType? type,
    String? user,
    String? account,
    EnduringPaymentConstraints? paymentConsent,
  }) {
    return EnduringPaymentConsentRequest(
      type: type ?? this.type,
      user: user ?? this.user,
      account: account ?? this.account,
      paymentConsent: paymentConsent ?? this.paymentConsent,
    );
  }

  EnduringPaymentConsentRequest copyWithWrapped({
    Wrapped<enums.EnduringPaymentConsentRequestType>? type,
    Wrapped<String>? user,
    Wrapped<String>? account,
    Wrapped<EnduringPaymentConstraints?>? paymentConsent,
  }) {
    return EnduringPaymentConsentRequest(
      type: (type != null ? type.value : this.type),
      user: (user != null ? user.value : this.user),
      account: (account != null ? account.value : this.account),
      paymentConsent: (paymentConsent != null
          ? paymentConsent.value
          : this.paymentConsent),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AccessRequest {
  const AccessRequest();

  factory AccessRequest.fromJson(Map<String, dynamic> json) =>
      _$AccessRequestFromJson(json);

  static const toJsonFactory = _$AccessRequestToJson;
  Map<String, dynamic> toJson() => _$AccessRequestToJson(this);

  static const fromJsonFactory = _$AccessRequestFromJson;

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode => runtimeType.hashCode;
}

@JsonSerializable(explicitToJson: true)
class $400$Response {
  const $400$Response({this.success, this.message});

  factory $400$Response.fromJson(Map<String, dynamic> json) =>
      _$$400$ResponseFromJson(json);

  static const toJsonFactory = _$$400$ResponseToJson;
  Map<String, dynamic> toJson() => _$$400$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'message')
  final String? message;
  static const fromJsonFactory = _$$400$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is $400$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $$400$ResponseExtension on $400$Response {
  $400$Response copyWith({bool? success, String? message}) {
    return $400$Response(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  $400$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<String?>? message,
  }) {
    return $400$Response(
      success: (success != null ? success.value : this.success),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class $401$Response {
  const $401$Response({this.success, this.message});

  factory $401$Response.fromJson(Map<String, dynamic> json) =>
      _$$401$ResponseFromJson(json);

  static const toJsonFactory = _$$401$ResponseToJson;
  Map<String, dynamic> toJson() => _$$401$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'message')
  final String? message;
  static const fromJsonFactory = _$$401$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is $401$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $$401$ResponseExtension on $401$Response {
  $401$Response copyWith({bool? success, String? message}) {
    return $401$Response(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  $401$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<String?>? message,
  }) {
    return $401$Response(
      success: (success != null ? success.value : this.success),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class $403$Response {
  const $403$Response({this.success, this.message});

  factory $403$Response.fromJson(Map<String, dynamic> json) =>
      _$$403$ResponseFromJson(json);

  static const toJsonFactory = _$$403$ResponseToJson;
  Map<String, dynamic> toJson() => _$$403$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'message')
  final String? message;
  static const fromJsonFactory = _$$403$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is $403$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $$403$ResponseExtension on $403$Response {
  $403$Response copyWith({bool? success, String? message}) {
    return $403$Response(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  $403$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<String?>? message,
  }) {
    return $403$Response(
      success: (success != null ? success.value : this.success),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class $404$Response {
  const $404$Response({this.success, this.message});

  factory $404$Response.fromJson(Map<String, dynamic> json) =>
      _$$404$ResponseFromJson(json);

  static const toJsonFactory = _$$404$ResponseToJson;
  Map<String, dynamic> toJson() => _$$404$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'message')
  final String? message;
  static const fromJsonFactory = _$$404$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is $404$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $$404$ResponseExtension on $404$Response {
  $404$Response copyWith({bool? success, String? message}) {
    return $404$Response(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  $404$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<String?>? message,
  }) {
    return $404$Response(
      success: (success != null ? success.value : this.success),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class $429$Response {
  const $429$Response({this.success, this.message});

  factory $429$Response.fromJson(Map<String, dynamic> json) =>
      _$$429$ResponseFromJson(json);

  static const toJsonFactory = _$$429$ResponseToJson;
  Map<String, dynamic> toJson() => _$$429$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'message')
  final String? message;
  static const fromJsonFactory = _$$429$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is $429$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $$429$ResponseExtension on $429$Response {
  $429$Response copyWith({bool? success, String? message}) {
    return $429$Response(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  $429$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<String?>? message,
  }) {
    return $429$Response(
      success: (success != null ? success.value : this.success),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class $500$Response {
  const $500$Response({this.success, this.message});

  factory $500$Response.fromJson(Map<String, dynamic> json) =>
      _$$500$ResponseFromJson(json);

  static const toJsonFactory = _$$500$ResponseToJson;
  Map<String, dynamic> toJson() => _$$500$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'message')
  final String? message;
  static const fromJsonFactory = _$$500$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is $500$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(message) ^
      runtimeType.hashCode;
}

extension $$500$ResponseExtension on $500$Response {
  $500$Response copyWith({bool? success, String? message}) {
    return $500$Response(
      success: success ?? this.success,
      message: message ?? this.message,
    );
  }

  $500$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<String?>? message,
  }) {
    return $500$Response(
      success: (success != null ? success.value : this.success),
      message: (message != null ? message.value : this.message),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TokenPost$RequestBody {
  const TokenPost$RequestBody({
    required this.grantType,
    required this.code,
    required this.redirectUri,
    required this.clientId,
    required this.clientSecret,
  });

  factory TokenPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$TokenPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$TokenPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$TokenPost$RequestBodyToJson(this);

  @JsonKey(name: 'grant_type')
  final String grantType;
  @JsonKey(name: 'code')
  final String code;
  @JsonKey(name: 'redirect_uri')
  final String redirectUri;
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'client_secret')
  final String clientSecret;
  static const fromJsonFactory = _$TokenPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TokenPost$RequestBody &&
            (identical(other.grantType, grantType) ||
                const DeepCollectionEquality().equals(
                  other.grantType,
                  grantType,
                )) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.redirectUri, redirectUri) ||
                const DeepCollectionEquality().equals(
                  other.redirectUri,
                  redirectUri,
                )) &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality().equals(
                  other.clientId,
                  clientId,
                )) &&
            (identical(other.clientSecret, clientSecret) ||
                const DeepCollectionEquality().equals(
                  other.clientSecret,
                  clientSecret,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(grantType) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(redirectUri) ^
      const DeepCollectionEquality().hash(clientId) ^
      const DeepCollectionEquality().hash(clientSecret) ^
      runtimeType.hashCode;
}

extension $TokenPost$RequestBodyExtension on TokenPost$RequestBody {
  TokenPost$RequestBody copyWith({
    String? grantType,
    String? code,
    String? redirectUri,
    String? clientId,
    String? clientSecret,
  }) {
    return TokenPost$RequestBody(
      grantType: grantType ?? this.grantType,
      code: code ?? this.code,
      redirectUri: redirectUri ?? this.redirectUri,
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
    );
  }

  TokenPost$RequestBody copyWithWrapped({
    Wrapped<String>? grantType,
    Wrapped<String>? code,
    Wrapped<String>? redirectUri,
    Wrapped<String>? clientId,
    Wrapped<String>? clientSecret,
  }) {
    return TokenPost$RequestBody(
      grantType: (grantType != null ? grantType.value : this.grantType),
      code: (code != null ? code.value : this.code),
      redirectUri: (redirectUri != null ? redirectUri.value : this.redirectUri),
      clientId: (clientId != null ? clientId.value : this.clientId),
      clientSecret: (clientSecret != null
          ? clientSecret.value
          : this.clientSecret),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ParPost$RequestBody {
  const ParPost$RequestBody({
    required this.clientId,
    required this.clientSecret,
    this.loginHint,
    required this.redirectUri,
    this.redirectMode,
    required this.responseType,
    this.state,
    this.correlationId,
    required this.request,
  });

  factory ParPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$ParPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$ParPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$ParPost$RequestBodyToJson(this);

  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'client_secret')
  final String clientSecret;
  @JsonKey(name: 'login_hint')
  final EnduringLoginHint? loginHint;
  @JsonKey(name: 'redirect_uri')
  final String redirectUri;
  @JsonKey(
    name: 'redirect_mode',
    toJson: oAuthRedirectModeNullableToJson,
    fromJson: oAuthRedirectModeNullableFromJson,
  )
  final enums.OAuthRedirectMode? redirectMode;
  @JsonKey(
    name: 'response_type',
    toJson: oAuthResponseTypeToJson,
    fromJson: oAuthResponseTypeFromJson,
  )
  final enums.OAuthResponseType responseType;
  @JsonKey(name: 'state')
  final String? state;
  @JsonKey(name: 'correlation_id')
  final String? correlationId;
  @JsonKey(name: 'request')
  final AccessRequest request;
  static const fromJsonFactory = _$ParPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ParPost$RequestBody &&
            (identical(other.clientId, clientId) ||
                const DeepCollectionEquality().equals(
                  other.clientId,
                  clientId,
                )) &&
            (identical(other.clientSecret, clientSecret) ||
                const DeepCollectionEquality().equals(
                  other.clientSecret,
                  clientSecret,
                )) &&
            (identical(other.loginHint, loginHint) ||
                const DeepCollectionEquality().equals(
                  other.loginHint,
                  loginHint,
                )) &&
            (identical(other.redirectUri, redirectUri) ||
                const DeepCollectionEquality().equals(
                  other.redirectUri,
                  redirectUri,
                )) &&
            (identical(other.redirectMode, redirectMode) ||
                const DeepCollectionEquality().equals(
                  other.redirectMode,
                  redirectMode,
                )) &&
            (identical(other.responseType, responseType) ||
                const DeepCollectionEquality().equals(
                  other.responseType,
                  responseType,
                )) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)) &&
            (identical(other.correlationId, correlationId) ||
                const DeepCollectionEquality().equals(
                  other.correlationId,
                  correlationId,
                )) &&
            (identical(other.request, request) ||
                const DeepCollectionEquality().equals(other.request, request)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(clientId) ^
      const DeepCollectionEquality().hash(clientSecret) ^
      const DeepCollectionEquality().hash(loginHint) ^
      const DeepCollectionEquality().hash(redirectUri) ^
      const DeepCollectionEquality().hash(redirectMode) ^
      const DeepCollectionEquality().hash(responseType) ^
      const DeepCollectionEquality().hash(state) ^
      const DeepCollectionEquality().hash(correlationId) ^
      const DeepCollectionEquality().hash(request) ^
      runtimeType.hashCode;
}

extension $ParPost$RequestBodyExtension on ParPost$RequestBody {
  ParPost$RequestBody copyWith({
    String? clientId,
    String? clientSecret,
    EnduringLoginHint? loginHint,
    String? redirectUri,
    enums.OAuthRedirectMode? redirectMode,
    enums.OAuthResponseType? responseType,
    String? state,
    String? correlationId,
    AccessRequest? request,
  }) {
    return ParPost$RequestBody(
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
      loginHint: loginHint ?? this.loginHint,
      redirectUri: redirectUri ?? this.redirectUri,
      redirectMode: redirectMode ?? this.redirectMode,
      responseType: responseType ?? this.responseType,
      state: state ?? this.state,
      correlationId: correlationId ?? this.correlationId,
      request: request ?? this.request,
    );
  }

  ParPost$RequestBody copyWithWrapped({
    Wrapped<String>? clientId,
    Wrapped<String>? clientSecret,
    Wrapped<EnduringLoginHint?>? loginHint,
    Wrapped<String>? redirectUri,
    Wrapped<enums.OAuthRedirectMode?>? redirectMode,
    Wrapped<enums.OAuthResponseType>? responseType,
    Wrapped<String?>? state,
    Wrapped<String?>? correlationId,
    Wrapped<AccessRequest>? request,
  }) {
    return ParPost$RequestBody(
      clientId: (clientId != null ? clientId.value : this.clientId),
      clientSecret: (clientSecret != null
          ? clientSecret.value
          : this.clientSecret),
      loginHint: (loginHint != null ? loginHint.value : this.loginHint),
      redirectUri: (redirectUri != null ? redirectUri.value : this.redirectUri),
      redirectMode: (redirectMode != null
          ? redirectMode.value
          : this.redirectMode),
      responseType: (responseType != null
          ? responseType.value
          : this.responseType),
      state: (state != null ? state.value : this.state),
      correlationId: (correlationId != null
          ? correlationId.value
          : this.correlationId),
      request: (request != null ? request.value : this.request),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentsPost$RequestBody {
  const PaymentsPost$RequestBody({
    required this.from,
    required this.to,
    required this.amount,
    this.meta,
  });

  factory PaymentsPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$PaymentsPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$PaymentsPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$PaymentsPost$RequestBodyToJson(this);

  @JsonKey(name: 'from')
  final String from;
  @JsonKey(name: 'to')
  final PaymentsPost$RequestBody$To to;
  @JsonKey(name: 'amount')
  final double amount;
  @JsonKey(name: 'meta')
  final PaymentsPost$RequestBody$Meta? meta;
  static const fromJsonFactory = _$PaymentsPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentsPost$RequestBody &&
            (identical(other.from, from) ||
                const DeepCollectionEquality().equals(other.from, from)) &&
            (identical(other.to, to) ||
                const DeepCollectionEquality().equals(other.to, to)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(from) ^
      const DeepCollectionEquality().hash(to) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(meta) ^
      runtimeType.hashCode;
}

extension $PaymentsPost$RequestBodyExtension on PaymentsPost$RequestBody {
  PaymentsPost$RequestBody copyWith({
    String? from,
    PaymentsPost$RequestBody$To? to,
    double? amount,
    PaymentsPost$RequestBody$Meta? meta,
  }) {
    return PaymentsPost$RequestBody(
      from: from ?? this.from,
      to: to ?? this.to,
      amount: amount ?? this.amount,
      meta: meta ?? this.meta,
    );
  }

  PaymentsPost$RequestBody copyWithWrapped({
    Wrapped<String>? from,
    Wrapped<PaymentsPost$RequestBody$To>? to,
    Wrapped<double>? amount,
    Wrapped<PaymentsPost$RequestBody$Meta?>? meta,
  }) {
    return PaymentsPost$RequestBody(
      from: (from != null ? from.value : this.from),
      to: (to != null ? to.value : this.to),
      amount: (amount != null ? amount.value : this.amount),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentsIrdPost$RequestBody {
  const PaymentsIrdPost$RequestBody({
    required this.from,
    required this.amount,
    required this.meta,
  });

  factory PaymentsIrdPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$PaymentsIrdPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$PaymentsIrdPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$PaymentsIrdPost$RequestBodyToJson(this);

  @JsonKey(name: 'from')
  final String from;
  @JsonKey(name: 'amount')
  final double amount;
  @JsonKey(name: 'meta')
  final PaymentsIrdPost$RequestBody$Meta meta;
  static const fromJsonFactory = _$PaymentsIrdPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentsIrdPost$RequestBody &&
            (identical(other.from, from) ||
                const DeepCollectionEquality().equals(other.from, from)) &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(from) ^
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(meta) ^
      runtimeType.hashCode;
}

extension $PaymentsIrdPost$RequestBodyExtension on PaymentsIrdPost$RequestBody {
  PaymentsIrdPost$RequestBody copyWith({
    String? from,
    double? amount,
    PaymentsIrdPost$RequestBody$Meta? meta,
  }) {
    return PaymentsIrdPost$RequestBody(
      from: from ?? this.from,
      amount: amount ?? this.amount,
      meta: meta ?? this.meta,
    );
  }

  PaymentsIrdPost$RequestBody copyWithWrapped({
    Wrapped<String>? from,
    Wrapped<double>? amount,
    Wrapped<PaymentsIrdPost$RequestBody$Meta>? meta,
  }) {
    return PaymentsIrdPost$RequestBody(
      from: (from != null ? from.value : this.from),
      amount: (amount != null ? amount.value : this.amount),
      meta: (meta != null ? meta.value : this.meta),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhooksPost$RequestBody {
  const WebhooksPost$RequestBody({this.webhookType, this.state});

  factory WebhooksPost$RequestBody.fromJson(Map<String, dynamic> json) =>
      _$WebhooksPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$WebhooksPost$RequestBodyToJson;
  Map<String, dynamic> toJson() => _$WebhooksPost$RequestBodyToJson(this);

  @JsonKey(name: 'webhook_type')
  final String? webhookType;
  @JsonKey(name: 'state')
  final String? state;
  static const fromJsonFactory = _$WebhooksPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WebhooksPost$RequestBody &&
            (identical(other.webhookType, webhookType) ||
                const DeepCollectionEquality().equals(
                  other.webhookType,
                  webhookType,
                )) &&
            (identical(other.state, state) ||
                const DeepCollectionEquality().equals(other.state, state)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(webhookType) ^
      const DeepCollectionEquality().hash(state) ^
      runtimeType.hashCode;
}

extension $WebhooksPost$RequestBodyExtension on WebhooksPost$RequestBody {
  WebhooksPost$RequestBody copyWith({String? webhookType, String? state}) {
    return WebhooksPost$RequestBody(
      webhookType: webhookType ?? this.webhookType,
      state: state ?? this.state,
    );
  }

  WebhooksPost$RequestBody copyWithWrapped({
    Wrapped<String?>? webhookType,
    Wrapped<String?>? state,
  }) {
    return WebhooksPost$RequestBody(
      webhookType: (webhookType != null ? webhookType.value : this.webhookType),
      state: (state != null ? state.value : this.state),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SupportTransactionIdPost$RequestBody {
  const SupportTransactionIdPost$RequestBody({
    required this.type,
    this.otherId,
    this.fields,
    this.comment,
  });

  factory SupportTransactionIdPost$RequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$SupportTransactionIdPost$RequestBodyFromJson(json);

  static const toJsonFactory = _$SupportTransactionIdPost$RequestBodyToJson;
  Map<String, dynamic> toJson() =>
      _$SupportTransactionIdPost$RequestBodyToJson(this);

  @JsonKey(
    name: 'type',
    toJson: supportTransactionIdPost$RequestBodyTypeToJson,
    fromJson: supportTransactionIdPost$RequestBodyTypeFromJson,
  )
  final enums.SupportTransactionIdPost$RequestBodyType type;
  @JsonKey(name: 'other_id')
  final String? otherId;
  @JsonKey(name: 'fields', defaultValue: <String>[])
  final List<String>? fields;
  @JsonKey(name: 'comment')
  final String? comment;
  static const fromJsonFactory = _$SupportTransactionIdPost$RequestBodyFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SupportTransactionIdPost$RequestBody &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.otherId, otherId) ||
                const DeepCollectionEquality().equals(
                  other.otherId,
                  otherId,
                )) &&
            (identical(other.fields, fields) ||
                const DeepCollectionEquality().equals(other.fields, fields)) &&
            (identical(other.comment, comment) ||
                const DeepCollectionEquality().equals(other.comment, comment)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(otherId) ^
      const DeepCollectionEquality().hash(fields) ^
      const DeepCollectionEquality().hash(comment) ^
      runtimeType.hashCode;
}

extension $SupportTransactionIdPost$RequestBodyExtension
    on SupportTransactionIdPost$RequestBody {
  SupportTransactionIdPost$RequestBody copyWith({
    enums.SupportTransactionIdPost$RequestBodyType? type,
    String? otherId,
    List<String>? fields,
    String? comment,
  }) {
    return SupportTransactionIdPost$RequestBody(
      type: type ?? this.type,
      otherId: otherId ?? this.otherId,
      fields: fields ?? this.fields,
      comment: comment ?? this.comment,
    );
  }

  SupportTransactionIdPost$RequestBody copyWithWrapped({
    Wrapped<enums.SupportTransactionIdPost$RequestBodyType>? type,
    Wrapped<String?>? otherId,
    Wrapped<List<String>?>? fields,
    Wrapped<String?>? comment,
  }) {
    return SupportTransactionIdPost$RequestBody(
      type: (type != null ? type.value : this.type),
      otherId: (otherId != null ? otherId.value : this.otherId),
      fields: (fields != null ? fields.value : this.fields),
      comment: (comment != null ? comment.value : this.comment),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AccountsGet$Response {
  const AccountsGet$Response({this.success, this.items});

  factory AccountsGet$Response.fromJson(Map<String, dynamic> json) =>
      _$AccountsGet$ResponseFromJson(json);

  static const toJsonFactory = _$AccountsGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$AccountsGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'items', defaultValue: <Account>[])
  final List<Account>? items;
  static const fromJsonFactory = _$AccountsGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AccountsGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $AccountsGet$ResponseExtension on AccountsGet$Response {
  AccountsGet$Response copyWith({bool? success, List<Account>? items}) {
    return AccountsGet$Response(
      success: success ?? this.success,
      items: items ?? this.items,
    );
  }

  AccountsGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<List<Account>?>? items,
  }) {
    return AccountsGet$Response(
      success: (success != null ? success.value : this.success),
      items: (items != null ? items.value : this.items),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AccountsIdGet$Response {
  const AccountsIdGet$Response({this.success, this.item});

  factory AccountsIdGet$Response.fromJson(Map<String, dynamic> json) =>
      _$AccountsIdGet$ResponseFromJson(json);

  static const toJsonFactory = _$AccountsIdGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$AccountsIdGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'item')
  final Account? item;
  static const fromJsonFactory = _$AccountsIdGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AccountsIdGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(item) ^
      runtimeType.hashCode;
}

extension $AccountsIdGet$ResponseExtension on AccountsIdGet$Response {
  AccountsIdGet$Response copyWith({bool? success, Account? item}) {
    return AccountsIdGet$Response(
      success: success ?? this.success,
      item: item ?? this.item,
    );
  }

  AccountsIdGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<Account?>? item,
  }) {
    return AccountsIdGet$Response(
      success: (success != null ? success.value : this.success),
      item: (item != null ? item.value : this.item),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AccountsIdVerificationTokenGet$Response {
  const AccountsIdVerificationTokenGet$Response({this.success, this.item});

  factory AccountsIdVerificationTokenGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$AccountsIdVerificationTokenGet$ResponseFromJson(json);

  static const toJsonFactory = _$AccountsIdVerificationTokenGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$AccountsIdVerificationTokenGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'item')
  final String? item;
  static const fromJsonFactory =
      _$AccountsIdVerificationTokenGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AccountsIdVerificationTokenGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(item) ^
      runtimeType.hashCode;
}

extension $AccountsIdVerificationTokenGet$ResponseExtension
    on AccountsIdVerificationTokenGet$Response {
  AccountsIdVerificationTokenGet$Response copyWith({
    bool? success,
    String? item,
  }) {
    return AccountsIdVerificationTokenGet$Response(
      success: success ?? this.success,
      item: item ?? this.item,
    );
  }

  AccountsIdVerificationTokenGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<String?>? item,
  }) {
    return AccountsIdVerificationTokenGet$Response(
      success: (success != null ? success.value : this.success),
      item: (item != null ? item.value : this.item),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AccountsIdVerificationTokenDelete$Response {
  const AccountsIdVerificationTokenDelete$Response({this.success});

  factory AccountsIdVerificationTokenDelete$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$AccountsIdVerificationTokenDelete$ResponseFromJson(json);

  static const toJsonFactory =
      _$AccountsIdVerificationTokenDelete$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$AccountsIdVerificationTokenDelete$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  static const fromJsonFactory =
      _$AccountsIdVerificationTokenDelete$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AccountsIdVerificationTokenDelete$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^ runtimeType.hashCode;
}

extension $AccountsIdVerificationTokenDelete$ResponseExtension
    on AccountsIdVerificationTokenDelete$Response {
  AccountsIdVerificationTokenDelete$Response copyWith({bool? success}) {
    return AccountsIdVerificationTokenDelete$Response(
      success: success ?? this.success,
    );
  }

  AccountsIdVerificationTokenDelete$Response copyWithWrapped({
    Wrapped<bool?>? success,
  }) {
    return AccountsIdVerificationTokenDelete$Response(
      success: (success != null ? success.value : this.success),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AccountsIdPaymentConsentsConsentIdDelete$Response {
  const AccountsIdPaymentConsentsConsentIdDelete$Response({this.success});

  factory AccountsIdPaymentConsentsConsentIdDelete$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$AccountsIdPaymentConsentsConsentIdDelete$ResponseFromJson(json);

  static const toJsonFactory =
      _$AccountsIdPaymentConsentsConsentIdDelete$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$AccountsIdPaymentConsentsConsentIdDelete$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  static const fromJsonFactory =
      _$AccountsIdPaymentConsentsConsentIdDelete$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AccountsIdPaymentConsentsConsentIdDelete$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^ runtimeType.hashCode;
}

extension $AccountsIdPaymentConsentsConsentIdDelete$ResponseExtension
    on AccountsIdPaymentConsentsConsentIdDelete$Response {
  AccountsIdPaymentConsentsConsentIdDelete$Response copyWith({bool? success}) {
    return AccountsIdPaymentConsentsConsentIdDelete$Response(
      success: success ?? this.success,
    );
  }

  AccountsIdPaymentConsentsConsentIdDelete$Response copyWithWrapped({
    Wrapped<bool?>? success,
  }) {
    return AccountsIdPaymentConsentsConsentIdDelete$Response(
      success: (success != null ? success.value : this.success),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AuthorisationsIdDelete$Response {
  const AuthorisationsIdDelete$Response({this.success});

  factory AuthorisationsIdDelete$Response.fromJson(Map<String, dynamic> json) =>
      _$AuthorisationsIdDelete$ResponseFromJson(json);

  static const toJsonFactory = _$AuthorisationsIdDelete$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$AuthorisationsIdDelete$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  static const fromJsonFactory = _$AuthorisationsIdDelete$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AuthorisationsIdDelete$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^ runtimeType.hashCode;
}

extension $AuthorisationsIdDelete$ResponseExtension
    on AuthorisationsIdDelete$Response {
  AuthorisationsIdDelete$Response copyWith({bool? success}) {
    return AuthorisationsIdDelete$Response(success: success ?? this.success);
  }

  AuthorisationsIdDelete$Response copyWithWrapped({Wrapped<bool?>? success}) {
    return AuthorisationsIdDelete$Response(
      success: (success != null ? success.value : this.success),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TokenDelete$Response {
  const TokenDelete$Response({this.success});

  factory TokenDelete$Response.fromJson(Map<String, dynamic> json) =>
      _$TokenDelete$ResponseFromJson(json);

  static const toJsonFactory = _$TokenDelete$ResponseToJson;
  Map<String, dynamic> toJson() => _$TokenDelete$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  static const fromJsonFactory = _$TokenDelete$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TokenDelete$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^ runtimeType.hashCode;
}

extension $TokenDelete$ResponseExtension on TokenDelete$Response {
  TokenDelete$Response copyWith({bool? success}) {
    return TokenDelete$Response(success: success ?? this.success);
  }

  TokenDelete$Response copyWithWrapped({Wrapped<bool?>? success}) {
    return TokenDelete$Response(
      success: (success != null ? success.value : this.success),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ConnectionsGet$Response {
  const ConnectionsGet$Response({this.success, this.items});

  factory ConnectionsGet$Response.fromJson(Map<String, dynamic> json) =>
      _$ConnectionsGet$ResponseFromJson(json);

  static const toJsonFactory = _$ConnectionsGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$ConnectionsGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'items', defaultValue: <Connection>[])
  final List<Connection>? items;
  static const fromJsonFactory = _$ConnectionsGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ConnectionsGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $ConnectionsGet$ResponseExtension on ConnectionsGet$Response {
  ConnectionsGet$Response copyWith({bool? success, List<Connection>? items}) {
    return ConnectionsGet$Response(
      success: success ?? this.success,
      items: items ?? this.items,
    );
  }

  ConnectionsGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<List<Connection>?>? items,
  }) {
    return ConnectionsGet$Response(
      success: (success != null ? success.value : this.success),
      items: (items != null ? items.value : this.items),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class ConnectionsIdGet$Response {
  const ConnectionsIdGet$Response({this.success, this.item});

  factory ConnectionsIdGet$Response.fromJson(Map<String, dynamic> json) =>
      _$ConnectionsIdGet$ResponseFromJson(json);

  static const toJsonFactory = _$ConnectionsIdGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$ConnectionsIdGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'item')
  final Connection? item;
  static const fromJsonFactory = _$ConnectionsIdGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is ConnectionsIdGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(item) ^
      runtimeType.hashCode;
}

extension $ConnectionsIdGet$ResponseExtension on ConnectionsIdGet$Response {
  ConnectionsIdGet$Response copyWith({bool? success, Connection? item}) {
    return ConnectionsIdGet$Response(
      success: success ?? this.success,
      item: item ?? this.item,
    );
  }

  ConnectionsIdGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<Connection?>? item,
  }) {
    return ConnectionsIdGet$Response(
      success: (success != null ? success.value : this.success),
      item: (item != null ? item.value : this.item),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CategoriesGet$Response {
  const CategoriesGet$Response({this.success, this.items});

  factory CategoriesGet$Response.fromJson(Map<String, dynamic> json) =>
      _$CategoriesGet$ResponseFromJson(json);

  static const toJsonFactory = _$CategoriesGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$CategoriesGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'items', defaultValue: <Category>[])
  final List<Category>? items;
  static const fromJsonFactory = _$CategoriesGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CategoriesGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $CategoriesGet$ResponseExtension on CategoriesGet$Response {
  CategoriesGet$Response copyWith({bool? success, List<Category>? items}) {
    return CategoriesGet$Response(
      success: success ?? this.success,
      items: items ?? this.items,
    );
  }

  CategoriesGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<List<Category>?>? items,
  }) {
    return CategoriesGet$Response(
      success: (success != null ? success.value : this.success),
      items: (items != null ? items.value : this.items),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CategoriesIdGet$Response {
  const CategoriesIdGet$Response({this.success, this.item});

  factory CategoriesIdGet$Response.fromJson(Map<String, dynamic> json) =>
      _$CategoriesIdGet$ResponseFromJson(json);

  static const toJsonFactory = _$CategoriesIdGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$CategoriesIdGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'item')
  final Category? item;
  static const fromJsonFactory = _$CategoriesIdGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CategoriesIdGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(item) ^
      runtimeType.hashCode;
}

extension $CategoriesIdGet$ResponseExtension on CategoriesIdGet$Response {
  CategoriesIdGet$Response copyWith({bool? success, Category? item}) {
    return CategoriesIdGet$Response(
      success: success ?? this.success,
      item: item ?? this.item,
    );
  }

  CategoriesIdGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<Category?>? item,
  }) {
    return CategoriesIdGet$Response(
      success: (success != null ? success.value : this.success),
      item: (item != null ? item.value : this.item),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RefreshPost$Response {
  const RefreshPost$Response({this.success});

  factory RefreshPost$Response.fromJson(Map<String, dynamic> json) =>
      _$RefreshPost$ResponseFromJson(json);

  static const toJsonFactory = _$RefreshPost$ResponseToJson;
  Map<String, dynamic> toJson() => _$RefreshPost$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  static const fromJsonFactory = _$RefreshPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RefreshPost$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^ runtimeType.hashCode;
}

extension $RefreshPost$ResponseExtension on RefreshPost$Response {
  RefreshPost$Response copyWith({bool? success}) {
    return RefreshPost$Response(success: success ?? this.success);
  }

  RefreshPost$Response copyWithWrapped({Wrapped<bool?>? success}) {
    return RefreshPost$Response(
      success: (success != null ? success.value : this.success),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class RefreshIdPost$Response {
  const RefreshIdPost$Response({this.success});

  factory RefreshIdPost$Response.fromJson(Map<String, dynamic> json) =>
      _$RefreshIdPost$ResponseFromJson(json);

  static const toJsonFactory = _$RefreshIdPost$ResponseToJson;
  Map<String, dynamic> toJson() => _$RefreshIdPost$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  static const fromJsonFactory = _$RefreshIdPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is RefreshIdPost$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^ runtimeType.hashCode;
}

extension $RefreshIdPost$ResponseExtension on RefreshIdPost$Response {
  RefreshIdPost$Response copyWith({bool? success}) {
    return RefreshIdPost$Response(success: success ?? this.success);
  }

  RefreshIdPost$Response copyWithWrapped({Wrapped<bool?>? success}) {
    return RefreshIdPost$Response(
      success: (success != null ? success.value : this.success),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class IdentityIdGet$Response {
  const IdentityIdGet$Response({this.success, this.item});

  factory IdentityIdGet$Response.fromJson(Map<String, dynamic> json) =>
      _$IdentityIdGet$ResponseFromJson(json);

  static const toJsonFactory = _$IdentityIdGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$IdentityIdGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'item')
  final OneOffIdentity? item;
  static const fromJsonFactory = _$IdentityIdGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is IdentityIdGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(item) ^
      runtimeType.hashCode;
}

extension $IdentityIdGet$ResponseExtension on IdentityIdGet$Response {
  IdentityIdGet$Response copyWith({bool? success, OneOffIdentity? item}) {
    return IdentityIdGet$Response(
      success: success ?? this.success,
      item: item ?? this.item,
    );
  }

  IdentityIdGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<OneOffIdentity?>? item,
  }) {
    return IdentityIdGet$Response(
      success: (success != null ? success.value : this.success),
      item: (item != null ? item.value : this.item),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PartiesGet$Response {
  const PartiesGet$Response({this.success, this.items});

  factory PartiesGet$Response.fromJson(Map<String, dynamic> json) =>
      _$PartiesGet$ResponseFromJson(json);

  static const toJsonFactory = _$PartiesGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$PartiesGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'items', defaultValue: <Party>[])
  final List<Party>? items;
  static const fromJsonFactory = _$PartiesGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PartiesGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $PartiesGet$ResponseExtension on PartiesGet$Response {
  PartiesGet$Response copyWith({bool? success, List<Party>? items}) {
    return PartiesGet$Response(
      success: success ?? this.success,
      items: items ?? this.items,
    );
  }

  PartiesGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<List<Party>?>? items,
  }) {
    return PartiesGet$Response(
      success: (success != null ? success.value : this.success),
      items: (items != null ? items.value : this.items),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentsGet$Response {
  const PaymentsGet$Response({this.success, this.items});

  factory PaymentsGet$Response.fromJson(Map<String, dynamic> json) =>
      _$PaymentsGet$ResponseFromJson(json);

  static const toJsonFactory = _$PaymentsGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$PaymentsGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'items', defaultValue: <Payment>[])
  final List<Payment>? items;
  static const fromJsonFactory = _$PaymentsGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentsGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $PaymentsGet$ResponseExtension on PaymentsGet$Response {
  PaymentsGet$Response copyWith({bool? success, List<Payment>? items}) {
    return PaymentsGet$Response(
      success: success ?? this.success,
      items: items ?? this.items,
    );
  }

  PaymentsGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<List<Payment>?>? items,
  }) {
    return PaymentsGet$Response(
      success: (success != null ? success.value : this.success),
      items: (items != null ? items.value : this.items),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentsPost$Response {
  const PaymentsPost$Response({
    this.success,
    this.item,
    this.itemId,
    this.status,
  });

  factory PaymentsPost$Response.fromJson(Map<String, dynamic> json) =>
      _$PaymentsPost$ResponseFromJson(json);

  static const toJsonFactory = _$PaymentsPost$ResponseToJson;
  Map<String, dynamic> toJson() => _$PaymentsPost$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'item')
  final Payment? item;
  @JsonKey(name: 'item_id')
  @deprecated
  final String? itemId;
  @JsonKey(name: 'status')
  @deprecated
  final String? status;
  static const fromJsonFactory = _$PaymentsPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentsPost$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)) &&
            (identical(other.itemId, itemId) ||
                const DeepCollectionEquality().equals(other.itemId, itemId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(item) ^
      const DeepCollectionEquality().hash(itemId) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $PaymentsPost$ResponseExtension on PaymentsPost$Response {
  PaymentsPost$Response copyWith({
    bool? success,
    Payment? item,
    String? itemId,
    String? status,
  }) {
    return PaymentsPost$Response(
      success: success ?? this.success,
      item: item ?? this.item,
      itemId: itemId ?? this.itemId,
      status: status ?? this.status,
    );
  }

  PaymentsPost$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<Payment?>? item,
    Wrapped<String?>? itemId,
    Wrapped<String?>? status,
  }) {
    return PaymentsPost$Response(
      success: (success != null ? success.value : this.success),
      item: (item != null ? item.value : this.item),
      itemId: (itemId != null ? itemId.value : this.itemId),
      status: (status != null ? status.value : this.status),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentsIrdPost$Response {
  const PaymentsIrdPost$Response({
    this.success,
    this.item,
    this.itemId,
    this.status,
  });

  factory PaymentsIrdPost$Response.fromJson(Map<String, dynamic> json) =>
      _$PaymentsIrdPost$ResponseFromJson(json);

  static const toJsonFactory = _$PaymentsIrdPost$ResponseToJson;
  Map<String, dynamic> toJson() => _$PaymentsIrdPost$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'item')
  final Payment? item;
  @JsonKey(name: 'item_id')
  @deprecated
  final String? itemId;
  @JsonKey(name: 'status')
  @deprecated
  final String? status;
  static const fromJsonFactory = _$PaymentsIrdPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentsIrdPost$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)) &&
            (identical(other.itemId, itemId) ||
                const DeepCollectionEquality().equals(other.itemId, itemId)) &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(item) ^
      const DeepCollectionEquality().hash(itemId) ^
      const DeepCollectionEquality().hash(status) ^
      runtimeType.hashCode;
}

extension $PaymentsIrdPost$ResponseExtension on PaymentsIrdPost$Response {
  PaymentsIrdPost$Response copyWith({
    bool? success,
    Payment? item,
    String? itemId,
    String? status,
  }) {
    return PaymentsIrdPost$Response(
      success: success ?? this.success,
      item: item ?? this.item,
      itemId: itemId ?? this.itemId,
      status: status ?? this.status,
    );
  }

  PaymentsIrdPost$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<Payment?>? item,
    Wrapped<String?>? itemId,
    Wrapped<String?>? status,
  }) {
    return PaymentsIrdPost$Response(
      success: (success != null ? success.value : this.success),
      item: (item != null ? item.value : this.item),
      itemId: (itemId != null ? itemId.value : this.itemId),
      status: (status != null ? status.value : this.status),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentsIdGet$Response {
  const PaymentsIdGet$Response({this.success, this.item});

  factory PaymentsIdGet$Response.fromJson(Map<String, dynamic> json) =>
      _$PaymentsIdGet$ResponseFromJson(json);

  static const toJsonFactory = _$PaymentsIdGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$PaymentsIdGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'item')
  final Payment? item;
  static const fromJsonFactory = _$PaymentsIdGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentsIdGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(item) ^
      runtimeType.hashCode;
}

extension $PaymentsIdGet$ResponseExtension on PaymentsIdGet$Response {
  PaymentsIdGet$Response copyWith({bool? success, Payment? item}) {
    return PaymentsIdGet$Response(
      success: success ?? this.success,
      item: item ?? this.item,
    );
  }

  PaymentsIdGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<Payment?>? item,
  }) {
    return PaymentsIdGet$Response(
      success: (success != null ? success.value : this.success),
      item: (item != null ? item.value : this.item),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentsIdCancelPut$Response {
  const PaymentsIdCancelPut$Response({this.success});

  factory PaymentsIdCancelPut$Response.fromJson(Map<String, dynamic> json) =>
      _$PaymentsIdCancelPut$ResponseFromJson(json);

  static const toJsonFactory = _$PaymentsIdCancelPut$ResponseToJson;
  Map<String, dynamic> toJson() => _$PaymentsIdCancelPut$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  static const fromJsonFactory = _$PaymentsIdCancelPut$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentsIdCancelPut$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^ runtimeType.hashCode;
}

extension $PaymentsIdCancelPut$ResponseExtension
    on PaymentsIdCancelPut$Response {
  PaymentsIdCancelPut$Response copyWith({bool? success}) {
    return PaymentsIdCancelPut$Response(success: success ?? this.success);
  }

  PaymentsIdCancelPut$Response copyWithWrapped({Wrapped<bool?>? success}) {
    return PaymentsIdCancelPut$Response(
      success: (success != null ? success.value : this.success),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionsGet$Response {
  const TransactionsGet$Response({this.success, this.items, this.cursor});

  factory TransactionsGet$Response.fromJson(Map<String, dynamic> json) =>
      _$TransactionsGet$ResponseFromJson(json);

  static const toJsonFactory = _$TransactionsGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$TransactionsGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'items', defaultValue: <Transaction>[])
  final List<Transaction>? items;
  @JsonKey(name: 'cursor')
  final TransactionsGet$Response$Cursor? cursor;
  static const fromJsonFactory = _$TransactionsGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TransactionsGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)) &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(items) ^
      const DeepCollectionEquality().hash(cursor) ^
      runtimeType.hashCode;
}

extension $TransactionsGet$ResponseExtension on TransactionsGet$Response {
  TransactionsGet$Response copyWith({
    bool? success,
    List<Transaction>? items,
    TransactionsGet$Response$Cursor? cursor,
  }) {
    return TransactionsGet$Response(
      success: success ?? this.success,
      items: items ?? this.items,
      cursor: cursor ?? this.cursor,
    );
  }

  TransactionsGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<List<Transaction>?>? items,
    Wrapped<TransactionsGet$Response$Cursor?>? cursor,
  }) {
    return TransactionsGet$Response(
      success: (success != null ? success.value : this.success),
      items: (items != null ? items.value : this.items),
      cursor: (cursor != null ? cursor.value : this.cursor),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionsPendingGet$Response {
  const TransactionsPendingGet$Response({this.success, this.items});

  factory TransactionsPendingGet$Response.fromJson(Map<String, dynamic> json) =>
      _$TransactionsPendingGet$ResponseFromJson(json);

  static const toJsonFactory = _$TransactionsPendingGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$TransactionsPendingGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'items', defaultValue: <PendingTransaction>[])
  final List<PendingTransaction>? items;
  static const fromJsonFactory = _$TransactionsPendingGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TransactionsPendingGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $TransactionsPendingGet$ResponseExtension
    on TransactionsPendingGet$Response {
  TransactionsPendingGet$Response copyWith({
    bool? success,
    List<PendingTransaction>? items,
  }) {
    return TransactionsPendingGet$Response(
      success: success ?? this.success,
      items: items ?? this.items,
    );
  }

  TransactionsPendingGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<List<PendingTransaction>?>? items,
  }) {
    return TransactionsPendingGet$Response(
      success: (success != null ? success.value : this.success),
      items: (items != null ? items.value : this.items),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionsIdGet$Response {
  const TransactionsIdGet$Response({this.success, this.item});

  factory TransactionsIdGet$Response.fromJson(Map<String, dynamic> json) =>
      _$TransactionsIdGet$ResponseFromJson(json);

  static const toJsonFactory = _$TransactionsIdGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$TransactionsIdGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'item')
  final Transaction? item;
  static const fromJsonFactory = _$TransactionsIdGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TransactionsIdGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(item) ^
      runtimeType.hashCode;
}

extension $TransactionsIdGet$ResponseExtension on TransactionsIdGet$Response {
  TransactionsIdGet$Response copyWith({bool? success, Transaction? item}) {
    return TransactionsIdGet$Response(
      success: success ?? this.success,
      item: item ?? this.item,
    );
  }

  TransactionsIdGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<Transaction?>? item,
  }) {
    return TransactionsIdGet$Response(
      success: (success != null ? success.value : this.success),
      item: (item != null ? item.value : this.item),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AccountsIdTransactionsGet$Response {
  const AccountsIdTransactionsGet$Response({
    this.success,
    this.items,
    this.cursor,
  });

  factory AccountsIdTransactionsGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$AccountsIdTransactionsGet$ResponseFromJson(json);

  static const toJsonFactory = _$AccountsIdTransactionsGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$AccountsIdTransactionsGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'items', defaultValue: <Transaction>[])
  final List<Transaction>? items;
  @JsonKey(name: 'cursor')
  final AccountsIdTransactionsGet$Response$Cursor? cursor;
  static const fromJsonFactory = _$AccountsIdTransactionsGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AccountsIdTransactionsGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)) &&
            (identical(other.cursor, cursor) ||
                const DeepCollectionEquality().equals(other.cursor, cursor)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(items) ^
      const DeepCollectionEquality().hash(cursor) ^
      runtimeType.hashCode;
}

extension $AccountsIdTransactionsGet$ResponseExtension
    on AccountsIdTransactionsGet$Response {
  AccountsIdTransactionsGet$Response copyWith({
    bool? success,
    List<Transaction>? items,
    AccountsIdTransactionsGet$Response$Cursor? cursor,
  }) {
    return AccountsIdTransactionsGet$Response(
      success: success ?? this.success,
      items: items ?? this.items,
      cursor: cursor ?? this.cursor,
    );
  }

  AccountsIdTransactionsGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<List<Transaction>?>? items,
    Wrapped<AccountsIdTransactionsGet$Response$Cursor?>? cursor,
  }) {
    return AccountsIdTransactionsGet$Response(
      success: (success != null ? success.value : this.success),
      items: (items != null ? items.value : this.items),
      cursor: (cursor != null ? cursor.value : this.cursor),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AccountsIdTransactionsPendingGet$Response {
  const AccountsIdTransactionsPendingGet$Response({this.success, this.items});

  factory AccountsIdTransactionsPendingGet$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$AccountsIdTransactionsPendingGet$ResponseFromJson(json);

  static const toJsonFactory =
      _$AccountsIdTransactionsPendingGet$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$AccountsIdTransactionsPendingGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'items', defaultValue: <PendingTransaction>[])
  final List<PendingTransaction>? items;
  static const fromJsonFactory =
      _$AccountsIdTransactionsPendingGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AccountsIdTransactionsPendingGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $AccountsIdTransactionsPendingGet$ResponseExtension
    on AccountsIdTransactionsPendingGet$Response {
  AccountsIdTransactionsPendingGet$Response copyWith({
    bool? success,
    List<PendingTransaction>? items,
  }) {
    return AccountsIdTransactionsPendingGet$Response(
      success: success ?? this.success,
      items: items ?? this.items,
    );
  }

  AccountsIdTransactionsPendingGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<List<PendingTransaction>?>? items,
  }) {
    return AccountsIdTransactionsPendingGet$Response(
      success: (success != null ? success.value : this.success),
      items: (items != null ? items.value : this.items),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionsIdsPost$Response {
  const TransactionsIdsPost$Response({this.success, this.items});

  factory TransactionsIdsPost$Response.fromJson(Map<String, dynamic> json) =>
      _$TransactionsIdsPost$ResponseFromJson(json);

  static const toJsonFactory = _$TransactionsIdsPost$ResponseToJson;
  Map<String, dynamic> toJson() => _$TransactionsIdsPost$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'items', defaultValue: <Transaction>[])
  final List<Transaction>? items;
  static const fromJsonFactory = _$TransactionsIdsPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TransactionsIdsPost$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $TransactionsIdsPost$ResponseExtension
    on TransactionsIdsPost$Response {
  TransactionsIdsPost$Response copyWith({
    bool? success,
    List<Transaction>? items,
  }) {
    return TransactionsIdsPost$Response(
      success: success ?? this.success,
      items: items ?? this.items,
    );
  }

  TransactionsIdsPost$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<List<Transaction>?>? items,
  }) {
    return TransactionsIdsPost$Response(
      success: (success != null ? success.value : this.success),
      items: (items != null ? items.value : this.items),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class MeGet$Response {
  const MeGet$Response({this.success, this.item});

  factory MeGet$Response.fromJson(Map<String, dynamic> json) =>
      _$MeGet$ResponseFromJson(json);

  static const toJsonFactory = _$MeGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$MeGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'item')
  final Me? item;
  static const fromJsonFactory = _$MeGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is MeGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(item) ^
      runtimeType.hashCode;
}

extension $MeGet$ResponseExtension on MeGet$Response {
  MeGet$Response copyWith({bool? success, Me? item}) {
    return MeGet$Response(
      success: success ?? this.success,
      item: item ?? this.item,
    );
  }

  MeGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<Me?>? item,
  }) {
    return MeGet$Response(
      success: (success != null ? success.value : this.success),
      item: (item != null ? item.value : this.item),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhooksGet$Response {
  const WebhooksGet$Response({this.success, this.items});

  factory WebhooksGet$Response.fromJson(Map<String, dynamic> json) =>
      _$WebhooksGet$ResponseFromJson(json);

  static const toJsonFactory = _$WebhooksGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$WebhooksGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'items', defaultValue: <Webhook>[])
  final List<Webhook>? items;
  static const fromJsonFactory = _$WebhooksGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WebhooksGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $WebhooksGet$ResponseExtension on WebhooksGet$Response {
  WebhooksGet$Response copyWith({bool? success, List<Webhook>? items}) {
    return WebhooksGet$Response(
      success: success ?? this.success,
      items: items ?? this.items,
    );
  }

  WebhooksGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<List<Webhook>?>? items,
  }) {
    return WebhooksGet$Response(
      success: (success != null ? success.value : this.success),
      items: (items != null ? items.value : this.items),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhooksPost$Response {
  const WebhooksPost$Response({this.success, this.itemId});

  factory WebhooksPost$Response.fromJson(Map<String, dynamic> json) =>
      _$WebhooksPost$ResponseFromJson(json);

  static const toJsonFactory = _$WebhooksPost$ResponseToJson;
  Map<String, dynamic> toJson() => _$WebhooksPost$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'item_id')
  final String? itemId;
  static const fromJsonFactory = _$WebhooksPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WebhooksPost$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.itemId, itemId) ||
                const DeepCollectionEquality().equals(other.itemId, itemId)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(itemId) ^
      runtimeType.hashCode;
}

extension $WebhooksPost$ResponseExtension on WebhooksPost$Response {
  WebhooksPost$Response copyWith({bool? success, String? itemId}) {
    return WebhooksPost$Response(
      success: success ?? this.success,
      itemId: itemId ?? this.itemId,
    );
  }

  WebhooksPost$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<String?>? itemId,
  }) {
    return WebhooksPost$Response(
      success: (success != null ? success.value : this.success),
      itemId: (itemId != null ? itemId.value : this.itemId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class KeysIdGet$Response {
  const KeysIdGet$Response({this.success, this.item});

  factory KeysIdGet$Response.fromJson(Map<String, dynamic> json) =>
      _$KeysIdGet$ResponseFromJson(json);

  static const toJsonFactory = _$KeysIdGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$KeysIdGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'item')
  final String? item;
  static const fromJsonFactory = _$KeysIdGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is KeysIdGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.item, item) ||
                const DeepCollectionEquality().equals(other.item, item)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(item) ^
      runtimeType.hashCode;
}

extension $KeysIdGet$ResponseExtension on KeysIdGet$Response {
  KeysIdGet$Response copyWith({bool? success, String? item}) {
    return KeysIdGet$Response(
      success: success ?? this.success,
      item: item ?? this.item,
    );
  }

  KeysIdGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<String?>? item,
  }) {
    return KeysIdGet$Response(
      success: (success != null ? success.value : this.success),
      item: (item != null ? item.value : this.item),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhooksIdDelete$Response {
  const WebhooksIdDelete$Response({this.success});

  factory WebhooksIdDelete$Response.fromJson(Map<String, dynamic> json) =>
      _$WebhooksIdDelete$ResponseFromJson(json);

  static const toJsonFactory = _$WebhooksIdDelete$ResponseToJson;
  Map<String, dynamic> toJson() => _$WebhooksIdDelete$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  static const fromJsonFactory = _$WebhooksIdDelete$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WebhooksIdDelete$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^ runtimeType.hashCode;
}

extension $WebhooksIdDelete$ResponseExtension on WebhooksIdDelete$Response {
  WebhooksIdDelete$Response copyWith({bool? success}) {
    return WebhooksIdDelete$Response(success: success ?? this.success);
  }

  WebhooksIdDelete$Response copyWithWrapped({Wrapped<bool?>? success}) {
    return WebhooksIdDelete$Response(
      success: (success != null ? success.value : this.success),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookEventsGet$Response {
  const WebhookEventsGet$Response({this.success, this.items});

  factory WebhookEventsGet$Response.fromJson(Map<String, dynamic> json) =>
      _$WebhookEventsGet$ResponseFromJson(json);

  static const toJsonFactory = _$WebhookEventsGet$ResponseToJson;
  Map<String, dynamic> toJson() => _$WebhookEventsGet$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(name: 'items', defaultValue: <WebhookEvent>[])
  final List<WebhookEvent>? items;
  static const fromJsonFactory = _$WebhookEventsGet$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WebhookEventsGet$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.items, items) ||
                const DeepCollectionEquality().equals(other.items, items)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(items) ^
      runtimeType.hashCode;
}

extension $WebhookEventsGet$ResponseExtension on WebhookEventsGet$Response {
  WebhookEventsGet$Response copyWith({
    bool? success,
    List<WebhookEvent>? items,
  }) {
    return WebhookEventsGet$Response(
      success: success ?? this.success,
      items: items ?? this.items,
    );
  }

  WebhookEventsGet$Response copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<List<WebhookEvent>?>? items,
  }) {
    return WebhookEventsGet$Response(
      success: (success != null ? success.value : this.success),
      items: (items != null ? items.value : this.items),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class SupportTransactionIdPost$Response {
  const SupportTransactionIdPost$Response({this.success});

  factory SupportTransactionIdPost$Response.fromJson(
    Map<String, dynamic> json,
  ) => _$SupportTransactionIdPost$ResponseFromJson(json);

  static const toJsonFactory = _$SupportTransactionIdPost$ResponseToJson;
  Map<String, dynamic> toJson() =>
      _$SupportTransactionIdPost$ResponseToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  static const fromJsonFactory = _$SupportTransactionIdPost$ResponseFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is SupportTransactionIdPost$Response &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(other.success, success)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^ runtimeType.hashCode;
}

extension $SupportTransactionIdPost$ResponseExtension
    on SupportTransactionIdPost$Response {
  SupportTransactionIdPost$Response copyWith({bool? success}) {
    return SupportTransactionIdPost$Response(success: success ?? this.success);
  }

  SupportTransactionIdPost$Response copyWithWrapped({Wrapped<bool?>? success}) {
    return SupportTransactionIdPost$Response(
      success: (success != null ? success.value : this.success),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Account$Balance {
  const Account$Balance({
    required this.currency,
    required this.current,
    this.available,
    this.limit,
    this.overdrawn,
  });

  factory Account$Balance.fromJson(Map<String, dynamic> json) =>
      _$Account$BalanceFromJson(json);

  static const toJsonFactory = _$Account$BalanceToJson;
  Map<String, dynamic> toJson() => _$Account$BalanceToJson(this);

  @JsonKey(name: 'currency')
  final String currency;
  @JsonKey(name: 'current')
  final double current;
  @JsonKey(name: 'available')
  final double? available;
  @JsonKey(name: 'limit')
  final double? limit;
  @JsonKey(name: 'overdrawn')
  final bool? overdrawn;
  static const fromJsonFactory = _$Account$BalanceFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Account$Balance &&
            (identical(other.currency, currency) ||
                const DeepCollectionEquality().equals(
                  other.currency,
                  currency,
                )) &&
            (identical(other.current, current) ||
                const DeepCollectionEquality().equals(
                  other.current,
                  current,
                )) &&
            (identical(other.available, available) ||
                const DeepCollectionEquality().equals(
                  other.available,
                  available,
                )) &&
            (identical(other.limit, limit) ||
                const DeepCollectionEquality().equals(other.limit, limit)) &&
            (identical(other.overdrawn, overdrawn) ||
                const DeepCollectionEquality().equals(
                  other.overdrawn,
                  overdrawn,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(currency) ^
      const DeepCollectionEquality().hash(current) ^
      const DeepCollectionEquality().hash(available) ^
      const DeepCollectionEquality().hash(limit) ^
      const DeepCollectionEquality().hash(overdrawn) ^
      runtimeType.hashCode;
}

extension $Account$BalanceExtension on Account$Balance {
  Account$Balance copyWith({
    String? currency,
    double? current,
    double? available,
    double? limit,
    bool? overdrawn,
  }) {
    return Account$Balance(
      currency: currency ?? this.currency,
      current: current ?? this.current,
      available: available ?? this.available,
      limit: limit ?? this.limit,
      overdrawn: overdrawn ?? this.overdrawn,
    );
  }

  Account$Balance copyWithWrapped({
    Wrapped<String>? currency,
    Wrapped<double>? current,
    Wrapped<double?>? available,
    Wrapped<double?>? limit,
    Wrapped<bool?>? overdrawn,
  }) {
    return Account$Balance(
      currency: (currency != null ? currency.value : this.currency),
      current: (current != null ? current.value : this.current),
      available: (available != null ? available.value : this.available),
      limit: (limit != null ? limit.value : this.limit),
      overdrawn: (overdrawn != null ? overdrawn.value : this.overdrawn),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Account$Meta {
  const Account$Meta({this.holder, this.hasUnlistedHolders, this.loanDetails});

  factory Account$Meta.fromJson(Map<String, dynamic> json) =>
      _$Account$MetaFromJson(json);

  static const toJsonFactory = _$Account$MetaToJson;
  Map<String, dynamic> toJson() => _$Account$MetaToJson(this);

  @JsonKey(name: 'holder')
  final String? holder;
  @JsonKey(name: 'has_unlisted_holders')
  final bool? hasUnlistedHolders;
  @JsonKey(name: 'loan_details')
  final Account$Meta$LoanDetails? loanDetails;
  static const fromJsonFactory = _$Account$MetaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Account$Meta &&
            (identical(other.holder, holder) ||
                const DeepCollectionEquality().equals(other.holder, holder)) &&
            (identical(other.hasUnlistedHolders, hasUnlistedHolders) ||
                const DeepCollectionEquality().equals(
                  other.hasUnlistedHolders,
                  hasUnlistedHolders,
                )) &&
            (identical(other.loanDetails, loanDetails) ||
                const DeepCollectionEquality().equals(
                  other.loanDetails,
                  loanDetails,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(holder) ^
      const DeepCollectionEquality().hash(hasUnlistedHolders) ^
      const DeepCollectionEquality().hash(loanDetails) ^
      runtimeType.hashCode;
}

extension $Account$MetaExtension on Account$Meta {
  Account$Meta copyWith({
    String? holder,
    bool? hasUnlistedHolders,
    Account$Meta$LoanDetails? loanDetails,
  }) {
    return Account$Meta(
      holder: holder ?? this.holder,
      hasUnlistedHolders: hasUnlistedHolders ?? this.hasUnlistedHolders,
      loanDetails: loanDetails ?? this.loanDetails,
    );
  }

  Account$Meta copyWithWrapped({
    Wrapped<String?>? holder,
    Wrapped<bool?>? hasUnlistedHolders,
    Wrapped<Account$Meta$LoanDetails?>? loanDetails,
  }) {
    return Account$Meta(
      holder: (holder != null ? holder.value : this.holder),
      hasUnlistedHolders: (hasUnlistedHolders != null
          ? hasUnlistedHolders.value
          : this.hasUnlistedHolders),
      loanDetails: (loanDetails != null ? loanDetails.value : this.loanDetails),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Account$Refreshed {
  const Account$Refreshed({
    this.balance,
    this.meta,
    this.transactions,
    this.party,
  });

  factory Account$Refreshed.fromJson(Map<String, dynamic> json) =>
      _$Account$RefreshedFromJson(json);

  static const toJsonFactory = _$Account$RefreshedToJson;
  Map<String, dynamic> toJson() => _$Account$RefreshedToJson(this);

  @JsonKey(name: 'balance')
  final DateTime? balance;
  @JsonKey(name: 'meta')
  final DateTime? meta;
  @JsonKey(name: 'transactions')
  final String? transactions;
  @JsonKey(name: 'party')
  final String? party;
  static const fromJsonFactory = _$Account$RefreshedFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Account$Refreshed &&
            (identical(other.balance, balance) ||
                const DeepCollectionEquality().equals(
                  other.balance,
                  balance,
                )) &&
            (identical(other.meta, meta) ||
                const DeepCollectionEquality().equals(other.meta, meta)) &&
            (identical(other.transactions, transactions) ||
                const DeepCollectionEquality().equals(
                  other.transactions,
                  transactions,
                )) &&
            (identical(other.party, party) ||
                const DeepCollectionEquality().equals(other.party, party)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(balance) ^
      const DeepCollectionEquality().hash(meta) ^
      const DeepCollectionEquality().hash(transactions) ^
      const DeepCollectionEquality().hash(party) ^
      runtimeType.hashCode;
}

extension $Account$RefreshedExtension on Account$Refreshed {
  Account$Refreshed copyWith({
    DateTime? balance,
    DateTime? meta,
    String? transactions,
    String? party,
  }) {
    return Account$Refreshed(
      balance: balance ?? this.balance,
      meta: meta ?? this.meta,
      transactions: transactions ?? this.transactions,
      party: party ?? this.party,
    );
  }

  Account$Refreshed copyWithWrapped({
    Wrapped<DateTime?>? balance,
    Wrapped<DateTime?>? meta,
    Wrapped<String?>? transactions,
    Wrapped<String?>? party,
  }) {
    return Account$Refreshed(
      balance: (balance != null ? balance.value : this.balance),
      meta: (meta != null ? meta.value : this.meta),
      transactions: (transactions != null
          ? transactions.value
          : this.transactions),
      party: (party != null ? party.value : this.party),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class VerifyNamePartySource$Meta {
  const VerifyNamePartySource$Meta({
    required this.value,
    required this.sources,
  });

  factory VerifyNamePartySource$Meta.fromJson(Map<String, dynamic> json) =>
      _$VerifyNamePartySource$MetaFromJson(json);

  static const toJsonFactory = _$VerifyNamePartySource$MetaToJson;
  Map<String, dynamic> toJson() => _$VerifyNamePartySource$MetaToJson(this);

  @JsonKey(name: 'value')
  final String value;
  @JsonKey(name: 'sources', defaultValue: <String>[])
  final List<String> sources;
  static const fromJsonFactory = _$VerifyNamePartySource$MetaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is VerifyNamePartySource$Meta &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.sources, sources) ||
                const DeepCollectionEquality().equals(other.sources, sources)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(sources) ^
      runtimeType.hashCode;
}

extension $VerifyNamePartySource$MetaExtension on VerifyNamePartySource$Meta {
  VerifyNamePartySource$Meta copyWith({String? value, List<String>? sources}) {
    return VerifyNamePartySource$Meta(
      value: value ?? this.value,
      sources: sources ?? this.sources,
    );
  }

  VerifyNamePartySource$Meta copyWithWrapped({
    Wrapped<String>? value,
    Wrapped<List<String>>? sources,
  }) {
    return VerifyNamePartySource$Meta(
      value: (value != null ? value.value : this.value),
      sources: (sources != null ? sources.value : this.sources),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class VerifyNameHolderSource$Meta {
  const VerifyNameHolderSource$Meta({
    required this.id,
    required this.name,
    this.formattedAccount,
    required this.holder,
    this.hasUnlistedHolders,
  });

  factory VerifyNameHolderSource$Meta.fromJson(Map<String, dynamic> json) =>
      _$VerifyNameHolderSource$MetaFromJson(json);

  static const toJsonFactory = _$VerifyNameHolderSource$MetaToJson;
  Map<String, dynamic> toJson() => _$VerifyNameHolderSource$MetaToJson(this);

  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'formatted_account')
  final String? formattedAccount;
  @JsonKey(name: 'holder')
  final String holder;
  @JsonKey(name: 'has_unlisted_holders')
  final bool? hasUnlistedHolders;
  static const fromJsonFactory = _$VerifyNameHolderSource$MetaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is VerifyNameHolderSource$Meta &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.formattedAccount, formattedAccount) ||
                const DeepCollectionEquality().equals(
                  other.formattedAccount,
                  formattedAccount,
                )) &&
            (identical(other.holder, holder) ||
                const DeepCollectionEquality().equals(other.holder, holder)) &&
            (identical(other.hasUnlistedHolders, hasUnlistedHolders) ||
                const DeepCollectionEquality().equals(
                  other.hasUnlistedHolders,
                  hasUnlistedHolders,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(formattedAccount) ^
      const DeepCollectionEquality().hash(holder) ^
      const DeepCollectionEquality().hash(hasUnlistedHolders) ^
      runtimeType.hashCode;
}

extension $VerifyNameHolderSource$MetaExtension on VerifyNameHolderSource$Meta {
  VerifyNameHolderSource$Meta copyWith({
    String? id,
    String? name,
    String? formattedAccount,
    String? holder,
    bool? hasUnlistedHolders,
  }) {
    return VerifyNameHolderSource$Meta(
      id: id ?? this.id,
      name: name ?? this.name,
      formattedAccount: formattedAccount ?? this.formattedAccount,
      holder: holder ?? this.holder,
      hasUnlistedHolders: hasUnlistedHolders ?? this.hasUnlistedHolders,
    );
  }

  VerifyNameHolderSource$Meta copyWithWrapped({
    Wrapped<String>? id,
    Wrapped<String>? name,
    Wrapped<String?>? formattedAccount,
    Wrapped<String>? holder,
    Wrapped<bool?>? hasUnlistedHolders,
  }) {
    return VerifyNameHolderSource$Meta(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      formattedAccount: (formattedAccount != null
          ? formattedAccount.value
          : this.formattedAccount),
      holder: (holder != null ? holder.value : this.holder),
      hasUnlistedHolders: (hasUnlistedHolders != null
          ? hasUnlistedHolders.value
          : this.hasUnlistedHolders),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Transaction$Merchant {
  const Transaction$Merchant({this.id, this.name, this.website});

  factory Transaction$Merchant.fromJson(Map<String, dynamic> json) =>
      _$Transaction$MerchantFromJson(json);

  static const toJsonFactory = _$Transaction$MerchantToJson;
  Map<String, dynamic> toJson() => _$Transaction$MerchantToJson(this);

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'website')
  final String? website;
  static const fromJsonFactory = _$Transaction$MerchantFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Transaction$Merchant &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.website, website) ||
                const DeepCollectionEquality().equals(other.website, website)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(website) ^
      runtimeType.hashCode;
}

extension $Transaction$MerchantExtension on Transaction$Merchant {
  Transaction$Merchant copyWith({String? id, String? name, String? website}) {
    return Transaction$Merchant(
      id: id ?? this.id,
      name: name ?? this.name,
      website: website ?? this.website,
    );
  }

  Transaction$Merchant copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<String?>? name,
    Wrapped<String?>? website,
  }) {
    return Transaction$Merchant(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      website: (website != null ? website.value : this.website),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Transaction$Category {
  const Transaction$Category({this.id, this.name, this.groups});

  factory Transaction$Category.fromJson(Map<String, dynamic> json) =>
      _$Transaction$CategoryFromJson(json);

  static const toJsonFactory = _$Transaction$CategoryToJson;
  Map<String, dynamic> toJson() => _$Transaction$CategoryToJson(this);

  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'groups')
  final CategoryGroups? groups;
  static const fromJsonFactory = _$Transaction$CategoryFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Transaction$Category &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.groups, groups) ||
                const DeepCollectionEquality().equals(other.groups, groups)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(groups) ^
      runtimeType.hashCode;
}

extension $Transaction$CategoryExtension on Transaction$Category {
  Transaction$Category copyWith({
    String? id,
    String? name,
    CategoryGroups? groups,
  }) {
    return Transaction$Category(
      id: id ?? this.id,
      name: name ?? this.name,
      groups: groups ?? this.groups,
    );
  }

  Transaction$Category copyWithWrapped({
    Wrapped<String?>? id,
    Wrapped<String?>? name,
    Wrapped<CategoryGroups?>? groups,
  }) {
    return Transaction$Category(
      id: (id != null ? id.value : this.id),
      name: (name != null ? name.value : this.name),
      groups: (groups != null ? groups.value : this.groups),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Transaction$Meta {
  const Transaction$Meta({
    this.particulars,
    this.code,
    this.reference,
    this.otherAccount,
    this.conversion,
    this.cardSuffix,
    this.logo,
  });

  factory Transaction$Meta.fromJson(Map<String, dynamic> json) =>
      _$Transaction$MetaFromJson(json);

  static const toJsonFactory = _$Transaction$MetaToJson;
  Map<String, dynamic> toJson() => _$Transaction$MetaToJson(this);

  @JsonKey(name: 'particulars')
  final String? particulars;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'reference')
  final String? reference;
  @JsonKey(name: 'other_account')
  final String? otherAccount;
  @JsonKey(name: 'conversion')
  final Transaction$Meta$Conversion? conversion;
  @JsonKey(name: 'card_suffix')
  final String? cardSuffix;
  @JsonKey(name: 'logo')
  final String? logo;
  static const fromJsonFactory = _$Transaction$MetaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Transaction$Meta &&
            (identical(other.particulars, particulars) ||
                const DeepCollectionEquality().equals(
                  other.particulars,
                  particulars,
                )) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.reference, reference) ||
                const DeepCollectionEquality().equals(
                  other.reference,
                  reference,
                )) &&
            (identical(other.otherAccount, otherAccount) ||
                const DeepCollectionEquality().equals(
                  other.otherAccount,
                  otherAccount,
                )) &&
            (identical(other.conversion, conversion) ||
                const DeepCollectionEquality().equals(
                  other.conversion,
                  conversion,
                )) &&
            (identical(other.cardSuffix, cardSuffix) ||
                const DeepCollectionEquality().equals(
                  other.cardSuffix,
                  cardSuffix,
                )) &&
            (identical(other.logo, logo) ||
                const DeepCollectionEquality().equals(other.logo, logo)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(particulars) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(reference) ^
      const DeepCollectionEquality().hash(otherAccount) ^
      const DeepCollectionEquality().hash(conversion) ^
      const DeepCollectionEquality().hash(cardSuffix) ^
      const DeepCollectionEquality().hash(logo) ^
      runtimeType.hashCode;
}

extension $Transaction$MetaExtension on Transaction$Meta {
  Transaction$Meta copyWith({
    String? particulars,
    String? code,
    String? reference,
    String? otherAccount,
    Transaction$Meta$Conversion? conversion,
    String? cardSuffix,
    String? logo,
  }) {
    return Transaction$Meta(
      particulars: particulars ?? this.particulars,
      code: code ?? this.code,
      reference: reference ?? this.reference,
      otherAccount: otherAccount ?? this.otherAccount,
      conversion: conversion ?? this.conversion,
      cardSuffix: cardSuffix ?? this.cardSuffix,
      logo: logo ?? this.logo,
    );
  }

  Transaction$Meta copyWithWrapped({
    Wrapped<String?>? particulars,
    Wrapped<String?>? code,
    Wrapped<String?>? reference,
    Wrapped<String?>? otherAccount,
    Wrapped<Transaction$Meta$Conversion?>? conversion,
    Wrapped<String?>? cardSuffix,
    Wrapped<String?>? logo,
  }) {
    return Transaction$Meta(
      particulars: (particulars != null ? particulars.value : this.particulars),
      code: (code != null ? code.value : this.code),
      reference: (reference != null ? reference.value : this.reference),
      otherAccount: (otherAccount != null
          ? otherAccount.value
          : this.otherAccount),
      conversion: (conversion != null ? conversion.value : this.conversion),
      cardSuffix: (cardSuffix != null ? cardSuffix.value : this.cardSuffix),
      logo: (logo != null ? logo.value : this.logo),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PendingTransaction$Meta {
  const PendingTransaction$Meta({
    this.particulars,
    this.code,
    this.reference,
    this.otherAccount,
    this.conversion,
    this.cardSuffix,
  });

  factory PendingTransaction$Meta.fromJson(Map<String, dynamic> json) =>
      _$PendingTransaction$MetaFromJson(json);

  static const toJsonFactory = _$PendingTransaction$MetaToJson;
  Map<String, dynamic> toJson() => _$PendingTransaction$MetaToJson(this);

  @JsonKey(name: 'particulars')
  final String? particulars;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'reference')
  final String? reference;
  @JsonKey(name: 'other_account')
  final String? otherAccount;
  @JsonKey(name: 'conversion')
  final PendingTransaction$Meta$Conversion? conversion;
  @JsonKey(name: 'card_suffix')
  final String? cardSuffix;
  static const fromJsonFactory = _$PendingTransaction$MetaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PendingTransaction$Meta &&
            (identical(other.particulars, particulars) ||
                const DeepCollectionEquality().equals(
                  other.particulars,
                  particulars,
                )) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.reference, reference) ||
                const DeepCollectionEquality().equals(
                  other.reference,
                  reference,
                )) &&
            (identical(other.otherAccount, otherAccount) ||
                const DeepCollectionEquality().equals(
                  other.otherAccount,
                  otherAccount,
                )) &&
            (identical(other.conversion, conversion) ||
                const DeepCollectionEquality().equals(
                  other.conversion,
                  conversion,
                )) &&
            (identical(other.cardSuffix, cardSuffix) ||
                const DeepCollectionEquality().equals(
                  other.cardSuffix,
                  cardSuffix,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(particulars) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(reference) ^
      const DeepCollectionEquality().hash(otherAccount) ^
      const DeepCollectionEquality().hash(conversion) ^
      const DeepCollectionEquality().hash(cardSuffix) ^
      runtimeType.hashCode;
}

extension $PendingTransaction$MetaExtension on PendingTransaction$Meta {
  PendingTransaction$Meta copyWith({
    String? particulars,
    String? code,
    String? reference,
    String? otherAccount,
    PendingTransaction$Meta$Conversion? conversion,
    String? cardSuffix,
  }) {
    return PendingTransaction$Meta(
      particulars: particulars ?? this.particulars,
      code: code ?? this.code,
      reference: reference ?? this.reference,
      otherAccount: otherAccount ?? this.otherAccount,
      conversion: conversion ?? this.conversion,
      cardSuffix: cardSuffix ?? this.cardSuffix,
    );
  }

  PendingTransaction$Meta copyWithWrapped({
    Wrapped<String?>? particulars,
    Wrapped<String?>? code,
    Wrapped<String?>? reference,
    Wrapped<String?>? otherAccount,
    Wrapped<PendingTransaction$Meta$Conversion?>? conversion,
    Wrapped<String?>? cardSuffix,
  }) {
    return PendingTransaction$Meta(
      particulars: (particulars != null ? particulars.value : this.particulars),
      code: (code != null ? code.value : this.code),
      reference: (reference != null ? reference.value : this.reference),
      otherAccount: (otherAccount != null
          ? otherAccount.value
          : this.otherAccount),
      conversion: (conversion != null ? conversion.value : this.conversion),
      cardSuffix: (cardSuffix != null ? cardSuffix.value : this.cardSuffix),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Payment$To {
  const Payment$To({this.accountNumber, this.name});

  factory Payment$To.fromJson(Map<String, dynamic> json) =>
      _$Payment$ToFromJson(json);

  static const toJsonFactory = _$Payment$ToToJson;
  Map<String, dynamic> toJson() => _$Payment$ToToJson(this);

  @JsonKey(name: 'account_number')
  final String? accountNumber;
  @JsonKey(name: 'name')
  final String? name;
  static const fromJsonFactory = _$Payment$ToFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Payment$To &&
            (identical(other.accountNumber, accountNumber) ||
                const DeepCollectionEquality().equals(
                  other.accountNumber,
                  accountNumber,
                )) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(accountNumber) ^
      const DeepCollectionEquality().hash(name) ^
      runtimeType.hashCode;
}

extension $Payment$ToExtension on Payment$To {
  Payment$To copyWith({String? accountNumber, String? name}) {
    return Payment$To(
      accountNumber: accountNumber ?? this.accountNumber,
      name: name ?? this.name,
    );
  }

  Payment$To copyWithWrapped({
    Wrapped<String?>? accountNumber,
    Wrapped<String?>? name,
  }) {
    return Payment$To(
      accountNumber: (accountNumber != null
          ? accountNumber.value
          : this.accountNumber),
      name: (name != null ? name.value : this.name),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Payment$Meta {
  const Payment$Meta({this.destination, this.source});

  factory Payment$Meta.fromJson(Map<String, dynamic> json) =>
      _$Payment$MetaFromJson(json);

  static const toJsonFactory = _$Payment$MetaToJson;
  Map<String, dynamic> toJson() => _$Payment$MetaToJson(this);

  @JsonKey(name: 'destination')
  final Payment$Meta$Destination? destination;
  @JsonKey(name: 'source')
  final Payment$Meta$Source? source;
  static const fromJsonFactory = _$Payment$MetaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Payment$Meta &&
            (identical(other.destination, destination) ||
                const DeepCollectionEquality().equals(
                  other.destination,
                  destination,
                )) &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(destination) ^
      const DeepCollectionEquality().hash(source) ^
      runtimeType.hashCode;
}

extension $Payment$MetaExtension on Payment$Meta {
  Payment$Meta copyWith({
    Payment$Meta$Destination? destination,
    Payment$Meta$Source? source,
  }) {
    return Payment$Meta(
      destination: destination ?? this.destination,
      source: source ?? this.source,
    );
  }

  Payment$Meta copyWithWrapped({
    Wrapped<Payment$Meta$Destination?>? destination,
    Wrapped<Payment$Meta$Source?>? source,
  }) {
    return Payment$Meta(
      destination: (destination != null ? destination.value : this.destination),
      source: (source != null ? source.value : this.source),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Payment$Timeline$Item {
  const Payment$Timeline$Item({this.status, this.time, this.eta});

  factory Payment$Timeline$Item.fromJson(Map<String, dynamic> json) =>
      _$Payment$Timeline$ItemFromJson(json);

  static const toJsonFactory = _$Payment$Timeline$ItemToJson;
  Map<String, dynamic> toJson() => _$Payment$Timeline$ItemToJson(this);

  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'time')
  final DateTime? time;
  @JsonKey(name: 'eta')
  final DateTime? eta;
  static const fromJsonFactory = _$Payment$Timeline$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Payment$Timeline$Item &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)) &&
            (identical(other.eta, eta) ||
                const DeepCollectionEquality().equals(other.eta, eta)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(time) ^
      const DeepCollectionEquality().hash(eta) ^
      runtimeType.hashCode;
}

extension $Payment$Timeline$ItemExtension on Payment$Timeline$Item {
  Payment$Timeline$Item copyWith({
    String? status,
    DateTime? time,
    DateTime? eta,
  }) {
    return Payment$Timeline$Item(
      status: status ?? this.status,
      time: time ?? this.time,
      eta: eta ?? this.eta,
    );
  }

  Payment$Timeline$Item copyWithWrapped({
    Wrapped<String?>? status,
    Wrapped<DateTime?>? time,
    Wrapped<DateTime?>? eta,
  }) {
    return Payment$Timeline$Item(
      status: (status != null ? status.value : this.status),
      time: (time != null ? time.value : this.time),
      eta: (eta != null ? eta.value : this.eta),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Party$Name {
  const Party$Name({this.value});

  factory Party$Name.fromJson(Map<String, dynamic> json) =>
      _$Party$NameFromJson(json);

  static const toJsonFactory = _$Party$NameToJson;
  Map<String, dynamic> toJson() => _$Party$NameToJson(this);

  @JsonKey(name: 'value')
  final String? value;
  static const fromJsonFactory = _$Party$NameFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Party$Name &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(value) ^ runtimeType.hashCode;
}

extension $Party$NameExtension on Party$Name {
  Party$Name copyWith({String? value}) {
    return Party$Name(value: value ?? this.value);
  }

  Party$Name copyWithWrapped({Wrapped<String?>? value}) {
    return Party$Name(value: (value != null ? value.value : this.value));
  }
}

@JsonSerializable(explicitToJson: true)
class Party$Dob {
  const Party$Dob({this.value});

  factory Party$Dob.fromJson(Map<String, dynamic> json) =>
      _$Party$DobFromJson(json);

  static const toJsonFactory = _$Party$DobToJson;
  Map<String, dynamic> toJson() => _$Party$DobToJson(this);

  @JsonKey(name: 'value', toJson: _dateToJson)
  final DateTime? value;
  static const fromJsonFactory = _$Party$DobFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Party$Dob &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(value) ^ runtimeType.hashCode;
}

extension $Party$DobExtension on Party$Dob {
  Party$Dob copyWith({DateTime? value}) {
    return Party$Dob(value: value ?? this.value);
  }

  Party$Dob copyWithWrapped({Wrapped<DateTime?>? value}) {
    return Party$Dob(value: (value != null ? value.value : this.value));
  }
}

@JsonSerializable(explicitToJson: true)
class Party$TaxNumber {
  const Party$TaxNumber({this.value});

  factory Party$TaxNumber.fromJson(Map<String, dynamic> json) =>
      _$Party$TaxNumberFromJson(json);

  static const toJsonFactory = _$Party$TaxNumberToJson;
  Map<String, dynamic> toJson() => _$Party$TaxNumberToJson(this);

  @JsonKey(name: 'value')
  final String? value;
  static const fromJsonFactory = _$Party$TaxNumberFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Party$TaxNumber &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(value) ^ runtimeType.hashCode;
}

extension $Party$TaxNumberExtension on Party$TaxNumber {
  Party$TaxNumber copyWith({String? value}) {
    return Party$TaxNumber(value: value ?? this.value);
  }

  Party$TaxNumber copyWithWrapped({Wrapped<String?>? value}) {
    return Party$TaxNumber(value: (value != null ? value.value : this.value));
  }
}

@JsonSerializable(explicitToJson: true)
class Party$PhoneNumbers$Item {
  const Party$PhoneNumbers$Item({this.value, this.subtype, this.verified});

  factory Party$PhoneNumbers$Item.fromJson(Map<String, dynamic> json) =>
      _$Party$PhoneNumbers$ItemFromJson(json);

  static const toJsonFactory = _$Party$PhoneNumbers$ItemToJson;
  Map<String, dynamic> toJson() => _$Party$PhoneNumbers$ItemToJson(this);

  @JsonKey(name: 'value')
  final String? value;
  @JsonKey(
    name: 'subtype',
    toJson: party$PhoneNumbers$ItemSubtypeNullableToJson,
    fromJson: party$PhoneNumbers$ItemSubtypeNullableFromJson,
  )
  final enums.Party$PhoneNumbers$ItemSubtype? subtype;
  @JsonKey(name: 'verified')
  final bool? verified;
  static const fromJsonFactory = _$Party$PhoneNumbers$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Party$PhoneNumbers$Item &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.subtype, subtype) ||
                const DeepCollectionEquality().equals(
                  other.subtype,
                  subtype,
                )) &&
            (identical(other.verified, verified) ||
                const DeepCollectionEquality().equals(
                  other.verified,
                  verified,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(subtype) ^
      const DeepCollectionEquality().hash(verified) ^
      runtimeType.hashCode;
}

extension $Party$PhoneNumbers$ItemExtension on Party$PhoneNumbers$Item {
  Party$PhoneNumbers$Item copyWith({
    String? value,
    enums.Party$PhoneNumbers$ItemSubtype? subtype,
    bool? verified,
  }) {
    return Party$PhoneNumbers$Item(
      value: value ?? this.value,
      subtype: subtype ?? this.subtype,
      verified: verified ?? this.verified,
    );
  }

  Party$PhoneNumbers$Item copyWithWrapped({
    Wrapped<String?>? value,
    Wrapped<enums.Party$PhoneNumbers$ItemSubtype?>? subtype,
    Wrapped<bool?>? verified,
  }) {
    return Party$PhoneNumbers$Item(
      value: (value != null ? value.value : this.value),
      subtype: (subtype != null ? subtype.value : this.subtype),
      verified: (verified != null ? verified.value : this.verified),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Party$EmailAddresses$Item {
  const Party$EmailAddresses$Item({this.value, this.subtype, this.verified});

  factory Party$EmailAddresses$Item.fromJson(Map<String, dynamic> json) =>
      _$Party$EmailAddresses$ItemFromJson(json);

  static const toJsonFactory = _$Party$EmailAddresses$ItemToJson;
  Map<String, dynamic> toJson() => _$Party$EmailAddresses$ItemToJson(this);

  @JsonKey(name: 'value')
  final String? value;
  @JsonKey(
    name: 'subtype',
    toJson: party$EmailAddresses$ItemSubtypeNullableToJson,
    fromJson: party$EmailAddresses$ItemSubtypeNullableFromJson,
  )
  final enums.Party$EmailAddresses$ItemSubtype? subtype;
  @JsonKey(name: 'verified')
  final bool? verified;
  static const fromJsonFactory = _$Party$EmailAddresses$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Party$EmailAddresses$Item &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.subtype, subtype) ||
                const DeepCollectionEquality().equals(
                  other.subtype,
                  subtype,
                )) &&
            (identical(other.verified, verified) ||
                const DeepCollectionEquality().equals(
                  other.verified,
                  verified,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(subtype) ^
      const DeepCollectionEquality().hash(verified) ^
      runtimeType.hashCode;
}

extension $Party$EmailAddresses$ItemExtension on Party$EmailAddresses$Item {
  Party$EmailAddresses$Item copyWith({
    String? value,
    enums.Party$EmailAddresses$ItemSubtype? subtype,
    bool? verified,
  }) {
    return Party$EmailAddresses$Item(
      value: value ?? this.value,
      subtype: subtype ?? this.subtype,
      verified: verified ?? this.verified,
    );
  }

  Party$EmailAddresses$Item copyWithWrapped({
    Wrapped<String?>? value,
    Wrapped<enums.Party$EmailAddresses$ItemSubtype?>? subtype,
    Wrapped<bool?>? verified,
  }) {
    return Party$EmailAddresses$Item(
      value: (value != null ? value.value : this.value),
      subtype: (subtype != null ? subtype.value : this.subtype),
      verified: (verified != null ? verified.value : this.verified),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Party$Addresses$Item {
  const Party$Addresses$Item({
    this.value,
    this.subtype,
    this.formatted,
    this.components,
    this.googleMapsPlaceId,
  });

  factory Party$Addresses$Item.fromJson(Map<String, dynamic> json) =>
      _$Party$Addresses$ItemFromJson(json);

  static const toJsonFactory = _$Party$Addresses$ItemToJson;
  Map<String, dynamic> toJson() => _$Party$Addresses$ItemToJson(this);

  @JsonKey(name: 'value')
  final String? value;
  @JsonKey(
    name: 'subtype',
    toJson: addressTypeNullableToJson,
    fromJson: addressTypeNullableFromJson,
  )
  final enums.AddressType? subtype;
  @JsonKey(name: 'formatted')
  final String? formatted;
  @JsonKey(name: 'components')
  final AddressComponents? components;
  @JsonKey(name: 'google_maps_place_id')
  final String? googleMapsPlaceId;
  static const fromJsonFactory = _$Party$Addresses$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Party$Addresses$Item &&
            (identical(other.value, value) ||
                const DeepCollectionEquality().equals(other.value, value)) &&
            (identical(other.subtype, subtype) ||
                const DeepCollectionEquality().equals(
                  other.subtype,
                  subtype,
                )) &&
            (identical(other.formatted, formatted) ||
                const DeepCollectionEquality().equals(
                  other.formatted,
                  formatted,
                )) &&
            (identical(other.components, components) ||
                const DeepCollectionEquality().equals(
                  other.components,
                  components,
                )) &&
            (identical(other.googleMapsPlaceId, googleMapsPlaceId) ||
                const DeepCollectionEquality().equals(
                  other.googleMapsPlaceId,
                  googleMapsPlaceId,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(value) ^
      const DeepCollectionEquality().hash(subtype) ^
      const DeepCollectionEquality().hash(formatted) ^
      const DeepCollectionEquality().hash(components) ^
      const DeepCollectionEquality().hash(googleMapsPlaceId) ^
      runtimeType.hashCode;
}

extension $Party$Addresses$ItemExtension on Party$Addresses$Item {
  Party$Addresses$Item copyWith({
    String? value,
    enums.AddressType? subtype,
    String? formatted,
    AddressComponents? components,
    String? googleMapsPlaceId,
  }) {
    return Party$Addresses$Item(
      value: value ?? this.value,
      subtype: subtype ?? this.subtype,
      formatted: formatted ?? this.formatted,
      components: components ?? this.components,
      googleMapsPlaceId: googleMapsPlaceId ?? this.googleMapsPlaceId,
    );
  }

  Party$Addresses$Item copyWithWrapped({
    Wrapped<String?>? value,
    Wrapped<enums.AddressType?>? subtype,
    Wrapped<String?>? formatted,
    Wrapped<AddressComponents?>? components,
    Wrapped<String?>? googleMapsPlaceId,
  }) {
    return Party$Addresses$Item(
      value: (value != null ? value.value : this.value),
      subtype: (subtype != null ? subtype.value : this.subtype),
      formatted: (formatted != null ? formatted.value : this.formatted),
      components: (components != null ? components.value : this.components),
      googleMapsPlaceId: (googleMapsPlaceId != null
          ? googleMapsPlaceId.value
          : this.googleMapsPlaceId),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class WebhookEvent$Payload {
  const WebhookEvent$Payload({
    this.success,
    this.webhookType,
    this.webhookCode,
  });

  factory WebhookEvent$Payload.fromJson(Map<String, dynamic> json) =>
      _$WebhookEvent$PayloadFromJson(json);

  static const toJsonFactory = _$WebhookEvent$PayloadToJson;
  Map<String, dynamic> toJson() => _$WebhookEvent$PayloadToJson(this);

  @JsonKey(name: 'success')
  final bool? success;
  @JsonKey(
    name: 'webhook_type',
    toJson: webhookEvent$PayloadWebhookTypeNullableToJson,
    fromJson: webhookEvent$PayloadWebhookTypeNullableFromJson,
  )
  final enums.WebhookEvent$PayloadWebhookType? webhookType;
  @JsonKey(name: 'webhook_code')
  final String? webhookCode;
  static const fromJsonFactory = _$WebhookEvent$PayloadFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is WebhookEvent$Payload &&
            (identical(other.success, success) ||
                const DeepCollectionEquality().equals(
                  other.success,
                  success,
                )) &&
            (identical(other.webhookType, webhookType) ||
                const DeepCollectionEquality().equals(
                  other.webhookType,
                  webhookType,
                )) &&
            (identical(other.webhookCode, webhookCode) ||
                const DeepCollectionEquality().equals(
                  other.webhookCode,
                  webhookCode,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(webhookType) ^
      const DeepCollectionEquality().hash(webhookCode) ^
      runtimeType.hashCode;
}

extension $WebhookEvent$PayloadExtension on WebhookEvent$Payload {
  WebhookEvent$Payload copyWith({
    bool? success,
    enums.WebhookEvent$PayloadWebhookType? webhookType,
    String? webhookCode,
  }) {
    return WebhookEvent$Payload(
      success: success ?? this.success,
      webhookType: webhookType ?? this.webhookType,
      webhookCode: webhookCode ?? this.webhookCode,
    );
  }

  WebhookEvent$Payload copyWithWrapped({
    Wrapped<bool?>? success,
    Wrapped<enums.WebhookEvent$PayloadWebhookType?>? webhookType,
    Wrapped<String?>? webhookCode,
  }) {
    return WebhookEvent$Payload(
      success: (success != null ? success.value : this.success),
      webhookType: (webhookType != null ? webhookType.value : this.webhookType),
      webhookCode: (webhookCode != null ? webhookCode.value : this.webhookCode),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class CreateAuthorisationRequestInvalidRequestResponse$Issues$Item {
  const CreateAuthorisationRequestInvalidRequestResponse$Issues$Item({
    required this.code,
    required this.message,
    required this.path,
  });

  factory CreateAuthorisationRequestInvalidRequestResponse$Issues$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$CreateAuthorisationRequestInvalidRequestResponse$Issues$ItemFromJson(
    json,
  );

  static const toJsonFactory =
      _$CreateAuthorisationRequestInvalidRequestResponse$Issues$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$CreateAuthorisationRequestInvalidRequestResponse$Issues$ItemToJson(
        this,
      );

  @JsonKey(
    name: 'code',
    toJson: createAuthorisationRequestIssueCodeToJson,
    fromJson: createAuthorisationRequestIssueCodeFromJson,
  )
  final enums.CreateAuthorisationRequestIssueCode code;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'path')
  final IssuePath path;
  static const fromJsonFactory =
      _$CreateAuthorisationRequestInvalidRequestResponse$Issues$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is CreateAuthorisationRequestInvalidRequestResponse$Issues$Item &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(
                  other.message,
                  message,
                )) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(path) ^
      runtimeType.hashCode;
}

extension $CreateAuthorisationRequestInvalidRequestResponse$Issues$ItemExtension
    on CreateAuthorisationRequestInvalidRequestResponse$Issues$Item {
  CreateAuthorisationRequestInvalidRequestResponse$Issues$Item copyWith({
    enums.CreateAuthorisationRequestIssueCode? code,
    String? message,
    IssuePath? path,
  }) {
    return CreateAuthorisationRequestInvalidRequestResponse$Issues$Item(
      code: code ?? this.code,
      message: message ?? this.message,
      path: path ?? this.path,
    );
  }

  CreateAuthorisationRequestInvalidRequestResponse$Issues$Item copyWithWrapped({
    Wrapped<enums.CreateAuthorisationRequestIssueCode>? code,
    Wrapped<String>? message,
    Wrapped<IssuePath>? path,
  }) {
    return CreateAuthorisationRequestInvalidRequestResponse$Issues$Item(
      code: (code != null ? code.value : this.code),
      message: (message != null ? message.value : this.message),
      path: (path != null ? path.value : this.path),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OAuthUnauthorizedResponse$Issues$Item {
  const OAuthUnauthorizedResponse$Issues$Item({
    required this.code,
    required this.message,
    required this.path,
  });

  factory OAuthUnauthorizedResponse$Issues$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$OAuthUnauthorizedResponse$Issues$ItemFromJson(json);

  static const toJsonFactory = _$OAuthUnauthorizedResponse$Issues$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$OAuthUnauthorizedResponse$Issues$ItemToJson(this);

  @JsonKey(
    name: 'code',
    toJson: oAuth401ErrorCodeToJson,
    fromJson: oAuth401ErrorCodeFromJson,
  )
  final enums.OAuth401ErrorCode code;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'path')
  final IssuePath path;
  static const fromJsonFactory =
      _$OAuthUnauthorizedResponse$Issues$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OAuthUnauthorizedResponse$Issues$Item &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(
                  other.message,
                  message,
                )) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(path) ^
      runtimeType.hashCode;
}

extension $OAuthUnauthorizedResponse$Issues$ItemExtension
    on OAuthUnauthorizedResponse$Issues$Item {
  OAuthUnauthorizedResponse$Issues$Item copyWith({
    enums.OAuth401ErrorCode? code,
    String? message,
    IssuePath? path,
  }) {
    return OAuthUnauthorizedResponse$Issues$Item(
      code: code ?? this.code,
      message: message ?? this.message,
      path: path ?? this.path,
    );
  }

  OAuthUnauthorizedResponse$Issues$Item copyWithWrapped({
    Wrapped<enums.OAuth401ErrorCode>? code,
    Wrapped<String>? message,
    Wrapped<IssuePath>? path,
  }) {
    return OAuthUnauthorizedResponse$Issues$Item(
      code: (code != null ? code.value : this.code),
      message: (message != null ? message.value : this.message),
      path: (path != null ? path.value : this.path),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class OAuthInternalServerErrorResponse$Issues$Item {
  const OAuthInternalServerErrorResponse$Issues$Item({
    required this.code,
    required this.message,
    required this.path,
  });

  factory OAuthInternalServerErrorResponse$Issues$Item.fromJson(
    Map<String, dynamic> json,
  ) => _$OAuthInternalServerErrorResponse$Issues$ItemFromJson(json);

  static const toJsonFactory =
      _$OAuthInternalServerErrorResponse$Issues$ItemToJson;
  Map<String, dynamic> toJson() =>
      _$OAuthInternalServerErrorResponse$Issues$ItemToJson(this);

  @JsonKey(
    name: 'code',
    toJson: oAuth500ErrorCodeToJson,
    fromJson: oAuth500ErrorCodeFromJson,
  )
  final enums.OAuth500ErrorCode code;
  @JsonKey(name: 'message')
  final String message;
  @JsonKey(name: 'path')
  final IssuePath path;
  static const fromJsonFactory =
      _$OAuthInternalServerErrorResponse$Issues$ItemFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is OAuthInternalServerErrorResponse$Issues$Item &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(
                  other.message,
                  message,
                )) &&
            (identical(other.path, path) ||
                const DeepCollectionEquality().equals(other.path, path)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(message) ^
      const DeepCollectionEquality().hash(path) ^
      runtimeType.hashCode;
}

extension $OAuthInternalServerErrorResponse$Issues$ItemExtension
    on OAuthInternalServerErrorResponse$Issues$Item {
  OAuthInternalServerErrorResponse$Issues$Item copyWith({
    enums.OAuth500ErrorCode? code,
    String? message,
    IssuePath? path,
  }) {
    return OAuthInternalServerErrorResponse$Issues$Item(
      code: code ?? this.code,
      message: message ?? this.message,
      path: path ?? this.path,
    );
  }

  OAuthInternalServerErrorResponse$Issues$Item copyWithWrapped({
    Wrapped<enums.OAuth500ErrorCode>? code,
    Wrapped<String>? message,
    Wrapped<IssuePath>? path,
  }) {
    return OAuthInternalServerErrorResponse$Issues$Item(
      code: (code != null ? code.value : this.code),
      message: (message != null ? message.value : this.message),
      path: (path != null ? path.value : this.path),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentsPost$RequestBody$To {
  const PaymentsPost$RequestBody$To({this.name, this.accountNumber});

  factory PaymentsPost$RequestBody$To.fromJson(Map<String, dynamic> json) =>
      _$PaymentsPost$RequestBody$ToFromJson(json);

  static const toJsonFactory = _$PaymentsPost$RequestBody$ToToJson;
  Map<String, dynamic> toJson() => _$PaymentsPost$RequestBody$ToToJson(this);

  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'account_number')
  final String? accountNumber;
  static const fromJsonFactory = _$PaymentsPost$RequestBody$ToFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentsPost$RequestBody$To &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.accountNumber, accountNumber) ||
                const DeepCollectionEquality().equals(
                  other.accountNumber,
                  accountNumber,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(accountNumber) ^
      runtimeType.hashCode;
}

extension $PaymentsPost$RequestBody$ToExtension on PaymentsPost$RequestBody$To {
  PaymentsPost$RequestBody$To copyWith({String? name, String? accountNumber}) {
    return PaymentsPost$RequestBody$To(
      name: name ?? this.name,
      accountNumber: accountNumber ?? this.accountNumber,
    );
  }

  PaymentsPost$RequestBody$To copyWithWrapped({
    Wrapped<String?>? name,
    Wrapped<String?>? accountNumber,
  }) {
    return PaymentsPost$RequestBody$To(
      name: (name != null ? name.value : this.name),
      accountNumber: (accountNumber != null
          ? accountNumber.value
          : this.accountNumber),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentsPost$RequestBody$Meta {
  const PaymentsPost$RequestBody$Meta({this.source, this.destination});

  factory PaymentsPost$RequestBody$Meta.fromJson(Map<String, dynamic> json) =>
      _$PaymentsPost$RequestBody$MetaFromJson(json);

  static const toJsonFactory = _$PaymentsPost$RequestBody$MetaToJson;
  Map<String, dynamic> toJson() => _$PaymentsPost$RequestBody$MetaToJson(this);

  @JsonKey(name: 'source')
  final PaymentsPost$RequestBody$Meta$Source? source;
  @JsonKey(name: 'destination')
  final PaymentsPost$RequestBody$Meta$Destination? destination;
  static const fromJsonFactory = _$PaymentsPost$RequestBody$MetaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentsPost$RequestBody$Meta &&
            (identical(other.source, source) ||
                const DeepCollectionEquality().equals(other.source, source)) &&
            (identical(other.destination, destination) ||
                const DeepCollectionEquality().equals(
                  other.destination,
                  destination,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(source) ^
      const DeepCollectionEquality().hash(destination) ^
      runtimeType.hashCode;
}

extension $PaymentsPost$RequestBody$MetaExtension
    on PaymentsPost$RequestBody$Meta {
  PaymentsPost$RequestBody$Meta copyWith({
    PaymentsPost$RequestBody$Meta$Source? source,
    PaymentsPost$RequestBody$Meta$Destination? destination,
  }) {
    return PaymentsPost$RequestBody$Meta(
      source: source ?? this.source,
      destination: destination ?? this.destination,
    );
  }

  PaymentsPost$RequestBody$Meta copyWithWrapped({
    Wrapped<PaymentsPost$RequestBody$Meta$Source?>? source,
    Wrapped<PaymentsPost$RequestBody$Meta$Destination?>? destination,
  }) {
    return PaymentsPost$RequestBody$Meta(
      source: (source != null ? source.value : this.source),
      destination: (destination != null ? destination.value : this.destination),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentsIrdPost$RequestBody$Meta {
  const PaymentsIrdPost$RequestBody$Meta({
    required this.taxNumber,
    required this.taxType,
    this.taxPeriod,
  });

  factory PaymentsIrdPost$RequestBody$Meta.fromJson(
    Map<String, dynamic> json,
  ) => _$PaymentsIrdPost$RequestBody$MetaFromJson(json);

  static const toJsonFactory = _$PaymentsIrdPost$RequestBody$MetaToJson;
  Map<String, dynamic> toJson() =>
      _$PaymentsIrdPost$RequestBody$MetaToJson(this);

  @JsonKey(name: 'tax_number')
  final String taxNumber;
  @JsonKey(name: 'tax_type')
  final String taxType;
  @JsonKey(name: 'tax_period')
  final String? taxPeriod;
  static const fromJsonFactory = _$PaymentsIrdPost$RequestBody$MetaFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentsIrdPost$RequestBody$Meta &&
            (identical(other.taxNumber, taxNumber) ||
                const DeepCollectionEquality().equals(
                  other.taxNumber,
                  taxNumber,
                )) &&
            (identical(other.taxType, taxType) ||
                const DeepCollectionEquality().equals(
                  other.taxType,
                  taxType,
                )) &&
            (identical(other.taxPeriod, taxPeriod) ||
                const DeepCollectionEquality().equals(
                  other.taxPeriod,
                  taxPeriod,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(taxNumber) ^
      const DeepCollectionEquality().hash(taxType) ^
      const DeepCollectionEquality().hash(taxPeriod) ^
      runtimeType.hashCode;
}

extension $PaymentsIrdPost$RequestBody$MetaExtension
    on PaymentsIrdPost$RequestBody$Meta {
  PaymentsIrdPost$RequestBody$Meta copyWith({
    String? taxNumber,
    String? taxType,
    String? taxPeriod,
  }) {
    return PaymentsIrdPost$RequestBody$Meta(
      taxNumber: taxNumber ?? this.taxNumber,
      taxType: taxType ?? this.taxType,
      taxPeriod: taxPeriod ?? this.taxPeriod,
    );
  }

  PaymentsIrdPost$RequestBody$Meta copyWithWrapped({
    Wrapped<String>? taxNumber,
    Wrapped<String>? taxType,
    Wrapped<String?>? taxPeriod,
  }) {
    return PaymentsIrdPost$RequestBody$Meta(
      taxNumber: (taxNumber != null ? taxNumber.value : this.taxNumber),
      taxType: (taxType != null ? taxType.value : this.taxType),
      taxPeriod: (taxPeriod != null ? taxPeriod.value : this.taxPeriod),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class TransactionsGet$Response$Cursor {
  const TransactionsGet$Response$Cursor({this.next});

  factory TransactionsGet$Response$Cursor.fromJson(Map<String, dynamic> json) =>
      _$TransactionsGet$Response$CursorFromJson(json);

  static const toJsonFactory = _$TransactionsGet$Response$CursorToJson;
  Map<String, dynamic> toJson() =>
      _$TransactionsGet$Response$CursorToJson(this);

  @JsonKey(name: 'next')
  final String? next;
  static const fromJsonFactory = _$TransactionsGet$Response$CursorFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is TransactionsGet$Response$Cursor &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(next) ^ runtimeType.hashCode;
}

extension $TransactionsGet$Response$CursorExtension
    on TransactionsGet$Response$Cursor {
  TransactionsGet$Response$Cursor copyWith({String? next}) {
    return TransactionsGet$Response$Cursor(next: next ?? this.next);
  }

  TransactionsGet$Response$Cursor copyWithWrapped({Wrapped<String?>? next}) {
    return TransactionsGet$Response$Cursor(
      next: (next != null ? next.value : this.next),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class AccountsIdTransactionsGet$Response$Cursor {
  const AccountsIdTransactionsGet$Response$Cursor({this.next});

  factory AccountsIdTransactionsGet$Response$Cursor.fromJson(
    Map<String, dynamic> json,
  ) => _$AccountsIdTransactionsGet$Response$CursorFromJson(json);

  static const toJsonFactory =
      _$AccountsIdTransactionsGet$Response$CursorToJson;
  Map<String, dynamic> toJson() =>
      _$AccountsIdTransactionsGet$Response$CursorToJson(this);

  @JsonKey(name: 'next')
  final String? next;
  static const fromJsonFactory =
      _$AccountsIdTransactionsGet$Response$CursorFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is AccountsIdTransactionsGet$Response$Cursor &&
            (identical(other.next, next) ||
                const DeepCollectionEquality().equals(other.next, next)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(next) ^ runtimeType.hashCode;
}

extension $AccountsIdTransactionsGet$Response$CursorExtension
    on AccountsIdTransactionsGet$Response$Cursor {
  AccountsIdTransactionsGet$Response$Cursor copyWith({String? next}) {
    return AccountsIdTransactionsGet$Response$Cursor(next: next ?? this.next);
  }

  AccountsIdTransactionsGet$Response$Cursor copyWithWrapped({
    Wrapped<String?>? next,
  }) {
    return AccountsIdTransactionsGet$Response$Cursor(
      next: (next != null ? next.value : this.next),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Account$Meta$LoanDetails {
  const Account$Meta$LoanDetails({
    required this.purpose,
    required this.type,
    required this.interest,
    required this.isInterestOnly,
    this.interestOnlyExpiresAt,
    this.term,
    this.maturesAt,
    this.initialPrincipal,
    this.repayment,
  });

  factory Account$Meta$LoanDetails.fromJson(Map<String, dynamic> json) =>
      _$Account$Meta$LoanDetailsFromJson(json);

  static const toJsonFactory = _$Account$Meta$LoanDetailsToJson;
  Map<String, dynamic> toJson() => _$Account$Meta$LoanDetailsToJson(this);

  @JsonKey(
    name: 'purpose',
    toJson: account$Meta$LoanDetailsPurposeToJson,
    fromJson: account$Meta$LoanDetailsPurposeFromJson,
  )
  final enums.Account$Meta$LoanDetailsPurpose purpose;
  @JsonKey(
    name: 'type',
    toJson: account$Meta$LoanDetailsTypeToJson,
    fromJson: account$Meta$LoanDetailsTypeFromJson,
  )
  final enums.Account$Meta$LoanDetailsType type;
  @JsonKey(name: 'interest')
  final Account$Meta$LoanDetails$Interest interest;
  @JsonKey(name: 'is_interest_only')
  final bool isInterestOnly;
  @JsonKey(name: 'interest_only_expires_at')
  final DateTime? interestOnlyExpiresAt;
  @JsonKey(name: 'term')
  final Account$Meta$LoanDetails$Term? term;
  @JsonKey(name: 'matures_at')
  final DateTime? maturesAt;
  @JsonKey(name: 'initial_principal')
  final double? initialPrincipal;
  @JsonKey(name: 'repayment')
  final Account$Meta$LoanDetails$Repayment? repayment;
  static const fromJsonFactory = _$Account$Meta$LoanDetailsFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Account$Meta$LoanDetails &&
            (identical(other.purpose, purpose) ||
                const DeepCollectionEquality().equals(
                  other.purpose,
                  purpose,
                )) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.interest, interest) ||
                const DeepCollectionEquality().equals(
                  other.interest,
                  interest,
                )) &&
            (identical(other.isInterestOnly, isInterestOnly) ||
                const DeepCollectionEquality().equals(
                  other.isInterestOnly,
                  isInterestOnly,
                )) &&
            (identical(other.interestOnlyExpiresAt, interestOnlyExpiresAt) ||
                const DeepCollectionEquality().equals(
                  other.interestOnlyExpiresAt,
                  interestOnlyExpiresAt,
                )) &&
            (identical(other.term, term) ||
                const DeepCollectionEquality().equals(other.term, term)) &&
            (identical(other.maturesAt, maturesAt) ||
                const DeepCollectionEquality().equals(
                  other.maturesAt,
                  maturesAt,
                )) &&
            (identical(other.initialPrincipal, initialPrincipal) ||
                const DeepCollectionEquality().equals(
                  other.initialPrincipal,
                  initialPrincipal,
                )) &&
            (identical(other.repayment, repayment) ||
                const DeepCollectionEquality().equals(
                  other.repayment,
                  repayment,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(purpose) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(interest) ^
      const DeepCollectionEquality().hash(isInterestOnly) ^
      const DeepCollectionEquality().hash(interestOnlyExpiresAt) ^
      const DeepCollectionEquality().hash(term) ^
      const DeepCollectionEquality().hash(maturesAt) ^
      const DeepCollectionEquality().hash(initialPrincipal) ^
      const DeepCollectionEquality().hash(repayment) ^
      runtimeType.hashCode;
}

extension $Account$Meta$LoanDetailsExtension on Account$Meta$LoanDetails {
  Account$Meta$LoanDetails copyWith({
    enums.Account$Meta$LoanDetailsPurpose? purpose,
    enums.Account$Meta$LoanDetailsType? type,
    Account$Meta$LoanDetails$Interest? interest,
    bool? isInterestOnly,
    DateTime? interestOnlyExpiresAt,
    Account$Meta$LoanDetails$Term? term,
    DateTime? maturesAt,
    double? initialPrincipal,
    Account$Meta$LoanDetails$Repayment? repayment,
  }) {
    return Account$Meta$LoanDetails(
      purpose: purpose ?? this.purpose,
      type: type ?? this.type,
      interest: interest ?? this.interest,
      isInterestOnly: isInterestOnly ?? this.isInterestOnly,
      interestOnlyExpiresAt:
          interestOnlyExpiresAt ?? this.interestOnlyExpiresAt,
      term: term ?? this.term,
      maturesAt: maturesAt ?? this.maturesAt,
      initialPrincipal: initialPrincipal ?? this.initialPrincipal,
      repayment: repayment ?? this.repayment,
    );
  }

  Account$Meta$LoanDetails copyWithWrapped({
    Wrapped<enums.Account$Meta$LoanDetailsPurpose>? purpose,
    Wrapped<enums.Account$Meta$LoanDetailsType>? type,
    Wrapped<Account$Meta$LoanDetails$Interest>? interest,
    Wrapped<bool>? isInterestOnly,
    Wrapped<DateTime?>? interestOnlyExpiresAt,
    Wrapped<Account$Meta$LoanDetails$Term?>? term,
    Wrapped<DateTime?>? maturesAt,
    Wrapped<double?>? initialPrincipal,
    Wrapped<Account$Meta$LoanDetails$Repayment?>? repayment,
  }) {
    return Account$Meta$LoanDetails(
      purpose: (purpose != null ? purpose.value : this.purpose),
      type: (type != null ? type.value : this.type),
      interest: (interest != null ? interest.value : this.interest),
      isInterestOnly: (isInterestOnly != null
          ? isInterestOnly.value
          : this.isInterestOnly),
      interestOnlyExpiresAt: (interestOnlyExpiresAt != null
          ? interestOnlyExpiresAt.value
          : this.interestOnlyExpiresAt),
      term: (term != null ? term.value : this.term),
      maturesAt: (maturesAt != null ? maturesAt.value : this.maturesAt),
      initialPrincipal: (initialPrincipal != null
          ? initialPrincipal.value
          : this.initialPrincipal),
      repayment: (repayment != null ? repayment.value : this.repayment),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Transaction$Meta$Conversion {
  const Transaction$Meta$Conversion({this.amount, this.currency, this.rate});

  factory Transaction$Meta$Conversion.fromJson(Map<String, dynamic> json) =>
      _$Transaction$Meta$ConversionFromJson(json);

  static const toJsonFactory = _$Transaction$Meta$ConversionToJson;
  Map<String, dynamic> toJson() => _$Transaction$Meta$ConversionToJson(this);

  @JsonKey(name: 'amount')
  final double? amount;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'rate')
  final double? rate;
  static const fromJsonFactory = _$Transaction$Meta$ConversionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Transaction$Meta$Conversion &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.currency, currency) ||
                const DeepCollectionEquality().equals(
                  other.currency,
                  currency,
                )) &&
            (identical(other.rate, rate) ||
                const DeepCollectionEquality().equals(other.rate, rate)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(currency) ^
      const DeepCollectionEquality().hash(rate) ^
      runtimeType.hashCode;
}

extension $Transaction$Meta$ConversionExtension on Transaction$Meta$Conversion {
  Transaction$Meta$Conversion copyWith({
    double? amount,
    String? currency,
    double? rate,
  }) {
    return Transaction$Meta$Conversion(
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      rate: rate ?? this.rate,
    );
  }

  Transaction$Meta$Conversion copyWithWrapped({
    Wrapped<double?>? amount,
    Wrapped<String?>? currency,
    Wrapped<double?>? rate,
  }) {
    return Transaction$Meta$Conversion(
      amount: (amount != null ? amount.value : this.amount),
      currency: (currency != null ? currency.value : this.currency),
      rate: (rate != null ? rate.value : this.rate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PendingTransaction$Meta$Conversion {
  const PendingTransaction$Meta$Conversion({
    this.amount,
    this.currency,
    this.rate,
  });

  factory PendingTransaction$Meta$Conversion.fromJson(
    Map<String, dynamic> json,
  ) => _$PendingTransaction$Meta$ConversionFromJson(json);

  static const toJsonFactory = _$PendingTransaction$Meta$ConversionToJson;
  Map<String, dynamic> toJson() =>
      _$PendingTransaction$Meta$ConversionToJson(this);

  @JsonKey(name: 'amount')
  final double? amount;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'rate')
  final double? rate;
  static const fromJsonFactory = _$PendingTransaction$Meta$ConversionFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PendingTransaction$Meta$Conversion &&
            (identical(other.amount, amount) ||
                const DeepCollectionEquality().equals(other.amount, amount)) &&
            (identical(other.currency, currency) ||
                const DeepCollectionEquality().equals(
                  other.currency,
                  currency,
                )) &&
            (identical(other.rate, rate) ||
                const DeepCollectionEquality().equals(other.rate, rate)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(amount) ^
      const DeepCollectionEquality().hash(currency) ^
      const DeepCollectionEquality().hash(rate) ^
      runtimeType.hashCode;
}

extension $PendingTransaction$Meta$ConversionExtension
    on PendingTransaction$Meta$Conversion {
  PendingTransaction$Meta$Conversion copyWith({
    double? amount,
    String? currency,
    double? rate,
  }) {
    return PendingTransaction$Meta$Conversion(
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      rate: rate ?? this.rate,
    );
  }

  PendingTransaction$Meta$Conversion copyWithWrapped({
    Wrapped<double?>? amount,
    Wrapped<String?>? currency,
    Wrapped<double?>? rate,
  }) {
    return PendingTransaction$Meta$Conversion(
      amount: (amount != null ? amount.value : this.amount),
      currency: (currency != null ? currency.value : this.currency),
      rate: (rate != null ? rate.value : this.rate),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Payment$Meta$Destination {
  const Payment$Meta$Destination({this.particulars, this.code, this.reference});

  factory Payment$Meta$Destination.fromJson(Map<String, dynamic> json) =>
      _$Payment$Meta$DestinationFromJson(json);

  static const toJsonFactory = _$Payment$Meta$DestinationToJson;
  Map<String, dynamic> toJson() => _$Payment$Meta$DestinationToJson(this);

  @JsonKey(name: 'particulars')
  final String? particulars;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'reference')
  final String? reference;
  static const fromJsonFactory = _$Payment$Meta$DestinationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Payment$Meta$Destination &&
            (identical(other.particulars, particulars) ||
                const DeepCollectionEquality().equals(
                  other.particulars,
                  particulars,
                )) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.reference, reference) ||
                const DeepCollectionEquality().equals(
                  other.reference,
                  reference,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(particulars) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(reference) ^
      runtimeType.hashCode;
}

extension $Payment$Meta$DestinationExtension on Payment$Meta$Destination {
  Payment$Meta$Destination copyWith({
    String? particulars,
    String? code,
    String? reference,
  }) {
    return Payment$Meta$Destination(
      particulars: particulars ?? this.particulars,
      code: code ?? this.code,
      reference: reference ?? this.reference,
    );
  }

  Payment$Meta$Destination copyWithWrapped({
    Wrapped<String?>? particulars,
    Wrapped<String?>? code,
    Wrapped<String?>? reference,
  }) {
    return Payment$Meta$Destination(
      particulars: (particulars != null ? particulars.value : this.particulars),
      code: (code != null ? code.value : this.code),
      reference: (reference != null ? reference.value : this.reference),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Payment$Meta$Source {
  const Payment$Meta$Source({this.code, this.reference});

  factory Payment$Meta$Source.fromJson(Map<String, dynamic> json) =>
      _$Payment$Meta$SourceFromJson(json);

  static const toJsonFactory = _$Payment$Meta$SourceToJson;
  Map<String, dynamic> toJson() => _$Payment$Meta$SourceToJson(this);

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'reference')
  final String? reference;
  static const fromJsonFactory = _$Payment$Meta$SourceFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Payment$Meta$Source &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.reference, reference) ||
                const DeepCollectionEquality().equals(
                  other.reference,
                  reference,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(reference) ^
      runtimeType.hashCode;
}

extension $Payment$Meta$SourceExtension on Payment$Meta$Source {
  Payment$Meta$Source copyWith({String? code, String? reference}) {
    return Payment$Meta$Source(
      code: code ?? this.code,
      reference: reference ?? this.reference,
    );
  }

  Payment$Meta$Source copyWithWrapped({
    Wrapped<String?>? code,
    Wrapped<String?>? reference,
  }) {
    return Payment$Meta$Source(
      code: (code != null ? code.value : this.code),
      reference: (reference != null ? reference.value : this.reference),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentsPost$RequestBody$Meta$Source {
  const PaymentsPost$RequestBody$Meta$Source({this.code, this.reference});

  factory PaymentsPost$RequestBody$Meta$Source.fromJson(
    Map<String, dynamic> json,
  ) => _$PaymentsPost$RequestBody$Meta$SourceFromJson(json);

  static const toJsonFactory = _$PaymentsPost$RequestBody$Meta$SourceToJson;
  Map<String, dynamic> toJson() =>
      _$PaymentsPost$RequestBody$Meta$SourceToJson(this);

  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'reference')
  final String? reference;
  static const fromJsonFactory = _$PaymentsPost$RequestBody$Meta$SourceFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentsPost$RequestBody$Meta$Source &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.reference, reference) ||
                const DeepCollectionEquality().equals(
                  other.reference,
                  reference,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(reference) ^
      runtimeType.hashCode;
}

extension $PaymentsPost$RequestBody$Meta$SourceExtension
    on PaymentsPost$RequestBody$Meta$Source {
  PaymentsPost$RequestBody$Meta$Source copyWith({
    String? code,
    String? reference,
  }) {
    return PaymentsPost$RequestBody$Meta$Source(
      code: code ?? this.code,
      reference: reference ?? this.reference,
    );
  }

  PaymentsPost$RequestBody$Meta$Source copyWithWrapped({
    Wrapped<String?>? code,
    Wrapped<String?>? reference,
  }) {
    return PaymentsPost$RequestBody$Meta$Source(
      code: (code != null ? code.value : this.code),
      reference: (reference != null ? reference.value : this.reference),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class PaymentsPost$RequestBody$Meta$Destination {
  const PaymentsPost$RequestBody$Meta$Destination({
    this.particulars,
    this.code,
    this.reference,
  });

  factory PaymentsPost$RequestBody$Meta$Destination.fromJson(
    Map<String, dynamic> json,
  ) => _$PaymentsPost$RequestBody$Meta$DestinationFromJson(json);

  static const toJsonFactory =
      _$PaymentsPost$RequestBody$Meta$DestinationToJson;
  Map<String, dynamic> toJson() =>
      _$PaymentsPost$RequestBody$Meta$DestinationToJson(this);

  @JsonKey(name: 'particulars')
  final String? particulars;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'reference')
  final String? reference;
  static const fromJsonFactory =
      _$PaymentsPost$RequestBody$Meta$DestinationFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is PaymentsPost$RequestBody$Meta$Destination &&
            (identical(other.particulars, particulars) ||
                const DeepCollectionEquality().equals(
                  other.particulars,
                  particulars,
                )) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.reference, reference) ||
                const DeepCollectionEquality().equals(
                  other.reference,
                  reference,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(particulars) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(reference) ^
      runtimeType.hashCode;
}

extension $PaymentsPost$RequestBody$Meta$DestinationExtension
    on PaymentsPost$RequestBody$Meta$Destination {
  PaymentsPost$RequestBody$Meta$Destination copyWith({
    String? particulars,
    String? code,
    String? reference,
  }) {
    return PaymentsPost$RequestBody$Meta$Destination(
      particulars: particulars ?? this.particulars,
      code: code ?? this.code,
      reference: reference ?? this.reference,
    );
  }

  PaymentsPost$RequestBody$Meta$Destination copyWithWrapped({
    Wrapped<String?>? particulars,
    Wrapped<String?>? code,
    Wrapped<String?>? reference,
  }) {
    return PaymentsPost$RequestBody$Meta$Destination(
      particulars: (particulars != null ? particulars.value : this.particulars),
      code: (code != null ? code.value : this.code),
      reference: (reference != null ? reference.value : this.reference),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Account$Meta$LoanDetails$Interest {
  const Account$Meta$LoanDetails$Interest({
    required this.rate,
    required this.type,
    this.expiresAt,
  });

  factory Account$Meta$LoanDetails$Interest.fromJson(
    Map<String, dynamic> json,
  ) => _$Account$Meta$LoanDetails$InterestFromJson(json);

  static const toJsonFactory = _$Account$Meta$LoanDetails$InterestToJson;
  Map<String, dynamic> toJson() =>
      _$Account$Meta$LoanDetails$InterestToJson(this);

  @JsonKey(name: 'rate')
  final double rate;
  @JsonKey(
    name: 'type',
    toJson: account$Meta$LoanDetails$InterestTypeToJson,
    fromJson: account$Meta$LoanDetails$InterestTypeFromJson,
  )
  final enums.Account$Meta$LoanDetails$InterestType type;
  @JsonKey(name: 'expires_at')
  final DateTime? expiresAt;
  static const fromJsonFactory = _$Account$Meta$LoanDetails$InterestFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Account$Meta$LoanDetails$Interest &&
            (identical(other.rate, rate) ||
                const DeepCollectionEquality().equals(other.rate, rate)) &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.expiresAt, expiresAt) ||
                const DeepCollectionEquality().equals(
                  other.expiresAt,
                  expiresAt,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(rate) ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(expiresAt) ^
      runtimeType.hashCode;
}

extension $Account$Meta$LoanDetails$InterestExtension
    on Account$Meta$LoanDetails$Interest {
  Account$Meta$LoanDetails$Interest copyWith({
    double? rate,
    enums.Account$Meta$LoanDetails$InterestType? type,
    DateTime? expiresAt,
  }) {
    return Account$Meta$LoanDetails$Interest(
      rate: rate ?? this.rate,
      type: type ?? this.type,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  Account$Meta$LoanDetails$Interest copyWithWrapped({
    Wrapped<double>? rate,
    Wrapped<enums.Account$Meta$LoanDetails$InterestType>? type,
    Wrapped<DateTime?>? expiresAt,
  }) {
    return Account$Meta$LoanDetails$Interest(
      rate: (rate != null ? rate.value : this.rate),
      type: (type != null ? type.value : this.type),
      expiresAt: (expiresAt != null ? expiresAt.value : this.expiresAt),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Account$Meta$LoanDetails$Term {
  const Account$Meta$LoanDetails$Term({this.years, this.months});

  factory Account$Meta$LoanDetails$Term.fromJson(Map<String, dynamic> json) =>
      _$Account$Meta$LoanDetails$TermFromJson(json);

  static const toJsonFactory = _$Account$Meta$LoanDetails$TermToJson;
  Map<String, dynamic> toJson() => _$Account$Meta$LoanDetails$TermToJson(this);

  @JsonKey(name: 'years')
  final double? years;
  @JsonKey(name: 'months')
  final double? months;
  static const fromJsonFactory = _$Account$Meta$LoanDetails$TermFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Account$Meta$LoanDetails$Term &&
            (identical(other.years, years) ||
                const DeepCollectionEquality().equals(other.years, years)) &&
            (identical(other.months, months) ||
                const DeepCollectionEquality().equals(other.months, months)));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(years) ^
      const DeepCollectionEquality().hash(months) ^
      runtimeType.hashCode;
}

extension $Account$Meta$LoanDetails$TermExtension
    on Account$Meta$LoanDetails$Term {
  Account$Meta$LoanDetails$Term copyWith({double? years, double? months}) {
    return Account$Meta$LoanDetails$Term(
      years: years ?? this.years,
      months: months ?? this.months,
    );
  }

  Account$Meta$LoanDetails$Term copyWithWrapped({
    Wrapped<double?>? years,
    Wrapped<double?>? months,
  }) {
    return Account$Meta$LoanDetails$Term(
      years: (years != null ? years.value : this.years),
      months: (months != null ? months.value : this.months),
    );
  }
}

@JsonSerializable(explicitToJson: true)
class Account$Meta$LoanDetails$Repayment {
  const Account$Meta$LoanDetails$Repayment({
    this.frequency,
    this.nextDate,
    required this.nextAmount,
  });

  factory Account$Meta$LoanDetails$Repayment.fromJson(
    Map<String, dynamic> json,
  ) => _$Account$Meta$LoanDetails$RepaymentFromJson(json);

  static const toJsonFactory = _$Account$Meta$LoanDetails$RepaymentToJson;
  Map<String, dynamic> toJson() =>
      _$Account$Meta$LoanDetails$RepaymentToJson(this);

  @JsonKey(
    name: 'frequency',
    toJson: account$Meta$LoanDetails$RepaymentFrequencyNullableToJson,
    fromJson: account$Meta$LoanDetails$RepaymentFrequencyNullableFromJson,
  )
  final enums.Account$Meta$LoanDetails$RepaymentFrequency? frequency;
  @JsonKey(name: 'next_date')
  final DateTime? nextDate;
  @JsonKey(name: 'next_amount')
  final double nextAmount;
  static const fromJsonFactory = _$Account$Meta$LoanDetails$RepaymentFromJson;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other is Account$Meta$LoanDetails$Repayment &&
            (identical(other.frequency, frequency) ||
                const DeepCollectionEquality().equals(
                  other.frequency,
                  frequency,
                )) &&
            (identical(other.nextDate, nextDate) ||
                const DeepCollectionEquality().equals(
                  other.nextDate,
                  nextDate,
                )) &&
            (identical(other.nextAmount, nextAmount) ||
                const DeepCollectionEquality().equals(
                  other.nextAmount,
                  nextAmount,
                )));
  }

  @override
  String toString() => jsonEncode(this);

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(frequency) ^
      const DeepCollectionEquality().hash(nextDate) ^
      const DeepCollectionEquality().hash(nextAmount) ^
      runtimeType.hashCode;
}

extension $Account$Meta$LoanDetails$RepaymentExtension
    on Account$Meta$LoanDetails$Repayment {
  Account$Meta$LoanDetails$Repayment copyWith({
    enums.Account$Meta$LoanDetails$RepaymentFrequency? frequency,
    DateTime? nextDate,
    double? nextAmount,
  }) {
    return Account$Meta$LoanDetails$Repayment(
      frequency: frequency ?? this.frequency,
      nextDate: nextDate ?? this.nextDate,
      nextAmount: nextAmount ?? this.nextAmount,
    );
  }

  Account$Meta$LoanDetails$Repayment copyWithWrapped({
    Wrapped<enums.Account$Meta$LoanDetails$RepaymentFrequency?>? frequency,
    Wrapped<DateTime?>? nextDate,
    Wrapped<double>? nextAmount,
  }) {
    return Account$Meta$LoanDetails$Repayment(
      frequency: (frequency != null ? frequency.value : this.frequency),
      nextDate: (nextDate != null ? nextDate.value : this.nextDate),
      nextAmount: (nextAmount != null ? nextAmount.value : this.nextAmount),
    );
  }
}

String? connectionTypeNullableToJson(enums.ConnectionType? connectionType) {
  return connectionType?.value;
}

String? connectionTypeToJson(enums.ConnectionType connectionType) {
  return connectionType.value;
}

enums.ConnectionType connectionTypeFromJson(
  Object? connectionType, [
  enums.ConnectionType? defaultValue,
]) {
  return enums.ConnectionType.values.firstWhereOrNull(
        (e) => e.value == connectionType,
      ) ??
      defaultValue ??
      enums.ConnectionType.swaggerGeneratedUnknown;
}

enums.ConnectionType? connectionTypeNullableFromJson(
  Object? connectionType, [
  enums.ConnectionType? defaultValue,
]) {
  if (connectionType == null) {
    return null;
  }
  return enums.ConnectionType.values.firstWhereOrNull(
        (e) => e.value == connectionType,
      ) ??
      defaultValue;
}

String connectionTypeExplodedListToJson(
  List<enums.ConnectionType>? connectionType,
) {
  return connectionType?.map((e) => e.value!).join(',') ?? '';
}

List<String> connectionTypeListToJson(
  List<enums.ConnectionType>? connectionType,
) {
  if (connectionType == null) {
    return [];
  }

  return connectionType.map((e) => e.value!).toList();
}

List<enums.ConnectionType> connectionTypeListFromJson(
  List? connectionType, [
  List<enums.ConnectionType>? defaultValue,
]) {
  if (connectionType == null) {
    return defaultValue ?? [];
  }

  return connectionType
      .map((e) => connectionTypeFromJson(e.toString()))
      .toList();
}

List<enums.ConnectionType>? connectionTypeNullableListFromJson(
  List? connectionType, [
  List<enums.ConnectionType>? defaultValue,
]) {
  if (connectionType == null) {
    return defaultValue;
  }

  return connectionType
      .map((e) => connectionTypeFromJson(e.toString()))
      .toList();
}

String? connectionModeNullableToJson(enums.ConnectionMode? connectionMode) {
  return connectionMode?.value;
}

String? connectionModeToJson(enums.ConnectionMode connectionMode) {
  return connectionMode.value;
}

enums.ConnectionMode connectionModeFromJson(
  Object? connectionMode, [
  enums.ConnectionMode? defaultValue,
]) {
  return enums.ConnectionMode.values.firstWhereOrNull(
        (e) => e.value == connectionMode,
      ) ??
      defaultValue ??
      enums.ConnectionMode.swaggerGeneratedUnknown;
}

enums.ConnectionMode? connectionModeNullableFromJson(
  Object? connectionMode, [
  enums.ConnectionMode? defaultValue,
]) {
  if (connectionMode == null) {
    return null;
  }
  return enums.ConnectionMode.values.firstWhereOrNull(
        (e) => e.value == connectionMode,
      ) ??
      defaultValue;
}

String connectionModeExplodedListToJson(
  List<enums.ConnectionMode>? connectionMode,
) {
  return connectionMode?.map((e) => e.value!).join(',') ?? '';
}

List<String> connectionModeListToJson(
  List<enums.ConnectionMode>? connectionMode,
) {
  if (connectionMode == null) {
    return [];
  }

  return connectionMode.map((e) => e.value!).toList();
}

List<enums.ConnectionMode> connectionModeListFromJson(
  List? connectionMode, [
  List<enums.ConnectionMode>? defaultValue,
]) {
  if (connectionMode == null) {
    return defaultValue ?? [];
  }

  return connectionMode
      .map((e) => connectionModeFromJson(e.toString()))
      .toList();
}

List<enums.ConnectionMode>? connectionModeNullableListFromJson(
  List? connectionMode, [
  List<enums.ConnectionMode>? defaultValue,
]) {
  if (connectionMode == null) {
    return defaultValue;
  }

  return connectionMode
      .map((e) => connectionModeFromJson(e.toString()))
      .toList();
}

String? paymentPeriodFrequencyNullableToJson(
  enums.PaymentPeriodFrequency? paymentPeriodFrequency,
) {
  return paymentPeriodFrequency?.value;
}

String? paymentPeriodFrequencyToJson(
  enums.PaymentPeriodFrequency paymentPeriodFrequency,
) {
  return paymentPeriodFrequency.value;
}

enums.PaymentPeriodFrequency paymentPeriodFrequencyFromJson(
  Object? paymentPeriodFrequency, [
  enums.PaymentPeriodFrequency? defaultValue,
]) {
  return enums.PaymentPeriodFrequency.values.firstWhereOrNull(
        (e) => e.value == paymentPeriodFrequency,
      ) ??
      defaultValue ??
      enums.PaymentPeriodFrequency.swaggerGeneratedUnknown;
}

enums.PaymentPeriodFrequency? paymentPeriodFrequencyNullableFromJson(
  Object? paymentPeriodFrequency, [
  enums.PaymentPeriodFrequency? defaultValue,
]) {
  if (paymentPeriodFrequency == null) {
    return null;
  }
  return enums.PaymentPeriodFrequency.values.firstWhereOrNull(
        (e) => e.value == paymentPeriodFrequency,
      ) ??
      defaultValue;
}

String paymentPeriodFrequencyExplodedListToJson(
  List<enums.PaymentPeriodFrequency>? paymentPeriodFrequency,
) {
  return paymentPeriodFrequency?.map((e) => e.value!).join(',') ?? '';
}

List<String> paymentPeriodFrequencyListToJson(
  List<enums.PaymentPeriodFrequency>? paymentPeriodFrequency,
) {
  if (paymentPeriodFrequency == null) {
    return [];
  }

  return paymentPeriodFrequency.map((e) => e.value!).toList();
}

List<enums.PaymentPeriodFrequency> paymentPeriodFrequencyListFromJson(
  List? paymentPeriodFrequency, [
  List<enums.PaymentPeriodFrequency>? defaultValue,
]) {
  if (paymentPeriodFrequency == null) {
    return defaultValue ?? [];
  }

  return paymentPeriodFrequency
      .map((e) => paymentPeriodFrequencyFromJson(e.toString()))
      .toList();
}

List<enums.PaymentPeriodFrequency>? paymentPeriodFrequencyNullableListFromJson(
  List? paymentPeriodFrequency, [
  List<enums.PaymentPeriodFrequency>? defaultValue,
]) {
  if (paymentPeriodFrequency == null) {
    return defaultValue;
  }

  return paymentPeriodFrequency
      .map((e) => paymentPeriodFrequencyFromJson(e.toString()))
      .toList();
}

String? accountStatusNullableToJson(enums.AccountStatus? accountStatus) {
  return accountStatus?.value;
}

String? accountStatusToJson(enums.AccountStatus accountStatus) {
  return accountStatus.value;
}

enums.AccountStatus accountStatusFromJson(
  Object? accountStatus, [
  enums.AccountStatus? defaultValue,
]) {
  return enums.AccountStatus.values.firstWhereOrNull(
        (e) => e.value == accountStatus,
      ) ??
      defaultValue ??
      enums.AccountStatus.swaggerGeneratedUnknown;
}

enums.AccountStatus? accountStatusNullableFromJson(
  Object? accountStatus, [
  enums.AccountStatus? defaultValue,
]) {
  if (accountStatus == null) {
    return null;
  }
  return enums.AccountStatus.values.firstWhereOrNull(
        (e) => e.value == accountStatus,
      ) ??
      defaultValue;
}

String accountStatusExplodedListToJson(
  List<enums.AccountStatus>? accountStatus,
) {
  return accountStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> accountStatusListToJson(List<enums.AccountStatus>? accountStatus) {
  if (accountStatus == null) {
    return [];
  }

  return accountStatus.map((e) => e.value!).toList();
}

List<enums.AccountStatus> accountStatusListFromJson(
  List? accountStatus, [
  List<enums.AccountStatus>? defaultValue,
]) {
  if (accountStatus == null) {
    return defaultValue ?? [];
  }

  return accountStatus.map((e) => accountStatusFromJson(e.toString())).toList();
}

List<enums.AccountStatus>? accountStatusNullableListFromJson(
  List? accountStatus, [
  List<enums.AccountStatus>? defaultValue,
]) {
  if (accountStatus == null) {
    return defaultValue;
  }

  return accountStatus.map((e) => accountStatusFromJson(e.toString())).toList();
}

String? accountTypeNullableToJson(enums.AccountType? accountType) {
  return accountType?.value;
}

String? accountTypeToJson(enums.AccountType accountType) {
  return accountType.value;
}

enums.AccountType accountTypeFromJson(
  Object? accountType, [
  enums.AccountType? defaultValue,
]) {
  return enums.AccountType.values.firstWhereOrNull(
        (e) => e.value == accountType,
      ) ??
      defaultValue ??
      enums.AccountType.swaggerGeneratedUnknown;
}

enums.AccountType? accountTypeNullableFromJson(
  Object? accountType, [
  enums.AccountType? defaultValue,
]) {
  if (accountType == null) {
    return null;
  }
  return enums.AccountType.values.firstWhereOrNull(
        (e) => e.value == accountType,
      ) ??
      defaultValue;
}

String accountTypeExplodedListToJson(List<enums.AccountType>? accountType) {
  return accountType?.map((e) => e.value!).join(',') ?? '';
}

List<String> accountTypeListToJson(List<enums.AccountType>? accountType) {
  if (accountType == null) {
    return [];
  }

  return accountType.map((e) => e.value!).toList();
}

List<enums.AccountType> accountTypeListFromJson(
  List? accountType, [
  List<enums.AccountType>? defaultValue,
]) {
  if (accountType == null) {
    return defaultValue ?? [];
  }

  return accountType.map((e) => accountTypeFromJson(e.toString())).toList();
}

List<enums.AccountType>? accountTypeNullableListFromJson(
  List? accountType, [
  List<enums.AccountType>? defaultValue,
]) {
  if (accountType == null) {
    return defaultValue;
  }

  return accountType.map((e) => accountTypeFromJson(e.toString())).toList();
}

String? accountAttributesNullableToJson(
  enums.AccountAttributes? accountAttributes,
) {
  return accountAttributes?.value;
}

String? accountAttributesToJson(enums.AccountAttributes accountAttributes) {
  return accountAttributes.value;
}

enums.AccountAttributes accountAttributesFromJson(
  Object? accountAttributes, [
  enums.AccountAttributes? defaultValue,
]) {
  return enums.AccountAttributes.values.firstWhereOrNull(
        (e) => e.value == accountAttributes,
      ) ??
      defaultValue ??
      enums.AccountAttributes.swaggerGeneratedUnknown;
}

enums.AccountAttributes? accountAttributesNullableFromJson(
  Object? accountAttributes, [
  enums.AccountAttributes? defaultValue,
]) {
  if (accountAttributes == null) {
    return null;
  }
  return enums.AccountAttributes.values.firstWhereOrNull(
        (e) => e.value == accountAttributes,
      ) ??
      defaultValue;
}

String accountAttributesExplodedListToJson(
  List<enums.AccountAttributes>? accountAttributes,
) {
  return accountAttributes?.map((e) => e.value!).join(',') ?? '';
}

List<String> accountAttributesListToJson(
  List<enums.AccountAttributes>? accountAttributes,
) {
  if (accountAttributes == null) {
    return [];
  }

  return accountAttributes.map((e) => e.value!).toList();
}

List<enums.AccountAttributes> accountAttributesListFromJson(
  List? accountAttributes, [
  List<enums.AccountAttributes>? defaultValue,
]) {
  if (accountAttributes == null) {
    return defaultValue ?? [];
  }

  return accountAttributes
      .map((e) => accountAttributesFromJson(e.toString()))
      .toList();
}

List<enums.AccountAttributes>? accountAttributesNullableListFromJson(
  List? accountAttributes, [
  List<enums.AccountAttributes>? defaultValue,
]) {
  if (accountAttributes == null) {
    return defaultValue;
  }

  return accountAttributes
      .map((e) => accountAttributesFromJson(e.toString()))
      .toList();
}

String? account$Meta$LoanDetailsPurposeNullableToJson(
  enums.Account$Meta$LoanDetailsPurpose? account$Meta$LoanDetailsPurpose,
) {
  return account$Meta$LoanDetailsPurpose?.value;
}

String? account$Meta$LoanDetailsPurposeToJson(
  enums.Account$Meta$LoanDetailsPurpose account$Meta$LoanDetailsPurpose,
) {
  return account$Meta$LoanDetailsPurpose.value;
}

enums.Account$Meta$LoanDetailsPurpose account$Meta$LoanDetailsPurposeFromJson(
  Object? account$Meta$LoanDetailsPurpose, [
  enums.Account$Meta$LoanDetailsPurpose? defaultValue,
]) {
  return enums.Account$Meta$LoanDetailsPurpose.values.firstWhereOrNull(
        (e) => e.value == account$Meta$LoanDetailsPurpose,
      ) ??
      defaultValue ??
      enums.Account$Meta$LoanDetailsPurpose.swaggerGeneratedUnknown;
}

enums.Account$Meta$LoanDetailsPurpose?
account$Meta$LoanDetailsPurposeNullableFromJson(
  Object? account$Meta$LoanDetailsPurpose, [
  enums.Account$Meta$LoanDetailsPurpose? defaultValue,
]) {
  if (account$Meta$LoanDetailsPurpose == null) {
    return null;
  }
  return enums.Account$Meta$LoanDetailsPurpose.values.firstWhereOrNull(
        (e) => e.value == account$Meta$LoanDetailsPurpose,
      ) ??
      defaultValue;
}

String account$Meta$LoanDetailsPurposeExplodedListToJson(
  List<enums.Account$Meta$LoanDetailsPurpose>? account$Meta$LoanDetailsPurpose,
) {
  return account$Meta$LoanDetailsPurpose?.map((e) => e.value!).join(',') ?? '';
}

List<String> account$Meta$LoanDetailsPurposeListToJson(
  List<enums.Account$Meta$LoanDetailsPurpose>? account$Meta$LoanDetailsPurpose,
) {
  if (account$Meta$LoanDetailsPurpose == null) {
    return [];
  }

  return account$Meta$LoanDetailsPurpose.map((e) => e.value!).toList();
}

List<enums.Account$Meta$LoanDetailsPurpose>
account$Meta$LoanDetailsPurposeListFromJson(
  List? account$Meta$LoanDetailsPurpose, [
  List<enums.Account$Meta$LoanDetailsPurpose>? defaultValue,
]) {
  if (account$Meta$LoanDetailsPurpose == null) {
    return defaultValue ?? [];
  }

  return account$Meta$LoanDetailsPurpose
      .map((e) => account$Meta$LoanDetailsPurposeFromJson(e.toString()))
      .toList();
}

List<enums.Account$Meta$LoanDetailsPurpose>?
account$Meta$LoanDetailsPurposeNullableListFromJson(
  List? account$Meta$LoanDetailsPurpose, [
  List<enums.Account$Meta$LoanDetailsPurpose>? defaultValue,
]) {
  if (account$Meta$LoanDetailsPurpose == null) {
    return defaultValue;
  }

  return account$Meta$LoanDetailsPurpose
      .map((e) => account$Meta$LoanDetailsPurposeFromJson(e.toString()))
      .toList();
}

String? account$Meta$LoanDetailsTypeNullableToJson(
  enums.Account$Meta$LoanDetailsType? account$Meta$LoanDetailsType,
) {
  return account$Meta$LoanDetailsType?.value;
}

String? account$Meta$LoanDetailsTypeToJson(
  enums.Account$Meta$LoanDetailsType account$Meta$LoanDetailsType,
) {
  return account$Meta$LoanDetailsType.value;
}

enums.Account$Meta$LoanDetailsType account$Meta$LoanDetailsTypeFromJson(
  Object? account$Meta$LoanDetailsType, [
  enums.Account$Meta$LoanDetailsType? defaultValue,
]) {
  return enums.Account$Meta$LoanDetailsType.values.firstWhereOrNull(
        (e) => e.value == account$Meta$LoanDetailsType,
      ) ??
      defaultValue ??
      enums.Account$Meta$LoanDetailsType.swaggerGeneratedUnknown;
}

enums.Account$Meta$LoanDetailsType?
account$Meta$LoanDetailsTypeNullableFromJson(
  Object? account$Meta$LoanDetailsType, [
  enums.Account$Meta$LoanDetailsType? defaultValue,
]) {
  if (account$Meta$LoanDetailsType == null) {
    return null;
  }
  return enums.Account$Meta$LoanDetailsType.values.firstWhereOrNull(
        (e) => e.value == account$Meta$LoanDetailsType,
      ) ??
      defaultValue;
}

String account$Meta$LoanDetailsTypeExplodedListToJson(
  List<enums.Account$Meta$LoanDetailsType>? account$Meta$LoanDetailsType,
) {
  return account$Meta$LoanDetailsType?.map((e) => e.value!).join(',') ?? '';
}

List<String> account$Meta$LoanDetailsTypeListToJson(
  List<enums.Account$Meta$LoanDetailsType>? account$Meta$LoanDetailsType,
) {
  if (account$Meta$LoanDetailsType == null) {
    return [];
  }

  return account$Meta$LoanDetailsType.map((e) => e.value!).toList();
}

List<enums.Account$Meta$LoanDetailsType>
account$Meta$LoanDetailsTypeListFromJson(
  List? account$Meta$LoanDetailsType, [
  List<enums.Account$Meta$LoanDetailsType>? defaultValue,
]) {
  if (account$Meta$LoanDetailsType == null) {
    return defaultValue ?? [];
  }

  return account$Meta$LoanDetailsType
      .map((e) => account$Meta$LoanDetailsTypeFromJson(e.toString()))
      .toList();
}

List<enums.Account$Meta$LoanDetailsType>?
account$Meta$LoanDetailsTypeNullableListFromJson(
  List? account$Meta$LoanDetailsType, [
  List<enums.Account$Meta$LoanDetailsType>? defaultValue,
]) {
  if (account$Meta$LoanDetailsType == null) {
    return defaultValue;
  }

  return account$Meta$LoanDetailsType
      .map((e) => account$Meta$LoanDetailsTypeFromJson(e.toString()))
      .toList();
}

String? account$Meta$LoanDetails$InterestTypeNullableToJson(
  enums.Account$Meta$LoanDetails$InterestType?
  account$Meta$LoanDetails$InterestType,
) {
  return account$Meta$LoanDetails$InterestType?.value;
}

String? account$Meta$LoanDetails$InterestTypeToJson(
  enums.Account$Meta$LoanDetails$InterestType
  account$Meta$LoanDetails$InterestType,
) {
  return account$Meta$LoanDetails$InterestType.value;
}

enums.Account$Meta$LoanDetails$InterestType
account$Meta$LoanDetails$InterestTypeFromJson(
  Object? account$Meta$LoanDetails$InterestType, [
  enums.Account$Meta$LoanDetails$InterestType? defaultValue,
]) {
  return enums.Account$Meta$LoanDetails$InterestType.values.firstWhereOrNull(
        (e) => e.value == account$Meta$LoanDetails$InterestType,
      ) ??
      defaultValue ??
      enums.Account$Meta$LoanDetails$InterestType.swaggerGeneratedUnknown;
}

enums.Account$Meta$LoanDetails$InterestType?
account$Meta$LoanDetails$InterestTypeNullableFromJson(
  Object? account$Meta$LoanDetails$InterestType, [
  enums.Account$Meta$LoanDetails$InterestType? defaultValue,
]) {
  if (account$Meta$LoanDetails$InterestType == null) {
    return null;
  }
  return enums.Account$Meta$LoanDetails$InterestType.values.firstWhereOrNull(
        (e) => e.value == account$Meta$LoanDetails$InterestType,
      ) ??
      defaultValue;
}

String account$Meta$LoanDetails$InterestTypeExplodedListToJson(
  List<enums.Account$Meta$LoanDetails$InterestType>?
  account$Meta$LoanDetails$InterestType,
) {
  return account$Meta$LoanDetails$InterestType
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> account$Meta$LoanDetails$InterestTypeListToJson(
  List<enums.Account$Meta$LoanDetails$InterestType>?
  account$Meta$LoanDetails$InterestType,
) {
  if (account$Meta$LoanDetails$InterestType == null) {
    return [];
  }

  return account$Meta$LoanDetails$InterestType.map((e) => e.value!).toList();
}

List<enums.Account$Meta$LoanDetails$InterestType>
account$Meta$LoanDetails$InterestTypeListFromJson(
  List? account$Meta$LoanDetails$InterestType, [
  List<enums.Account$Meta$LoanDetails$InterestType>? defaultValue,
]) {
  if (account$Meta$LoanDetails$InterestType == null) {
    return defaultValue ?? [];
  }

  return account$Meta$LoanDetails$InterestType
      .map((e) => account$Meta$LoanDetails$InterestTypeFromJson(e.toString()))
      .toList();
}

List<enums.Account$Meta$LoanDetails$InterestType>?
account$Meta$LoanDetails$InterestTypeNullableListFromJson(
  List? account$Meta$LoanDetails$InterestType, [
  List<enums.Account$Meta$LoanDetails$InterestType>? defaultValue,
]) {
  if (account$Meta$LoanDetails$InterestType == null) {
    return defaultValue;
  }

  return account$Meta$LoanDetails$InterestType
      .map((e) => account$Meta$LoanDetails$InterestTypeFromJson(e.toString()))
      .toList();
}

String? account$Meta$LoanDetails$RepaymentFrequencyNullableToJson(
  enums.Account$Meta$LoanDetails$RepaymentFrequency?
  account$Meta$LoanDetails$RepaymentFrequency,
) {
  return account$Meta$LoanDetails$RepaymentFrequency?.value;
}

String? account$Meta$LoanDetails$RepaymentFrequencyToJson(
  enums.Account$Meta$LoanDetails$RepaymentFrequency
  account$Meta$LoanDetails$RepaymentFrequency,
) {
  return account$Meta$LoanDetails$RepaymentFrequency.value;
}

enums.Account$Meta$LoanDetails$RepaymentFrequency
account$Meta$LoanDetails$RepaymentFrequencyFromJson(
  Object? account$Meta$LoanDetails$RepaymentFrequency, [
  enums.Account$Meta$LoanDetails$RepaymentFrequency? defaultValue,
]) {
  return enums.Account$Meta$LoanDetails$RepaymentFrequency.values
          .firstWhereOrNull(
            (e) => e.value == account$Meta$LoanDetails$RepaymentFrequency,
          ) ??
      defaultValue ??
      enums.Account$Meta$LoanDetails$RepaymentFrequency.swaggerGeneratedUnknown;
}

enums.Account$Meta$LoanDetails$RepaymentFrequency?
account$Meta$LoanDetails$RepaymentFrequencyNullableFromJson(
  Object? account$Meta$LoanDetails$RepaymentFrequency, [
  enums.Account$Meta$LoanDetails$RepaymentFrequency? defaultValue,
]) {
  if (account$Meta$LoanDetails$RepaymentFrequency == null) {
    return null;
  }
  return enums.Account$Meta$LoanDetails$RepaymentFrequency.values
          .firstWhereOrNull(
            (e) => e.value == account$Meta$LoanDetails$RepaymentFrequency,
          ) ??
      defaultValue;
}

String account$Meta$LoanDetails$RepaymentFrequencyExplodedListToJson(
  List<enums.Account$Meta$LoanDetails$RepaymentFrequency>?
  account$Meta$LoanDetails$RepaymentFrequency,
) {
  return account$Meta$LoanDetails$RepaymentFrequency
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> account$Meta$LoanDetails$RepaymentFrequencyListToJson(
  List<enums.Account$Meta$LoanDetails$RepaymentFrequency>?
  account$Meta$LoanDetails$RepaymentFrequency,
) {
  if (account$Meta$LoanDetails$RepaymentFrequency == null) {
    return [];
  }

  return account$Meta$LoanDetails$RepaymentFrequency
      .map((e) => e.value!)
      .toList();
}

List<enums.Account$Meta$LoanDetails$RepaymentFrequency>
account$Meta$LoanDetails$RepaymentFrequencyListFromJson(
  List? account$Meta$LoanDetails$RepaymentFrequency, [
  List<enums.Account$Meta$LoanDetails$RepaymentFrequency>? defaultValue,
]) {
  if (account$Meta$LoanDetails$RepaymentFrequency == null) {
    return defaultValue ?? [];
  }

  return account$Meta$LoanDetails$RepaymentFrequency
      .map(
        (e) =>
            account$Meta$LoanDetails$RepaymentFrequencyFromJson(e.toString()),
      )
      .toList();
}

List<enums.Account$Meta$LoanDetails$RepaymentFrequency>?
account$Meta$LoanDetails$RepaymentFrequencyNullableListFromJson(
  List? account$Meta$LoanDetails$RepaymentFrequency, [
  List<enums.Account$Meta$LoanDetails$RepaymentFrequency>? defaultValue,
]) {
  if (account$Meta$LoanDetails$RepaymentFrequency == null) {
    return defaultValue;
  }

  return account$Meta$LoanDetails$RepaymentFrequency
      .map(
        (e) =>
            account$Meta$LoanDetails$RepaymentFrequencyFromJson(e.toString()),
      )
      .toList();
}

String? addressTypeNullableToJson(enums.AddressType? addressType) {
  return addressType?.value;
}

String? addressTypeToJson(enums.AddressType addressType) {
  return addressType.value;
}

enums.AddressType addressTypeFromJson(
  Object? addressType, [
  enums.AddressType? defaultValue,
]) {
  return enums.AddressType.values.firstWhereOrNull(
        (e) => e.value == addressType,
      ) ??
      defaultValue ??
      enums.AddressType.swaggerGeneratedUnknown;
}

enums.AddressType? addressTypeNullableFromJson(
  Object? addressType, [
  enums.AddressType? defaultValue,
]) {
  if (addressType == null) {
    return null;
  }
  return enums.AddressType.values.firstWhereOrNull(
        (e) => e.value == addressType,
      ) ??
      defaultValue;
}

String addressTypeExplodedListToJson(List<enums.AddressType>? addressType) {
  return addressType?.map((e) => e.value!).join(',') ?? '';
}

List<String> addressTypeListToJson(List<enums.AddressType>? addressType) {
  if (addressType == null) {
    return [];
  }

  return addressType.map((e) => e.value!).toList();
}

List<enums.AddressType> addressTypeListFromJson(
  List? addressType, [
  List<enums.AddressType>? defaultValue,
]) {
  if (addressType == null) {
    return defaultValue ?? [];
  }

  return addressType.map((e) => addressTypeFromJson(e.toString())).toList();
}

List<enums.AddressType>? addressTypeNullableListFromJson(
  List? addressType, [
  List<enums.AddressType>? defaultValue,
]) {
  if (addressType == null) {
    return defaultValue;
  }

  return addressType.map((e) => addressTypeFromJson(e.toString())).toList();
}

String? oneOffIdentityStatusNullableToJson(
  enums.OneOffIdentityStatus? oneOffIdentityStatus,
) {
  return oneOffIdentityStatus?.value;
}

String? oneOffIdentityStatusToJson(
  enums.OneOffIdentityStatus oneOffIdentityStatus,
) {
  return oneOffIdentityStatus.value;
}

enums.OneOffIdentityStatus oneOffIdentityStatusFromJson(
  Object? oneOffIdentityStatus, [
  enums.OneOffIdentityStatus? defaultValue,
]) {
  return enums.OneOffIdentityStatus.values.firstWhereOrNull(
        (e) => e.value == oneOffIdentityStatus,
      ) ??
      defaultValue ??
      enums.OneOffIdentityStatus.swaggerGeneratedUnknown;
}

enums.OneOffIdentityStatus? oneOffIdentityStatusNullableFromJson(
  Object? oneOffIdentityStatus, [
  enums.OneOffIdentityStatus? defaultValue,
]) {
  if (oneOffIdentityStatus == null) {
    return null;
  }
  return enums.OneOffIdentityStatus.values.firstWhereOrNull(
        (e) => e.value == oneOffIdentityStatus,
      ) ??
      defaultValue;
}

String oneOffIdentityStatusExplodedListToJson(
  List<enums.OneOffIdentityStatus>? oneOffIdentityStatus,
) {
  return oneOffIdentityStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> oneOffIdentityStatusListToJson(
  List<enums.OneOffIdentityStatus>? oneOffIdentityStatus,
) {
  if (oneOffIdentityStatus == null) {
    return [];
  }

  return oneOffIdentityStatus.map((e) => e.value!).toList();
}

List<enums.OneOffIdentityStatus> oneOffIdentityStatusListFromJson(
  List? oneOffIdentityStatus, [
  List<enums.OneOffIdentityStatus>? defaultValue,
]) {
  if (oneOffIdentityStatus == null) {
    return defaultValue ?? [];
  }

  return oneOffIdentityStatus
      .map((e) => oneOffIdentityStatusFromJson(e.toString()))
      .toList();
}

List<enums.OneOffIdentityStatus>? oneOffIdentityStatusNullableListFromJson(
  List? oneOffIdentityStatus, [
  List<enums.OneOffIdentityStatus>? defaultValue,
]) {
  if (oneOffIdentityStatus == null) {
    return defaultValue;
  }

  return oneOffIdentityStatus
      .map((e) => oneOffIdentityStatusFromJson(e.toString()))
      .toList();
}

String? verifyNameMatchTypeNullableToJson(
  enums.VerifyNameMatchType? verifyNameMatchType,
) {
  return verifyNameMatchType?.value;
}

String? verifyNameMatchTypeToJson(
  enums.VerifyNameMatchType verifyNameMatchType,
) {
  return verifyNameMatchType.value;
}

enums.VerifyNameMatchType verifyNameMatchTypeFromJson(
  Object? verifyNameMatchType, [
  enums.VerifyNameMatchType? defaultValue,
]) {
  return enums.VerifyNameMatchType.values.firstWhereOrNull(
        (e) => e.value == verifyNameMatchType,
      ) ??
      defaultValue ??
      enums.VerifyNameMatchType.swaggerGeneratedUnknown;
}

enums.VerifyNameMatchType? verifyNameMatchTypeNullableFromJson(
  Object? verifyNameMatchType, [
  enums.VerifyNameMatchType? defaultValue,
]) {
  if (verifyNameMatchType == null) {
    return null;
  }
  return enums.VerifyNameMatchType.values.firstWhereOrNull(
        (e) => e.value == verifyNameMatchType,
      ) ??
      defaultValue;
}

String verifyNameMatchTypeExplodedListToJson(
  List<enums.VerifyNameMatchType>? verifyNameMatchType,
) {
  return verifyNameMatchType?.map((e) => e.value!).join(',') ?? '';
}

List<String> verifyNameMatchTypeListToJson(
  List<enums.VerifyNameMatchType>? verifyNameMatchType,
) {
  if (verifyNameMatchType == null) {
    return [];
  }

  return verifyNameMatchType.map((e) => e.value!).toList();
}

List<enums.VerifyNameMatchType> verifyNameMatchTypeListFromJson(
  List? verifyNameMatchType, [
  List<enums.VerifyNameMatchType>? defaultValue,
]) {
  if (verifyNameMatchType == null) {
    return defaultValue ?? [];
  }

  return verifyNameMatchType
      .map((e) => verifyNameMatchTypeFromJson(e.toString()))
      .toList();
}

List<enums.VerifyNameMatchType>? verifyNameMatchTypeNullableListFromJson(
  List? verifyNameMatchType, [
  List<enums.VerifyNameMatchType>? defaultValue,
]) {
  if (verifyNameMatchType == null) {
    return defaultValue;
  }

  return verifyNameMatchType
      .map((e) => verifyNameMatchTypeFromJson(e.toString()))
      .toList();
}

String? verifyNamePartySourceTypeNullableToJson(
  enums.VerifyNamePartySourceType? verifyNamePartySourceType,
) {
  return verifyNamePartySourceType?.value;
}

String? verifyNamePartySourceTypeToJson(
  enums.VerifyNamePartySourceType verifyNamePartySourceType,
) {
  return verifyNamePartySourceType.value;
}

enums.VerifyNamePartySourceType verifyNamePartySourceTypeFromJson(
  Object? verifyNamePartySourceType, [
  enums.VerifyNamePartySourceType? defaultValue,
]) {
  return enums.VerifyNamePartySourceType.values.firstWhereOrNull(
        (e) => e.value == verifyNamePartySourceType,
      ) ??
      defaultValue ??
      enums.VerifyNamePartySourceType.swaggerGeneratedUnknown;
}

enums.VerifyNamePartySourceType? verifyNamePartySourceTypeNullableFromJson(
  Object? verifyNamePartySourceType, [
  enums.VerifyNamePartySourceType? defaultValue,
]) {
  if (verifyNamePartySourceType == null) {
    return null;
  }
  return enums.VerifyNamePartySourceType.values.firstWhereOrNull(
        (e) => e.value == verifyNamePartySourceType,
      ) ??
      defaultValue;
}

String verifyNamePartySourceTypeExplodedListToJson(
  List<enums.VerifyNamePartySourceType>? verifyNamePartySourceType,
) {
  return verifyNamePartySourceType?.map((e) => e.value!).join(',') ?? '';
}

List<String> verifyNamePartySourceTypeListToJson(
  List<enums.VerifyNamePartySourceType>? verifyNamePartySourceType,
) {
  if (verifyNamePartySourceType == null) {
    return [];
  }

  return verifyNamePartySourceType.map((e) => e.value!).toList();
}

List<enums.VerifyNamePartySourceType> verifyNamePartySourceTypeListFromJson(
  List? verifyNamePartySourceType, [
  List<enums.VerifyNamePartySourceType>? defaultValue,
]) {
  if (verifyNamePartySourceType == null) {
    return defaultValue ?? [];
  }

  return verifyNamePartySourceType
      .map((e) => verifyNamePartySourceTypeFromJson(e.toString()))
      .toList();
}

List<enums.VerifyNamePartySourceType>?
verifyNamePartySourceTypeNullableListFromJson(
  List? verifyNamePartySourceType, [
  List<enums.VerifyNamePartySourceType>? defaultValue,
]) {
  if (verifyNamePartySourceType == null) {
    return defaultValue;
  }

  return verifyNamePartySourceType
      .map((e) => verifyNamePartySourceTypeFromJson(e.toString()))
      .toList();
}

String? verifyNameHolderSourceTypeNullableToJson(
  enums.VerifyNameHolderSourceType? verifyNameHolderSourceType,
) {
  return verifyNameHolderSourceType?.value;
}

String? verifyNameHolderSourceTypeToJson(
  enums.VerifyNameHolderSourceType verifyNameHolderSourceType,
) {
  return verifyNameHolderSourceType.value;
}

enums.VerifyNameHolderSourceType verifyNameHolderSourceTypeFromJson(
  Object? verifyNameHolderSourceType, [
  enums.VerifyNameHolderSourceType? defaultValue,
]) {
  return enums.VerifyNameHolderSourceType.values.firstWhereOrNull(
        (e) => e.value == verifyNameHolderSourceType,
      ) ??
      defaultValue ??
      enums.VerifyNameHolderSourceType.swaggerGeneratedUnknown;
}

enums.VerifyNameHolderSourceType? verifyNameHolderSourceTypeNullableFromJson(
  Object? verifyNameHolderSourceType, [
  enums.VerifyNameHolderSourceType? defaultValue,
]) {
  if (verifyNameHolderSourceType == null) {
    return null;
  }
  return enums.VerifyNameHolderSourceType.values.firstWhereOrNull(
        (e) => e.value == verifyNameHolderSourceType,
      ) ??
      defaultValue;
}

String verifyNameHolderSourceTypeExplodedListToJson(
  List<enums.VerifyNameHolderSourceType>? verifyNameHolderSourceType,
) {
  return verifyNameHolderSourceType?.map((e) => e.value!).join(',') ?? '';
}

List<String> verifyNameHolderSourceTypeListToJson(
  List<enums.VerifyNameHolderSourceType>? verifyNameHolderSourceType,
) {
  if (verifyNameHolderSourceType == null) {
    return [];
  }

  return verifyNameHolderSourceType.map((e) => e.value!).toList();
}

List<enums.VerifyNameHolderSourceType> verifyNameHolderSourceTypeListFromJson(
  List? verifyNameHolderSourceType, [
  List<enums.VerifyNameHolderSourceType>? defaultValue,
]) {
  if (verifyNameHolderSourceType == null) {
    return defaultValue ?? [];
  }

  return verifyNameHolderSourceType
      .map((e) => verifyNameHolderSourceTypeFromJson(e.toString()))
      .toList();
}

List<enums.VerifyNameHolderSourceType>?
verifyNameHolderSourceTypeNullableListFromJson(
  List? verifyNameHolderSourceType, [
  List<enums.VerifyNameHolderSourceType>? defaultValue,
]) {
  if (verifyNameHolderSourceType == null) {
    return defaultValue;
  }

  return verifyNameHolderSourceType
      .map((e) => verifyNameHolderSourceTypeFromJson(e.toString()))
      .toList();
}

String? oneOffIdentityPartyGenderNullableToJson(
  enums.OneOffIdentityPartyGender? oneOffIdentityPartyGender,
) {
  return oneOffIdentityPartyGender?.value;
}

String? oneOffIdentityPartyGenderToJson(
  enums.OneOffIdentityPartyGender oneOffIdentityPartyGender,
) {
  return oneOffIdentityPartyGender.value;
}

enums.OneOffIdentityPartyGender oneOffIdentityPartyGenderFromJson(
  Object? oneOffIdentityPartyGender, [
  enums.OneOffIdentityPartyGender? defaultValue,
]) {
  return enums.OneOffIdentityPartyGender.values.firstWhereOrNull(
        (e) => e.value == oneOffIdentityPartyGender,
      ) ??
      defaultValue ??
      enums.OneOffIdentityPartyGender.swaggerGeneratedUnknown;
}

enums.OneOffIdentityPartyGender? oneOffIdentityPartyGenderNullableFromJson(
  Object? oneOffIdentityPartyGender, [
  enums.OneOffIdentityPartyGender? defaultValue,
]) {
  if (oneOffIdentityPartyGender == null) {
    return null;
  }
  return enums.OneOffIdentityPartyGender.values.firstWhereOrNull(
        (e) => e.value == oneOffIdentityPartyGender,
      ) ??
      defaultValue;
}

String oneOffIdentityPartyGenderExplodedListToJson(
  List<enums.OneOffIdentityPartyGender>? oneOffIdentityPartyGender,
) {
  return oneOffIdentityPartyGender?.map((e) => e.value!).join(',') ?? '';
}

List<String> oneOffIdentityPartyGenderListToJson(
  List<enums.OneOffIdentityPartyGender>? oneOffIdentityPartyGender,
) {
  if (oneOffIdentityPartyGender == null) {
    return [];
  }

  return oneOffIdentityPartyGender.map((e) => e.value!).toList();
}

List<enums.OneOffIdentityPartyGender> oneOffIdentityPartyGenderListFromJson(
  List? oneOffIdentityPartyGender, [
  List<enums.OneOffIdentityPartyGender>? defaultValue,
]) {
  if (oneOffIdentityPartyGender == null) {
    return defaultValue ?? [];
  }

  return oneOffIdentityPartyGender
      .map((e) => oneOffIdentityPartyGenderFromJson(e.toString()))
      .toList();
}

List<enums.OneOffIdentityPartyGender>?
oneOffIdentityPartyGenderNullableListFromJson(
  List? oneOffIdentityPartyGender, [
  List<enums.OneOffIdentityPartyGender>? defaultValue,
]) {
  if (oneOffIdentityPartyGender == null) {
    return defaultValue;
  }

  return oneOffIdentityPartyGender
      .map((e) => oneOffIdentityPartyGenderFromJson(e.toString()))
      .toList();
}

String? oneOffVerifyNamePartySourceTypeNullableToJson(
  enums.OneOffVerifyNamePartySourceType? oneOffVerifyNamePartySourceType,
) {
  return oneOffVerifyNamePartySourceType?.value;
}

String? oneOffVerifyNamePartySourceTypeToJson(
  enums.OneOffVerifyNamePartySourceType oneOffVerifyNamePartySourceType,
) {
  return oneOffVerifyNamePartySourceType.value;
}

enums.OneOffVerifyNamePartySourceType oneOffVerifyNamePartySourceTypeFromJson(
  Object? oneOffVerifyNamePartySourceType, [
  enums.OneOffVerifyNamePartySourceType? defaultValue,
]) {
  return enums.OneOffVerifyNamePartySourceType.values.firstWhereOrNull(
        (e) => e.value == oneOffVerifyNamePartySourceType,
      ) ??
      defaultValue ??
      enums.OneOffVerifyNamePartySourceType.swaggerGeneratedUnknown;
}

enums.OneOffVerifyNamePartySourceType?
oneOffVerifyNamePartySourceTypeNullableFromJson(
  Object? oneOffVerifyNamePartySourceType, [
  enums.OneOffVerifyNamePartySourceType? defaultValue,
]) {
  if (oneOffVerifyNamePartySourceType == null) {
    return null;
  }
  return enums.OneOffVerifyNamePartySourceType.values.firstWhereOrNull(
        (e) => e.value == oneOffVerifyNamePartySourceType,
      ) ??
      defaultValue;
}

String oneOffVerifyNamePartySourceTypeExplodedListToJson(
  List<enums.OneOffVerifyNamePartySourceType>? oneOffVerifyNamePartySourceType,
) {
  return oneOffVerifyNamePartySourceType?.map((e) => e.value!).join(',') ?? '';
}

List<String> oneOffVerifyNamePartySourceTypeListToJson(
  List<enums.OneOffVerifyNamePartySourceType>? oneOffVerifyNamePartySourceType,
) {
  if (oneOffVerifyNamePartySourceType == null) {
    return [];
  }

  return oneOffVerifyNamePartySourceType.map((e) => e.value!).toList();
}

List<enums.OneOffVerifyNamePartySourceType>
oneOffVerifyNamePartySourceTypeListFromJson(
  List? oneOffVerifyNamePartySourceType, [
  List<enums.OneOffVerifyNamePartySourceType>? defaultValue,
]) {
  if (oneOffVerifyNamePartySourceType == null) {
    return defaultValue ?? [];
  }

  return oneOffVerifyNamePartySourceType
      .map((e) => oneOffVerifyNamePartySourceTypeFromJson(e.toString()))
      .toList();
}

List<enums.OneOffVerifyNamePartySourceType>?
oneOffVerifyNamePartySourceTypeNullableListFromJson(
  List? oneOffVerifyNamePartySourceType, [
  List<enums.OneOffVerifyNamePartySourceType>? defaultValue,
]) {
  if (oneOffVerifyNamePartySourceType == null) {
    return defaultValue;
  }

  return oneOffVerifyNamePartySourceType
      .map((e) => oneOffVerifyNamePartySourceTypeFromJson(e.toString()))
      .toList();
}

String? oneOffVerifyNameHolderSourceTypeNullableToJson(
  enums.OneOffVerifyNameHolderSourceType? oneOffVerifyNameHolderSourceType,
) {
  return oneOffVerifyNameHolderSourceType?.value;
}

String? oneOffVerifyNameHolderSourceTypeToJson(
  enums.OneOffVerifyNameHolderSourceType oneOffVerifyNameHolderSourceType,
) {
  return oneOffVerifyNameHolderSourceType.value;
}

enums.OneOffVerifyNameHolderSourceType oneOffVerifyNameHolderSourceTypeFromJson(
  Object? oneOffVerifyNameHolderSourceType, [
  enums.OneOffVerifyNameHolderSourceType? defaultValue,
]) {
  return enums.OneOffVerifyNameHolderSourceType.values.firstWhereOrNull(
        (e) => e.value == oneOffVerifyNameHolderSourceType,
      ) ??
      defaultValue ??
      enums.OneOffVerifyNameHolderSourceType.swaggerGeneratedUnknown;
}

enums.OneOffVerifyNameHolderSourceType?
oneOffVerifyNameHolderSourceTypeNullableFromJson(
  Object? oneOffVerifyNameHolderSourceType, [
  enums.OneOffVerifyNameHolderSourceType? defaultValue,
]) {
  if (oneOffVerifyNameHolderSourceType == null) {
    return null;
  }
  return enums.OneOffVerifyNameHolderSourceType.values.firstWhereOrNull(
        (e) => e.value == oneOffVerifyNameHolderSourceType,
      ) ??
      defaultValue;
}

String oneOffVerifyNameHolderSourceTypeExplodedListToJson(
  List<enums.OneOffVerifyNameHolderSourceType>?
  oneOffVerifyNameHolderSourceType,
) {
  return oneOffVerifyNameHolderSourceType?.map((e) => e.value!).join(',') ?? '';
}

List<String> oneOffVerifyNameHolderSourceTypeListToJson(
  List<enums.OneOffVerifyNameHolderSourceType>?
  oneOffVerifyNameHolderSourceType,
) {
  if (oneOffVerifyNameHolderSourceType == null) {
    return [];
  }

  return oneOffVerifyNameHolderSourceType.map((e) => e.value!).toList();
}

List<enums.OneOffVerifyNameHolderSourceType>
oneOffVerifyNameHolderSourceTypeListFromJson(
  List? oneOffVerifyNameHolderSourceType, [
  List<enums.OneOffVerifyNameHolderSourceType>? defaultValue,
]) {
  if (oneOffVerifyNameHolderSourceType == null) {
    return defaultValue ?? [];
  }

  return oneOffVerifyNameHolderSourceType
      .map((e) => oneOffVerifyNameHolderSourceTypeFromJson(e.toString()))
      .toList();
}

List<enums.OneOffVerifyNameHolderSourceType>?
oneOffVerifyNameHolderSourceTypeNullableListFromJson(
  List? oneOffVerifyNameHolderSourceType, [
  List<enums.OneOffVerifyNameHolderSourceType>? defaultValue,
]) {
  if (oneOffVerifyNameHolderSourceType == null) {
    return defaultValue;
  }

  return oneOffVerifyNameHolderSourceType
      .map((e) => oneOffVerifyNameHolderSourceTypeFromJson(e.toString()))
      .toList();
}

String? transactionTypeNullableToJson(enums.TransactionType? transactionType) {
  return transactionType?.value;
}

String? transactionTypeToJson(enums.TransactionType transactionType) {
  return transactionType.value;
}

enums.TransactionType transactionTypeFromJson(
  Object? transactionType, [
  enums.TransactionType? defaultValue,
]) {
  return enums.TransactionType.values.firstWhereOrNull(
        (e) => e.value == transactionType,
      ) ??
      defaultValue ??
      enums.TransactionType.swaggerGeneratedUnknown;
}

enums.TransactionType? transactionTypeNullableFromJson(
  Object? transactionType, [
  enums.TransactionType? defaultValue,
]) {
  if (transactionType == null) {
    return null;
  }
  return enums.TransactionType.values.firstWhereOrNull(
        (e) => e.value == transactionType,
      ) ??
      defaultValue;
}

String transactionTypeExplodedListToJson(
  List<enums.TransactionType>? transactionType,
) {
  return transactionType?.map((e) => e.value!).join(',') ?? '';
}

List<String> transactionTypeListToJson(
  List<enums.TransactionType>? transactionType,
) {
  if (transactionType == null) {
    return [];
  }

  return transactionType.map((e) => e.value!).toList();
}

List<enums.TransactionType> transactionTypeListFromJson(
  List? transactionType, [
  List<enums.TransactionType>? defaultValue,
]) {
  if (transactionType == null) {
    return defaultValue ?? [];
  }

  return transactionType
      .map((e) => transactionTypeFromJson(e.toString()))
      .toList();
}

List<enums.TransactionType>? transactionTypeNullableListFromJson(
  List? transactionType, [
  List<enums.TransactionType>? defaultValue,
]) {
  if (transactionType == null) {
    return defaultValue;
  }

  return transactionType
      .map((e) => transactionTypeFromJson(e.toString()))
      .toList();
}

String? paymentStatusNullableToJson(enums.PaymentStatus? paymentStatus) {
  return paymentStatus?.value;
}

String? paymentStatusToJson(enums.PaymentStatus paymentStatus) {
  return paymentStatus.value;
}

enums.PaymentStatus paymentStatusFromJson(
  Object? paymentStatus, [
  enums.PaymentStatus? defaultValue,
]) {
  return enums.PaymentStatus.values.firstWhereOrNull(
        (e) => e.value == paymentStatus,
      ) ??
      defaultValue ??
      enums.PaymentStatus.swaggerGeneratedUnknown;
}

enums.PaymentStatus? paymentStatusNullableFromJson(
  Object? paymentStatus, [
  enums.PaymentStatus? defaultValue,
]) {
  if (paymentStatus == null) {
    return null;
  }
  return enums.PaymentStatus.values.firstWhereOrNull(
        (e) => e.value == paymentStatus,
      ) ??
      defaultValue;
}

String paymentStatusExplodedListToJson(
  List<enums.PaymentStatus>? paymentStatus,
) {
  return paymentStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> paymentStatusListToJson(List<enums.PaymentStatus>? paymentStatus) {
  if (paymentStatus == null) {
    return [];
  }

  return paymentStatus.map((e) => e.value!).toList();
}

List<enums.PaymentStatus> paymentStatusListFromJson(
  List? paymentStatus, [
  List<enums.PaymentStatus>? defaultValue,
]) {
  if (paymentStatus == null) {
    return defaultValue ?? [];
  }

  return paymentStatus.map((e) => paymentStatusFromJson(e.toString())).toList();
}

List<enums.PaymentStatus>? paymentStatusNullableListFromJson(
  List? paymentStatus, [
  List<enums.PaymentStatus>? defaultValue,
]) {
  if (paymentStatus == null) {
    return defaultValue;
  }

  return paymentStatus.map((e) => paymentStatusFromJson(e.toString())).toList();
}

String? partyTypeNullableToJson(enums.PartyType? partyType) {
  return partyType?.value;
}

String? partyTypeToJson(enums.PartyType partyType) {
  return partyType.value;
}

enums.PartyType partyTypeFromJson(
  Object? partyType, [
  enums.PartyType? defaultValue,
]) {
  return enums.PartyType.values.firstWhereOrNull((e) => e.value == partyType) ??
      defaultValue ??
      enums.PartyType.swaggerGeneratedUnknown;
}

enums.PartyType? partyTypeNullableFromJson(
  Object? partyType, [
  enums.PartyType? defaultValue,
]) {
  if (partyType == null) {
    return null;
  }
  return enums.PartyType.values.firstWhereOrNull((e) => e.value == partyType) ??
      defaultValue;
}

String partyTypeExplodedListToJson(List<enums.PartyType>? partyType) {
  return partyType?.map((e) => e.value!).join(',') ?? '';
}

List<String> partyTypeListToJson(List<enums.PartyType>? partyType) {
  if (partyType == null) {
    return [];
  }

  return partyType.map((e) => e.value!).toList();
}

List<enums.PartyType> partyTypeListFromJson(
  List? partyType, [
  List<enums.PartyType>? defaultValue,
]) {
  if (partyType == null) {
    return defaultValue ?? [];
  }

  return partyType.map((e) => partyTypeFromJson(e.toString())).toList();
}

List<enums.PartyType>? partyTypeNullableListFromJson(
  List? partyType, [
  List<enums.PartyType>? defaultValue,
]) {
  if (partyType == null) {
    return defaultValue;
  }

  return partyType.map((e) => partyTypeFromJson(e.toString())).toList();
}

String? party$PhoneNumbers$ItemSubtypeNullableToJson(
  enums.Party$PhoneNumbers$ItemSubtype? party$PhoneNumbers$ItemSubtype,
) {
  return party$PhoneNumbers$ItemSubtype?.value;
}

String? party$PhoneNumbers$ItemSubtypeToJson(
  enums.Party$PhoneNumbers$ItemSubtype party$PhoneNumbers$ItemSubtype,
) {
  return party$PhoneNumbers$ItemSubtype.value;
}

enums.Party$PhoneNumbers$ItemSubtype party$PhoneNumbers$ItemSubtypeFromJson(
  Object? party$PhoneNumbers$ItemSubtype, [
  enums.Party$PhoneNumbers$ItemSubtype? defaultValue,
]) {
  return enums.Party$PhoneNumbers$ItemSubtype.values.firstWhereOrNull(
        (e) => e.value == party$PhoneNumbers$ItemSubtype,
      ) ??
      defaultValue ??
      enums.Party$PhoneNumbers$ItemSubtype.swaggerGeneratedUnknown;
}

enums.Party$PhoneNumbers$ItemSubtype?
party$PhoneNumbers$ItemSubtypeNullableFromJson(
  Object? party$PhoneNumbers$ItemSubtype, [
  enums.Party$PhoneNumbers$ItemSubtype? defaultValue,
]) {
  if (party$PhoneNumbers$ItemSubtype == null) {
    return null;
  }
  return enums.Party$PhoneNumbers$ItemSubtype.values.firstWhereOrNull(
        (e) => e.value == party$PhoneNumbers$ItemSubtype,
      ) ??
      defaultValue;
}

String party$PhoneNumbers$ItemSubtypeExplodedListToJson(
  List<enums.Party$PhoneNumbers$ItemSubtype>? party$PhoneNumbers$ItemSubtype,
) {
  return party$PhoneNumbers$ItemSubtype?.map((e) => e.value!).join(',') ?? '';
}

List<String> party$PhoneNumbers$ItemSubtypeListToJson(
  List<enums.Party$PhoneNumbers$ItemSubtype>? party$PhoneNumbers$ItemSubtype,
) {
  if (party$PhoneNumbers$ItemSubtype == null) {
    return [];
  }

  return party$PhoneNumbers$ItemSubtype.map((e) => e.value!).toList();
}

List<enums.Party$PhoneNumbers$ItemSubtype>
party$PhoneNumbers$ItemSubtypeListFromJson(
  List? party$PhoneNumbers$ItemSubtype, [
  List<enums.Party$PhoneNumbers$ItemSubtype>? defaultValue,
]) {
  if (party$PhoneNumbers$ItemSubtype == null) {
    return defaultValue ?? [];
  }

  return party$PhoneNumbers$ItemSubtype
      .map((e) => party$PhoneNumbers$ItemSubtypeFromJson(e.toString()))
      .toList();
}

List<enums.Party$PhoneNumbers$ItemSubtype>?
party$PhoneNumbers$ItemSubtypeNullableListFromJson(
  List? party$PhoneNumbers$ItemSubtype, [
  List<enums.Party$PhoneNumbers$ItemSubtype>? defaultValue,
]) {
  if (party$PhoneNumbers$ItemSubtype == null) {
    return defaultValue;
  }

  return party$PhoneNumbers$ItemSubtype
      .map((e) => party$PhoneNumbers$ItemSubtypeFromJson(e.toString()))
      .toList();
}

String? party$EmailAddresses$ItemSubtypeNullableToJson(
  enums.Party$EmailAddresses$ItemSubtype? party$EmailAddresses$ItemSubtype,
) {
  return party$EmailAddresses$ItemSubtype?.value;
}

String? party$EmailAddresses$ItemSubtypeToJson(
  enums.Party$EmailAddresses$ItemSubtype party$EmailAddresses$ItemSubtype,
) {
  return party$EmailAddresses$ItemSubtype.value;
}

enums.Party$EmailAddresses$ItemSubtype party$EmailAddresses$ItemSubtypeFromJson(
  Object? party$EmailAddresses$ItemSubtype, [
  enums.Party$EmailAddresses$ItemSubtype? defaultValue,
]) {
  return enums.Party$EmailAddresses$ItemSubtype.values.firstWhereOrNull(
        (e) => e.value == party$EmailAddresses$ItemSubtype,
      ) ??
      defaultValue ??
      enums.Party$EmailAddresses$ItemSubtype.swaggerGeneratedUnknown;
}

enums.Party$EmailAddresses$ItemSubtype?
party$EmailAddresses$ItemSubtypeNullableFromJson(
  Object? party$EmailAddresses$ItemSubtype, [
  enums.Party$EmailAddresses$ItemSubtype? defaultValue,
]) {
  if (party$EmailAddresses$ItemSubtype == null) {
    return null;
  }
  return enums.Party$EmailAddresses$ItemSubtype.values.firstWhereOrNull(
        (e) => e.value == party$EmailAddresses$ItemSubtype,
      ) ??
      defaultValue;
}

String party$EmailAddresses$ItemSubtypeExplodedListToJson(
  List<enums.Party$EmailAddresses$ItemSubtype>?
  party$EmailAddresses$ItemSubtype,
) {
  return party$EmailAddresses$ItemSubtype?.map((e) => e.value!).join(',') ?? '';
}

List<String> party$EmailAddresses$ItemSubtypeListToJson(
  List<enums.Party$EmailAddresses$ItemSubtype>?
  party$EmailAddresses$ItemSubtype,
) {
  if (party$EmailAddresses$ItemSubtype == null) {
    return [];
  }

  return party$EmailAddresses$ItemSubtype.map((e) => e.value!).toList();
}

List<enums.Party$EmailAddresses$ItemSubtype>
party$EmailAddresses$ItemSubtypeListFromJson(
  List? party$EmailAddresses$ItemSubtype, [
  List<enums.Party$EmailAddresses$ItemSubtype>? defaultValue,
]) {
  if (party$EmailAddresses$ItemSubtype == null) {
    return defaultValue ?? [];
  }

  return party$EmailAddresses$ItemSubtype
      .map((e) => party$EmailAddresses$ItemSubtypeFromJson(e.toString()))
      .toList();
}

List<enums.Party$EmailAddresses$ItemSubtype>?
party$EmailAddresses$ItemSubtypeNullableListFromJson(
  List? party$EmailAddresses$ItemSubtype, [
  List<enums.Party$EmailAddresses$ItemSubtype>? defaultValue,
]) {
  if (party$EmailAddresses$ItemSubtype == null) {
    return defaultValue;
  }

  return party$EmailAddresses$ItemSubtype
      .map((e) => party$EmailAddresses$ItemSubtypeFromJson(e.toString()))
      .toList();
}

String? webhookEventStatusNullableToJson(
  enums.WebhookEventStatus? webhookEventStatus,
) {
  return webhookEventStatus?.value;
}

String? webhookEventStatusToJson(enums.WebhookEventStatus webhookEventStatus) {
  return webhookEventStatus.value;
}

enums.WebhookEventStatus webhookEventStatusFromJson(
  Object? webhookEventStatus, [
  enums.WebhookEventStatus? defaultValue,
]) {
  return enums.WebhookEventStatus.values.firstWhereOrNull(
        (e) => e.value == webhookEventStatus,
      ) ??
      defaultValue ??
      enums.WebhookEventStatus.swaggerGeneratedUnknown;
}

enums.WebhookEventStatus? webhookEventStatusNullableFromJson(
  Object? webhookEventStatus, [
  enums.WebhookEventStatus? defaultValue,
]) {
  if (webhookEventStatus == null) {
    return null;
  }
  return enums.WebhookEventStatus.values.firstWhereOrNull(
        (e) => e.value == webhookEventStatus,
      ) ??
      defaultValue;
}

String webhookEventStatusExplodedListToJson(
  List<enums.WebhookEventStatus>? webhookEventStatus,
) {
  return webhookEventStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> webhookEventStatusListToJson(
  List<enums.WebhookEventStatus>? webhookEventStatus,
) {
  if (webhookEventStatus == null) {
    return [];
  }

  return webhookEventStatus.map((e) => e.value!).toList();
}

List<enums.WebhookEventStatus> webhookEventStatusListFromJson(
  List? webhookEventStatus, [
  List<enums.WebhookEventStatus>? defaultValue,
]) {
  if (webhookEventStatus == null) {
    return defaultValue ?? [];
  }

  return webhookEventStatus
      .map((e) => webhookEventStatusFromJson(e.toString()))
      .toList();
}

List<enums.WebhookEventStatus>? webhookEventStatusNullableListFromJson(
  List? webhookEventStatus, [
  List<enums.WebhookEventStatus>? defaultValue,
]) {
  if (webhookEventStatus == null) {
    return defaultValue;
  }

  return webhookEventStatus
      .map((e) => webhookEventStatusFromJson(e.toString()))
      .toList();
}

String? webhookEvent$PayloadWebhookTypeNullableToJson(
  enums.WebhookEvent$PayloadWebhookType? webhookEvent$PayloadWebhookType,
) {
  return webhookEvent$PayloadWebhookType?.value;
}

String? webhookEvent$PayloadWebhookTypeToJson(
  enums.WebhookEvent$PayloadWebhookType webhookEvent$PayloadWebhookType,
) {
  return webhookEvent$PayloadWebhookType.value;
}

enums.WebhookEvent$PayloadWebhookType webhookEvent$PayloadWebhookTypeFromJson(
  Object? webhookEvent$PayloadWebhookType, [
  enums.WebhookEvent$PayloadWebhookType? defaultValue,
]) {
  return enums.WebhookEvent$PayloadWebhookType.values.firstWhereOrNull(
        (e) => e.value == webhookEvent$PayloadWebhookType,
      ) ??
      defaultValue ??
      enums.WebhookEvent$PayloadWebhookType.swaggerGeneratedUnknown;
}

enums.WebhookEvent$PayloadWebhookType?
webhookEvent$PayloadWebhookTypeNullableFromJson(
  Object? webhookEvent$PayloadWebhookType, [
  enums.WebhookEvent$PayloadWebhookType? defaultValue,
]) {
  if (webhookEvent$PayloadWebhookType == null) {
    return null;
  }
  return enums.WebhookEvent$PayloadWebhookType.values.firstWhereOrNull(
        (e) => e.value == webhookEvent$PayloadWebhookType,
      ) ??
      defaultValue;
}

String webhookEvent$PayloadWebhookTypeExplodedListToJson(
  List<enums.WebhookEvent$PayloadWebhookType>? webhookEvent$PayloadWebhookType,
) {
  return webhookEvent$PayloadWebhookType?.map((e) => e.value!).join(',') ?? '';
}

List<String> webhookEvent$PayloadWebhookTypeListToJson(
  List<enums.WebhookEvent$PayloadWebhookType>? webhookEvent$PayloadWebhookType,
) {
  if (webhookEvent$PayloadWebhookType == null) {
    return [];
  }

  return webhookEvent$PayloadWebhookType.map((e) => e.value!).toList();
}

List<enums.WebhookEvent$PayloadWebhookType>
webhookEvent$PayloadWebhookTypeListFromJson(
  List? webhookEvent$PayloadWebhookType, [
  List<enums.WebhookEvent$PayloadWebhookType>? defaultValue,
]) {
  if (webhookEvent$PayloadWebhookType == null) {
    return defaultValue ?? [];
  }

  return webhookEvent$PayloadWebhookType
      .map((e) => webhookEvent$PayloadWebhookTypeFromJson(e.toString()))
      .toList();
}

List<enums.WebhookEvent$PayloadWebhookType>?
webhookEvent$PayloadWebhookTypeNullableListFromJson(
  List? webhookEvent$PayloadWebhookType, [
  List<enums.WebhookEvent$PayloadWebhookType>? defaultValue,
]) {
  if (webhookEvent$PayloadWebhookType == null) {
    return defaultValue;
  }

  return webhookEvent$PayloadWebhookType
      .map((e) => webhookEvent$PayloadWebhookTypeFromJson(e.toString()))
      .toList();
}

String? authorisationRequestSuccessResponseSuccessNullableToJson(
  enums.AuthorisationRequestSuccessResponseSuccess?
  authorisationRequestSuccessResponseSuccess,
) {
  return authorisationRequestSuccessResponseSuccess?.value;
}

String? authorisationRequestSuccessResponseSuccessToJson(
  enums.AuthorisationRequestSuccessResponseSuccess
  authorisationRequestSuccessResponseSuccess,
) {
  return authorisationRequestSuccessResponseSuccess.value;
}

enums.AuthorisationRequestSuccessResponseSuccess
authorisationRequestSuccessResponseSuccessFromJson(
  Object? authorisationRequestSuccessResponseSuccess, [
  enums.AuthorisationRequestSuccessResponseSuccess? defaultValue,
]) {
  return enums.AuthorisationRequestSuccessResponseSuccess.values
          .firstWhereOrNull(
            (e) => e.value == authorisationRequestSuccessResponseSuccess,
          ) ??
      defaultValue ??
      enums.AuthorisationRequestSuccessResponseSuccess.swaggerGeneratedUnknown;
}

enums.AuthorisationRequestSuccessResponseSuccess?
authorisationRequestSuccessResponseSuccessNullableFromJson(
  Object? authorisationRequestSuccessResponseSuccess, [
  enums.AuthorisationRequestSuccessResponseSuccess? defaultValue,
]) {
  if (authorisationRequestSuccessResponseSuccess == null) {
    return null;
  }
  return enums.AuthorisationRequestSuccessResponseSuccess.values
          .firstWhereOrNull(
            (e) => e.value == authorisationRequestSuccessResponseSuccess,
          ) ??
      defaultValue;
}

String authorisationRequestSuccessResponseSuccessExplodedListToJson(
  List<enums.AuthorisationRequestSuccessResponseSuccess>?
  authorisationRequestSuccessResponseSuccess,
) {
  return authorisationRequestSuccessResponseSuccess
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> authorisationRequestSuccessResponseSuccessListToJson(
  List<enums.AuthorisationRequestSuccessResponseSuccess>?
  authorisationRequestSuccessResponseSuccess,
) {
  if (authorisationRequestSuccessResponseSuccess == null) {
    return [];
  }

  return authorisationRequestSuccessResponseSuccess
      .map((e) => e.value!)
      .toList();
}

List<enums.AuthorisationRequestSuccessResponseSuccess>
authorisationRequestSuccessResponseSuccessListFromJson(
  List? authorisationRequestSuccessResponseSuccess, [
  List<enums.AuthorisationRequestSuccessResponseSuccess>? defaultValue,
]) {
  if (authorisationRequestSuccessResponseSuccess == null) {
    return defaultValue ?? [];
  }

  return authorisationRequestSuccessResponseSuccess
      .map(
        (e) => authorisationRequestSuccessResponseSuccessFromJson(e.toString()),
      )
      .toList();
}

List<enums.AuthorisationRequestSuccessResponseSuccess>?
authorisationRequestSuccessResponseSuccessNullableListFromJson(
  List? authorisationRequestSuccessResponseSuccess, [
  List<enums.AuthorisationRequestSuccessResponseSuccess>? defaultValue,
]) {
  if (authorisationRequestSuccessResponseSuccess == null) {
    return defaultValue;
  }

  return authorisationRequestSuccessResponseSuccess
      .map(
        (e) => authorisationRequestSuccessResponseSuccessFromJson(e.toString()),
      )
      .toList();
}

String? oAuth400ErrorCodeNullableToJson(
  enums.OAuth400ErrorCode? oAuth400ErrorCode,
) {
  return oAuth400ErrorCode?.value;
}

String? oAuth400ErrorCodeToJson(enums.OAuth400ErrorCode oAuth400ErrorCode) {
  return oAuth400ErrorCode.value;
}

enums.OAuth400ErrorCode oAuth400ErrorCodeFromJson(
  Object? oAuth400ErrorCode, [
  enums.OAuth400ErrorCode? defaultValue,
]) {
  return enums.OAuth400ErrorCode.values.firstWhereOrNull(
        (e) => e.value == oAuth400ErrorCode,
      ) ??
      defaultValue ??
      enums.OAuth400ErrorCode.swaggerGeneratedUnknown;
}

enums.OAuth400ErrorCode? oAuth400ErrorCodeNullableFromJson(
  Object? oAuth400ErrorCode, [
  enums.OAuth400ErrorCode? defaultValue,
]) {
  if (oAuth400ErrorCode == null) {
    return null;
  }
  return enums.OAuth400ErrorCode.values.firstWhereOrNull(
        (e) => e.value == oAuth400ErrorCode,
      ) ??
      defaultValue;
}

String oAuth400ErrorCodeExplodedListToJson(
  List<enums.OAuth400ErrorCode>? oAuth400ErrorCode,
) {
  return oAuth400ErrorCode?.map((e) => e.value!).join(',') ?? '';
}

List<String> oAuth400ErrorCodeListToJson(
  List<enums.OAuth400ErrorCode>? oAuth400ErrorCode,
) {
  if (oAuth400ErrorCode == null) {
    return [];
  }

  return oAuth400ErrorCode.map((e) => e.value!).toList();
}

List<enums.OAuth400ErrorCode> oAuth400ErrorCodeListFromJson(
  List? oAuth400ErrorCode, [
  List<enums.OAuth400ErrorCode>? defaultValue,
]) {
  if (oAuth400ErrorCode == null) {
    return defaultValue ?? [];
  }

  return oAuth400ErrorCode
      .map((e) => oAuth400ErrorCodeFromJson(e.toString()))
      .toList();
}

List<enums.OAuth400ErrorCode>? oAuth400ErrorCodeNullableListFromJson(
  List? oAuth400ErrorCode, [
  List<enums.OAuth400ErrorCode>? defaultValue,
]) {
  if (oAuth400ErrorCode == null) {
    return defaultValue;
  }

  return oAuth400ErrorCode
      .map((e) => oAuth400ErrorCodeFromJson(e.toString()))
      .toList();
}

String? createAuthorisationRequestIssueCodeNullableToJson(
  enums.CreateAuthorisationRequestIssueCode?
  createAuthorisationRequestIssueCode,
) {
  return createAuthorisationRequestIssueCode?.value;
}

String? createAuthorisationRequestIssueCodeToJson(
  enums.CreateAuthorisationRequestIssueCode createAuthorisationRequestIssueCode,
) {
  return createAuthorisationRequestIssueCode.value;
}

enums.CreateAuthorisationRequestIssueCode
createAuthorisationRequestIssueCodeFromJson(
  Object? createAuthorisationRequestIssueCode, [
  enums.CreateAuthorisationRequestIssueCode? defaultValue,
]) {
  return enums.CreateAuthorisationRequestIssueCode.values.firstWhereOrNull(
        (e) => e.value == createAuthorisationRequestIssueCode,
      ) ??
      defaultValue ??
      enums.CreateAuthorisationRequestIssueCode.swaggerGeneratedUnknown;
}

enums.CreateAuthorisationRequestIssueCode?
createAuthorisationRequestIssueCodeNullableFromJson(
  Object? createAuthorisationRequestIssueCode, [
  enums.CreateAuthorisationRequestIssueCode? defaultValue,
]) {
  if (createAuthorisationRequestIssueCode == null) {
    return null;
  }
  return enums.CreateAuthorisationRequestIssueCode.values.firstWhereOrNull(
        (e) => e.value == createAuthorisationRequestIssueCode,
      ) ??
      defaultValue;
}

String createAuthorisationRequestIssueCodeExplodedListToJson(
  List<enums.CreateAuthorisationRequestIssueCode>?
  createAuthorisationRequestIssueCode,
) {
  return createAuthorisationRequestIssueCode?.map((e) => e.value!).join(',') ??
      '';
}

List<String> createAuthorisationRequestIssueCodeListToJson(
  List<enums.CreateAuthorisationRequestIssueCode>?
  createAuthorisationRequestIssueCode,
) {
  if (createAuthorisationRequestIssueCode == null) {
    return [];
  }

  return createAuthorisationRequestIssueCode.map((e) => e.value!).toList();
}

List<enums.CreateAuthorisationRequestIssueCode>
createAuthorisationRequestIssueCodeListFromJson(
  List? createAuthorisationRequestIssueCode, [
  List<enums.CreateAuthorisationRequestIssueCode>? defaultValue,
]) {
  if (createAuthorisationRequestIssueCode == null) {
    return defaultValue ?? [];
  }

  return createAuthorisationRequestIssueCode
      .map((e) => createAuthorisationRequestIssueCodeFromJson(e.toString()))
      .toList();
}

List<enums.CreateAuthorisationRequestIssueCode>?
createAuthorisationRequestIssueCodeNullableListFromJson(
  List? createAuthorisationRequestIssueCode, [
  List<enums.CreateAuthorisationRequestIssueCode>? defaultValue,
]) {
  if (createAuthorisationRequestIssueCode == null) {
    return defaultValue;
  }

  return createAuthorisationRequestIssueCode
      .map((e) => createAuthorisationRequestIssueCodeFromJson(e.toString()))
      .toList();
}

String? createAuthorisationRequestInvalidRequestResponseSuccessNullableToJson(
  enums.CreateAuthorisationRequestInvalidRequestResponseSuccess?
  createAuthorisationRequestInvalidRequestResponseSuccess,
) {
  return createAuthorisationRequestInvalidRequestResponseSuccess?.value;
}

String? createAuthorisationRequestInvalidRequestResponseSuccessToJson(
  enums.CreateAuthorisationRequestInvalidRequestResponseSuccess
  createAuthorisationRequestInvalidRequestResponseSuccess,
) {
  return createAuthorisationRequestInvalidRequestResponseSuccess.value;
}

enums.CreateAuthorisationRequestInvalidRequestResponseSuccess
createAuthorisationRequestInvalidRequestResponseSuccessFromJson(
  Object? createAuthorisationRequestInvalidRequestResponseSuccess, [
  enums.CreateAuthorisationRequestInvalidRequestResponseSuccess? defaultValue,
]) {
  return enums.CreateAuthorisationRequestInvalidRequestResponseSuccess.values
          .firstWhereOrNull(
            (e) =>
                e.value ==
                createAuthorisationRequestInvalidRequestResponseSuccess,
          ) ??
      defaultValue ??
      enums
          .CreateAuthorisationRequestInvalidRequestResponseSuccess
          .swaggerGeneratedUnknown;
}

enums.CreateAuthorisationRequestInvalidRequestResponseSuccess?
createAuthorisationRequestInvalidRequestResponseSuccessNullableFromJson(
  Object? createAuthorisationRequestInvalidRequestResponseSuccess, [
  enums.CreateAuthorisationRequestInvalidRequestResponseSuccess? defaultValue,
]) {
  if (createAuthorisationRequestInvalidRequestResponseSuccess == null) {
    return null;
  }
  return enums.CreateAuthorisationRequestInvalidRequestResponseSuccess.values
          .firstWhereOrNull(
            (e) =>
                e.value ==
                createAuthorisationRequestInvalidRequestResponseSuccess,
          ) ??
      defaultValue;
}

String
createAuthorisationRequestInvalidRequestResponseSuccessExplodedListToJson(
  List<enums.CreateAuthorisationRequestInvalidRequestResponseSuccess>?
  createAuthorisationRequestInvalidRequestResponseSuccess,
) {
  return createAuthorisationRequestInvalidRequestResponseSuccess
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> createAuthorisationRequestInvalidRequestResponseSuccessListToJson(
  List<enums.CreateAuthorisationRequestInvalidRequestResponseSuccess>?
  createAuthorisationRequestInvalidRequestResponseSuccess,
) {
  if (createAuthorisationRequestInvalidRequestResponseSuccess == null) {
    return [];
  }

  return createAuthorisationRequestInvalidRequestResponseSuccess
      .map((e) => e.value!)
      .toList();
}

List<enums.CreateAuthorisationRequestInvalidRequestResponseSuccess>
createAuthorisationRequestInvalidRequestResponseSuccessListFromJson(
  List? createAuthorisationRequestInvalidRequestResponseSuccess, [
  List<enums.CreateAuthorisationRequestInvalidRequestResponseSuccess>?
  defaultValue,
]) {
  if (createAuthorisationRequestInvalidRequestResponseSuccess == null) {
    return defaultValue ?? [];
  }

  return createAuthorisationRequestInvalidRequestResponseSuccess
      .map(
        (e) => createAuthorisationRequestInvalidRequestResponseSuccessFromJson(
          e.toString(),
        ),
      )
      .toList();
}

List<enums.CreateAuthorisationRequestInvalidRequestResponseSuccess>?
createAuthorisationRequestInvalidRequestResponseSuccessNullableListFromJson(
  List? createAuthorisationRequestInvalidRequestResponseSuccess, [
  List<enums.CreateAuthorisationRequestInvalidRequestResponseSuccess>?
  defaultValue,
]) {
  if (createAuthorisationRequestInvalidRequestResponseSuccess == null) {
    return defaultValue;
  }

  return createAuthorisationRequestInvalidRequestResponseSuccess
      .map(
        (e) => createAuthorisationRequestInvalidRequestResponseSuccessFromJson(
          e.toString(),
        ),
      )
      .toList();
}

String? oAuth401ErrorCodeNullableToJson(
  enums.OAuth401ErrorCode? oAuth401ErrorCode,
) {
  return oAuth401ErrorCode?.value;
}

String? oAuth401ErrorCodeToJson(enums.OAuth401ErrorCode oAuth401ErrorCode) {
  return oAuth401ErrorCode.value;
}

enums.OAuth401ErrorCode oAuth401ErrorCodeFromJson(
  Object? oAuth401ErrorCode, [
  enums.OAuth401ErrorCode? defaultValue,
]) {
  return enums.OAuth401ErrorCode.values.firstWhereOrNull(
        (e) => e.value == oAuth401ErrorCode,
      ) ??
      defaultValue ??
      enums.OAuth401ErrorCode.swaggerGeneratedUnknown;
}

enums.OAuth401ErrorCode? oAuth401ErrorCodeNullableFromJson(
  Object? oAuth401ErrorCode, [
  enums.OAuth401ErrorCode? defaultValue,
]) {
  if (oAuth401ErrorCode == null) {
    return null;
  }
  return enums.OAuth401ErrorCode.values.firstWhereOrNull(
        (e) => e.value == oAuth401ErrorCode,
      ) ??
      defaultValue;
}

String oAuth401ErrorCodeExplodedListToJson(
  List<enums.OAuth401ErrorCode>? oAuth401ErrorCode,
) {
  return oAuth401ErrorCode?.map((e) => e.value!).join(',') ?? '';
}

List<String> oAuth401ErrorCodeListToJson(
  List<enums.OAuth401ErrorCode>? oAuth401ErrorCode,
) {
  if (oAuth401ErrorCode == null) {
    return [];
  }

  return oAuth401ErrorCode.map((e) => e.value!).toList();
}

List<enums.OAuth401ErrorCode> oAuth401ErrorCodeListFromJson(
  List? oAuth401ErrorCode, [
  List<enums.OAuth401ErrorCode>? defaultValue,
]) {
  if (oAuth401ErrorCode == null) {
    return defaultValue ?? [];
  }

  return oAuth401ErrorCode
      .map((e) => oAuth401ErrorCodeFromJson(e.toString()))
      .toList();
}

List<enums.OAuth401ErrorCode>? oAuth401ErrorCodeNullableListFromJson(
  List? oAuth401ErrorCode, [
  List<enums.OAuth401ErrorCode>? defaultValue,
]) {
  if (oAuth401ErrorCode == null) {
    return defaultValue;
  }

  return oAuth401ErrorCode
      .map((e) => oAuth401ErrorCodeFromJson(e.toString()))
      .toList();
}

String? oAuthUnauthorizedResponseSuccessNullableToJson(
  enums.OAuthUnauthorizedResponseSuccess? oAuthUnauthorizedResponseSuccess,
) {
  return oAuthUnauthorizedResponseSuccess?.value;
}

String? oAuthUnauthorizedResponseSuccessToJson(
  enums.OAuthUnauthorizedResponseSuccess oAuthUnauthorizedResponseSuccess,
) {
  return oAuthUnauthorizedResponseSuccess.value;
}

enums.OAuthUnauthorizedResponseSuccess oAuthUnauthorizedResponseSuccessFromJson(
  Object? oAuthUnauthorizedResponseSuccess, [
  enums.OAuthUnauthorizedResponseSuccess? defaultValue,
]) {
  return enums.OAuthUnauthorizedResponseSuccess.values.firstWhereOrNull(
        (e) => e.value == oAuthUnauthorizedResponseSuccess,
      ) ??
      defaultValue ??
      enums.OAuthUnauthorizedResponseSuccess.swaggerGeneratedUnknown;
}

enums.OAuthUnauthorizedResponseSuccess?
oAuthUnauthorizedResponseSuccessNullableFromJson(
  Object? oAuthUnauthorizedResponseSuccess, [
  enums.OAuthUnauthorizedResponseSuccess? defaultValue,
]) {
  if (oAuthUnauthorizedResponseSuccess == null) {
    return null;
  }
  return enums.OAuthUnauthorizedResponseSuccess.values.firstWhereOrNull(
        (e) => e.value == oAuthUnauthorizedResponseSuccess,
      ) ??
      defaultValue;
}

String oAuthUnauthorizedResponseSuccessExplodedListToJson(
  List<enums.OAuthUnauthorizedResponseSuccess>?
  oAuthUnauthorizedResponseSuccess,
) {
  return oAuthUnauthorizedResponseSuccess?.map((e) => e.value!).join(',') ?? '';
}

List<String> oAuthUnauthorizedResponseSuccessListToJson(
  List<enums.OAuthUnauthorizedResponseSuccess>?
  oAuthUnauthorizedResponseSuccess,
) {
  if (oAuthUnauthorizedResponseSuccess == null) {
    return [];
  }

  return oAuthUnauthorizedResponseSuccess.map((e) => e.value!).toList();
}

List<enums.OAuthUnauthorizedResponseSuccess>
oAuthUnauthorizedResponseSuccessListFromJson(
  List? oAuthUnauthorizedResponseSuccess, [
  List<enums.OAuthUnauthorizedResponseSuccess>? defaultValue,
]) {
  if (oAuthUnauthorizedResponseSuccess == null) {
    return defaultValue ?? [];
  }

  return oAuthUnauthorizedResponseSuccess
      .map((e) => oAuthUnauthorizedResponseSuccessFromJson(e.toString()))
      .toList();
}

List<enums.OAuthUnauthorizedResponseSuccess>?
oAuthUnauthorizedResponseSuccessNullableListFromJson(
  List? oAuthUnauthorizedResponseSuccess, [
  List<enums.OAuthUnauthorizedResponseSuccess>? defaultValue,
]) {
  if (oAuthUnauthorizedResponseSuccess == null) {
    return defaultValue;
  }

  return oAuthUnauthorizedResponseSuccess
      .map((e) => oAuthUnauthorizedResponseSuccessFromJson(e.toString()))
      .toList();
}

String? oAuth500ErrorCodeNullableToJson(
  enums.OAuth500ErrorCode? oAuth500ErrorCode,
) {
  return oAuth500ErrorCode?.value;
}

String? oAuth500ErrorCodeToJson(enums.OAuth500ErrorCode oAuth500ErrorCode) {
  return oAuth500ErrorCode.value;
}

enums.OAuth500ErrorCode oAuth500ErrorCodeFromJson(
  Object? oAuth500ErrorCode, [
  enums.OAuth500ErrorCode? defaultValue,
]) {
  return enums.OAuth500ErrorCode.values.firstWhereOrNull(
        (e) => e.value == oAuth500ErrorCode,
      ) ??
      defaultValue ??
      enums.OAuth500ErrorCode.swaggerGeneratedUnknown;
}

enums.OAuth500ErrorCode? oAuth500ErrorCodeNullableFromJson(
  Object? oAuth500ErrorCode, [
  enums.OAuth500ErrorCode? defaultValue,
]) {
  if (oAuth500ErrorCode == null) {
    return null;
  }
  return enums.OAuth500ErrorCode.values.firstWhereOrNull(
        (e) => e.value == oAuth500ErrorCode,
      ) ??
      defaultValue;
}

String oAuth500ErrorCodeExplodedListToJson(
  List<enums.OAuth500ErrorCode>? oAuth500ErrorCode,
) {
  return oAuth500ErrorCode?.map((e) => e.value!).join(',') ?? '';
}

List<String> oAuth500ErrorCodeListToJson(
  List<enums.OAuth500ErrorCode>? oAuth500ErrorCode,
) {
  if (oAuth500ErrorCode == null) {
    return [];
  }

  return oAuth500ErrorCode.map((e) => e.value!).toList();
}

List<enums.OAuth500ErrorCode> oAuth500ErrorCodeListFromJson(
  List? oAuth500ErrorCode, [
  List<enums.OAuth500ErrorCode>? defaultValue,
]) {
  if (oAuth500ErrorCode == null) {
    return defaultValue ?? [];
  }

  return oAuth500ErrorCode
      .map((e) => oAuth500ErrorCodeFromJson(e.toString()))
      .toList();
}

List<enums.OAuth500ErrorCode>? oAuth500ErrorCodeNullableListFromJson(
  List? oAuth500ErrorCode, [
  List<enums.OAuth500ErrorCode>? defaultValue,
]) {
  if (oAuth500ErrorCode == null) {
    return defaultValue;
  }

  return oAuth500ErrorCode
      .map((e) => oAuth500ErrorCodeFromJson(e.toString()))
      .toList();
}

String? oAuthInternalServerErrorResponseSuccessNullableToJson(
  enums.OAuthInternalServerErrorResponseSuccess?
  oAuthInternalServerErrorResponseSuccess,
) {
  return oAuthInternalServerErrorResponseSuccess?.value;
}

String? oAuthInternalServerErrorResponseSuccessToJson(
  enums.OAuthInternalServerErrorResponseSuccess
  oAuthInternalServerErrorResponseSuccess,
) {
  return oAuthInternalServerErrorResponseSuccess.value;
}

enums.OAuthInternalServerErrorResponseSuccess
oAuthInternalServerErrorResponseSuccessFromJson(
  Object? oAuthInternalServerErrorResponseSuccess, [
  enums.OAuthInternalServerErrorResponseSuccess? defaultValue,
]) {
  return enums.OAuthInternalServerErrorResponseSuccess.values.firstWhereOrNull(
        (e) => e.value == oAuthInternalServerErrorResponseSuccess,
      ) ??
      defaultValue ??
      enums.OAuthInternalServerErrorResponseSuccess.swaggerGeneratedUnknown;
}

enums.OAuthInternalServerErrorResponseSuccess?
oAuthInternalServerErrorResponseSuccessNullableFromJson(
  Object? oAuthInternalServerErrorResponseSuccess, [
  enums.OAuthInternalServerErrorResponseSuccess? defaultValue,
]) {
  if (oAuthInternalServerErrorResponseSuccess == null) {
    return null;
  }
  return enums.OAuthInternalServerErrorResponseSuccess.values.firstWhereOrNull(
        (e) => e.value == oAuthInternalServerErrorResponseSuccess,
      ) ??
      defaultValue;
}

String oAuthInternalServerErrorResponseSuccessExplodedListToJson(
  List<enums.OAuthInternalServerErrorResponseSuccess>?
  oAuthInternalServerErrorResponseSuccess,
) {
  return oAuthInternalServerErrorResponseSuccess
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> oAuthInternalServerErrorResponseSuccessListToJson(
  List<enums.OAuthInternalServerErrorResponseSuccess>?
  oAuthInternalServerErrorResponseSuccess,
) {
  if (oAuthInternalServerErrorResponseSuccess == null) {
    return [];
  }

  return oAuthInternalServerErrorResponseSuccess.map((e) => e.value!).toList();
}

List<enums.OAuthInternalServerErrorResponseSuccess>
oAuthInternalServerErrorResponseSuccessListFromJson(
  List? oAuthInternalServerErrorResponseSuccess, [
  List<enums.OAuthInternalServerErrorResponseSuccess>? defaultValue,
]) {
  if (oAuthInternalServerErrorResponseSuccess == null) {
    return defaultValue ?? [];
  }

  return oAuthInternalServerErrorResponseSuccess
      .map((e) => oAuthInternalServerErrorResponseSuccessFromJson(e.toString()))
      .toList();
}

List<enums.OAuthInternalServerErrorResponseSuccess>?
oAuthInternalServerErrorResponseSuccessNullableListFromJson(
  List? oAuthInternalServerErrorResponseSuccess, [
  List<enums.OAuthInternalServerErrorResponseSuccess>? defaultValue,
]) {
  if (oAuthInternalServerErrorResponseSuccess == null) {
    return defaultValue;
  }

  return oAuthInternalServerErrorResponseSuccess
      .map((e) => oAuthInternalServerErrorResponseSuccessFromJson(e.toString()))
      .toList();
}

String? connectionStubNullableToJson(enums.ConnectionStub? connectionStub) {
  return connectionStub?.value;
}

String? connectionStubToJson(enums.ConnectionStub connectionStub) {
  return connectionStub.value;
}

enums.ConnectionStub connectionStubFromJson(
  Object? connectionStub, [
  enums.ConnectionStub? defaultValue,
]) {
  return enums.ConnectionStub.values.firstWhereOrNull(
        (e) => e.value == connectionStub,
      ) ??
      defaultValue ??
      enums.ConnectionStub.swaggerGeneratedUnknown;
}

enums.ConnectionStub? connectionStubNullableFromJson(
  Object? connectionStub, [
  enums.ConnectionStub? defaultValue,
]) {
  if (connectionStub == null) {
    return null;
  }
  return enums.ConnectionStub.values.firstWhereOrNull(
        (e) => e.value == connectionStub,
      ) ??
      defaultValue;
}

String connectionStubExplodedListToJson(
  List<enums.ConnectionStub>? connectionStub,
) {
  return connectionStub?.map((e) => e.value!).join(',') ?? '';
}

List<String> connectionStubListToJson(
  List<enums.ConnectionStub>? connectionStub,
) {
  if (connectionStub == null) {
    return [];
  }

  return connectionStub.map((e) => e.value!).toList();
}

List<enums.ConnectionStub> connectionStubListFromJson(
  List? connectionStub, [
  List<enums.ConnectionStub>? defaultValue,
]) {
  if (connectionStub == null) {
    return defaultValue ?? [];
  }

  return connectionStub
      .map((e) => connectionStubFromJson(e.toString()))
      .toList();
}

List<enums.ConnectionStub>? connectionStubNullableListFromJson(
  List? connectionStub, [
  List<enums.ConnectionStub>? defaultValue,
]) {
  if (connectionStub == null) {
    return defaultValue;
  }

  return connectionStub
      .map((e) => connectionStubFromJson(e.toString()))
      .toList();
}

String? enduringAccessScopeNullableToJson(
  enums.EnduringAccessScope? enduringAccessScope,
) {
  return enduringAccessScope?.value;
}

String? enduringAccessScopeToJson(
  enums.EnduringAccessScope enduringAccessScope,
) {
  return enduringAccessScope.value;
}

enums.EnduringAccessScope enduringAccessScopeFromJson(
  Object? enduringAccessScope, [
  enums.EnduringAccessScope? defaultValue,
]) {
  return enums.EnduringAccessScope.values.firstWhereOrNull(
        (e) => e.value == enduringAccessScope,
      ) ??
      defaultValue ??
      enums.EnduringAccessScope.swaggerGeneratedUnknown;
}

enums.EnduringAccessScope? enduringAccessScopeNullableFromJson(
  Object? enduringAccessScope, [
  enums.EnduringAccessScope? defaultValue,
]) {
  if (enduringAccessScope == null) {
    return null;
  }
  return enums.EnduringAccessScope.values.firstWhereOrNull(
        (e) => e.value == enduringAccessScope,
      ) ??
      defaultValue;
}

String enduringAccessScopeExplodedListToJson(
  List<enums.EnduringAccessScope>? enduringAccessScope,
) {
  return enduringAccessScope?.map((e) => e.value!).join(',') ?? '';
}

List<String> enduringAccessScopeListToJson(
  List<enums.EnduringAccessScope>? enduringAccessScope,
) {
  if (enduringAccessScope == null) {
    return [];
  }

  return enduringAccessScope.map((e) => e.value!).toList();
}

List<enums.EnduringAccessScope> enduringAccessScopeListFromJson(
  List? enduringAccessScope, [
  List<enums.EnduringAccessScope>? defaultValue,
]) {
  if (enduringAccessScope == null) {
    return defaultValue ?? [];
  }

  return enduringAccessScope
      .map((e) => enduringAccessScopeFromJson(e.toString()))
      .toList();
}

List<enums.EnduringAccessScope>? enduringAccessScopeNullableListFromJson(
  List? enduringAccessScope, [
  List<enums.EnduringAccessScope>? defaultValue,
]) {
  if (enduringAccessScope == null) {
    return defaultValue;
  }

  return enduringAccessScope
      .map((e) => enduringAccessScopeFromJson(e.toString()))
      .toList();
}

String? enduringPaymentFrequencyNullableToJson(
  enums.EnduringPaymentFrequency? enduringPaymentFrequency,
) {
  return enduringPaymentFrequency?.value;
}

String? enduringPaymentFrequencyToJson(
  enums.EnduringPaymentFrequency enduringPaymentFrequency,
) {
  return enduringPaymentFrequency.value;
}

enums.EnduringPaymentFrequency enduringPaymentFrequencyFromJson(
  Object? enduringPaymentFrequency, [
  enums.EnduringPaymentFrequency? defaultValue,
]) {
  return enums.EnduringPaymentFrequency.values.firstWhereOrNull(
        (e) => e.value == enduringPaymentFrequency,
      ) ??
      defaultValue ??
      enums.EnduringPaymentFrequency.swaggerGeneratedUnknown;
}

enums.EnduringPaymentFrequency? enduringPaymentFrequencyNullableFromJson(
  Object? enduringPaymentFrequency, [
  enums.EnduringPaymentFrequency? defaultValue,
]) {
  if (enduringPaymentFrequency == null) {
    return null;
  }
  return enums.EnduringPaymentFrequency.values.firstWhereOrNull(
        (e) => e.value == enduringPaymentFrequency,
      ) ??
      defaultValue;
}

String enduringPaymentFrequencyExplodedListToJson(
  List<enums.EnduringPaymentFrequency>? enduringPaymentFrequency,
) {
  return enduringPaymentFrequency?.map((e) => e.value!).join(',') ?? '';
}

List<String> enduringPaymentFrequencyListToJson(
  List<enums.EnduringPaymentFrequency>? enduringPaymentFrequency,
) {
  if (enduringPaymentFrequency == null) {
    return [];
  }

  return enduringPaymentFrequency.map((e) => e.value!).toList();
}

List<enums.EnduringPaymentFrequency> enduringPaymentFrequencyListFromJson(
  List? enduringPaymentFrequency, [
  List<enums.EnduringPaymentFrequency>? defaultValue,
]) {
  if (enduringPaymentFrequency == null) {
    return defaultValue ?? [];
  }

  return enduringPaymentFrequency
      .map((e) => enduringPaymentFrequencyFromJson(e.toString()))
      .toList();
}

List<enums.EnduringPaymentFrequency>?
enduringPaymentFrequencyNullableListFromJson(
  List? enduringPaymentFrequency, [
  List<enums.EnduringPaymentFrequency>? defaultValue,
]) {
  if (enduringPaymentFrequency == null) {
    return defaultValue;
  }

  return enduringPaymentFrequency
      .map((e) => enduringPaymentFrequencyFromJson(e.toString()))
      .toList();
}

String? paymentConsentStaticPayeeInputSourceNullableToJson(
  enums.PaymentConsentStaticPayeeInputSource?
  paymentConsentStaticPayeeInputSource,
) {
  return paymentConsentStaticPayeeInputSource?.value;
}

String? paymentConsentStaticPayeeInputSourceToJson(
  enums.PaymentConsentStaticPayeeInputSource
  paymentConsentStaticPayeeInputSource,
) {
  return paymentConsentStaticPayeeInputSource.value;
}

enums.PaymentConsentStaticPayeeInputSource
paymentConsentStaticPayeeInputSourceFromJson(
  Object? paymentConsentStaticPayeeInputSource, [
  enums.PaymentConsentStaticPayeeInputSource? defaultValue,
]) {
  return enums.PaymentConsentStaticPayeeInputSource.values.firstWhereOrNull(
        (e) => e.value == paymentConsentStaticPayeeInputSource,
      ) ??
      defaultValue ??
      enums.PaymentConsentStaticPayeeInputSource.swaggerGeneratedUnknown;
}

enums.PaymentConsentStaticPayeeInputSource?
paymentConsentStaticPayeeInputSourceNullableFromJson(
  Object? paymentConsentStaticPayeeInputSource, [
  enums.PaymentConsentStaticPayeeInputSource? defaultValue,
]) {
  if (paymentConsentStaticPayeeInputSource == null) {
    return null;
  }
  return enums.PaymentConsentStaticPayeeInputSource.values.firstWhereOrNull(
        (e) => e.value == paymentConsentStaticPayeeInputSource,
      ) ??
      defaultValue;
}

String paymentConsentStaticPayeeInputSourceExplodedListToJson(
  List<enums.PaymentConsentStaticPayeeInputSource>?
  paymentConsentStaticPayeeInputSource,
) {
  return paymentConsentStaticPayeeInputSource?.map((e) => e.value!).join(',') ??
      '';
}

List<String> paymentConsentStaticPayeeInputSourceListToJson(
  List<enums.PaymentConsentStaticPayeeInputSource>?
  paymentConsentStaticPayeeInputSource,
) {
  if (paymentConsentStaticPayeeInputSource == null) {
    return [];
  }

  return paymentConsentStaticPayeeInputSource.map((e) => e.value!).toList();
}

List<enums.PaymentConsentStaticPayeeInputSource>
paymentConsentStaticPayeeInputSourceListFromJson(
  List? paymentConsentStaticPayeeInputSource, [
  List<enums.PaymentConsentStaticPayeeInputSource>? defaultValue,
]) {
  if (paymentConsentStaticPayeeInputSource == null) {
    return defaultValue ?? [];
  }

  return paymentConsentStaticPayeeInputSource
      .map((e) => paymentConsentStaticPayeeInputSourceFromJson(e.toString()))
      .toList();
}

List<enums.PaymentConsentStaticPayeeInputSource>?
paymentConsentStaticPayeeInputSourceNullableListFromJson(
  List? paymentConsentStaticPayeeInputSource, [
  List<enums.PaymentConsentStaticPayeeInputSource>? defaultValue,
]) {
  if (paymentConsentStaticPayeeInputSource == null) {
    return defaultValue;
  }

  return paymentConsentStaticPayeeInputSource
      .map((e) => paymentConsentStaticPayeeInputSourceFromJson(e.toString()))
      .toList();
}

String? paymentConsentRegisteredPayeeInputSourceNullableToJson(
  enums.PaymentConsentRegisteredPayeeInputSource?
  paymentConsentRegisteredPayeeInputSource,
) {
  return paymentConsentRegisteredPayeeInputSource?.value;
}

String? paymentConsentRegisteredPayeeInputSourceToJson(
  enums.PaymentConsentRegisteredPayeeInputSource
  paymentConsentRegisteredPayeeInputSource,
) {
  return paymentConsentRegisteredPayeeInputSource.value;
}

enums.PaymentConsentRegisteredPayeeInputSource
paymentConsentRegisteredPayeeInputSourceFromJson(
  Object? paymentConsentRegisteredPayeeInputSource, [
  enums.PaymentConsentRegisteredPayeeInputSource? defaultValue,
]) {
  return enums.PaymentConsentRegisteredPayeeInputSource.values.firstWhereOrNull(
        (e) => e.value == paymentConsentRegisteredPayeeInputSource,
      ) ??
      defaultValue ??
      enums.PaymentConsentRegisteredPayeeInputSource.swaggerGeneratedUnknown;
}

enums.PaymentConsentRegisteredPayeeInputSource?
paymentConsentRegisteredPayeeInputSourceNullableFromJson(
  Object? paymentConsentRegisteredPayeeInputSource, [
  enums.PaymentConsentRegisteredPayeeInputSource? defaultValue,
]) {
  if (paymentConsentRegisteredPayeeInputSource == null) {
    return null;
  }
  return enums.PaymentConsentRegisteredPayeeInputSource.values.firstWhereOrNull(
        (e) => e.value == paymentConsentRegisteredPayeeInputSource,
      ) ??
      defaultValue;
}

String paymentConsentRegisteredPayeeInputSourceExplodedListToJson(
  List<enums.PaymentConsentRegisteredPayeeInputSource>?
  paymentConsentRegisteredPayeeInputSource,
) {
  return paymentConsentRegisteredPayeeInputSource
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> paymentConsentRegisteredPayeeInputSourceListToJson(
  List<enums.PaymentConsentRegisteredPayeeInputSource>?
  paymentConsentRegisteredPayeeInputSource,
) {
  if (paymentConsentRegisteredPayeeInputSource == null) {
    return [];
  }

  return paymentConsentRegisteredPayeeInputSource.map((e) => e.value!).toList();
}

List<enums.PaymentConsentRegisteredPayeeInputSource>
paymentConsentRegisteredPayeeInputSourceListFromJson(
  List? paymentConsentRegisteredPayeeInputSource, [
  List<enums.PaymentConsentRegisteredPayeeInputSource>? defaultValue,
]) {
  if (paymentConsentRegisteredPayeeInputSource == null) {
    return defaultValue ?? [];
  }

  return paymentConsentRegisteredPayeeInputSource
      .map(
        (e) => paymentConsentRegisteredPayeeInputSourceFromJson(e.toString()),
      )
      .toList();
}

List<enums.PaymentConsentRegisteredPayeeInputSource>?
paymentConsentRegisteredPayeeInputSourceNullableListFromJson(
  List? paymentConsentRegisteredPayeeInputSource, [
  List<enums.PaymentConsentRegisteredPayeeInputSource>? defaultValue,
]) {
  if (paymentConsentRegisteredPayeeInputSource == null) {
    return defaultValue;
  }

  return paymentConsentRegisteredPayeeInputSource
      .map(
        (e) => paymentConsentRegisteredPayeeInputSourceFromJson(e.toString()),
      )
      .toList();
}

String? paymentConsentInlinePayeeInputNoneVerifiedSourceNullableToJson(
  enums.PaymentConsentInlinePayeeInputNoneVerifiedSource?
  paymentConsentInlinePayeeInputNoneVerifiedSource,
) {
  return paymentConsentInlinePayeeInputNoneVerifiedSource?.value;
}

String? paymentConsentInlinePayeeInputNoneVerifiedSourceToJson(
  enums.PaymentConsentInlinePayeeInputNoneVerifiedSource
  paymentConsentInlinePayeeInputNoneVerifiedSource,
) {
  return paymentConsentInlinePayeeInputNoneVerifiedSource.value;
}

enums.PaymentConsentInlinePayeeInputNoneVerifiedSource
paymentConsentInlinePayeeInputNoneVerifiedSourceFromJson(
  Object? paymentConsentInlinePayeeInputNoneVerifiedSource, [
  enums.PaymentConsentInlinePayeeInputNoneVerifiedSource? defaultValue,
]) {
  return enums.PaymentConsentInlinePayeeInputNoneVerifiedSource.values
          .firstWhereOrNull(
            (e) => e.value == paymentConsentInlinePayeeInputNoneVerifiedSource,
          ) ??
      defaultValue ??
      enums
          .PaymentConsentInlinePayeeInputNoneVerifiedSource
          .swaggerGeneratedUnknown;
}

enums.PaymentConsentInlinePayeeInputNoneVerifiedSource?
paymentConsentInlinePayeeInputNoneVerifiedSourceNullableFromJson(
  Object? paymentConsentInlinePayeeInputNoneVerifiedSource, [
  enums.PaymentConsentInlinePayeeInputNoneVerifiedSource? defaultValue,
]) {
  if (paymentConsentInlinePayeeInputNoneVerifiedSource == null) {
    return null;
  }
  return enums.PaymentConsentInlinePayeeInputNoneVerifiedSource.values
          .firstWhereOrNull(
            (e) => e.value == paymentConsentInlinePayeeInputNoneVerifiedSource,
          ) ??
      defaultValue;
}

String paymentConsentInlinePayeeInputNoneVerifiedSourceExplodedListToJson(
  List<enums.PaymentConsentInlinePayeeInputNoneVerifiedSource>?
  paymentConsentInlinePayeeInputNoneVerifiedSource,
) {
  return paymentConsentInlinePayeeInputNoneVerifiedSource
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> paymentConsentInlinePayeeInputNoneVerifiedSourceListToJson(
  List<enums.PaymentConsentInlinePayeeInputNoneVerifiedSource>?
  paymentConsentInlinePayeeInputNoneVerifiedSource,
) {
  if (paymentConsentInlinePayeeInputNoneVerifiedSource == null) {
    return [];
  }

  return paymentConsentInlinePayeeInputNoneVerifiedSource
      .map((e) => e.value!)
      .toList();
}

List<enums.PaymentConsentInlinePayeeInputNoneVerifiedSource>
paymentConsentInlinePayeeInputNoneVerifiedSourceListFromJson(
  List? paymentConsentInlinePayeeInputNoneVerifiedSource, [
  List<enums.PaymentConsentInlinePayeeInputNoneVerifiedSource>? defaultValue,
]) {
  if (paymentConsentInlinePayeeInputNoneVerifiedSource == null) {
    return defaultValue ?? [];
  }

  return paymentConsentInlinePayeeInputNoneVerifiedSource
      .map(
        (e) => paymentConsentInlinePayeeInputNoneVerifiedSourceFromJson(
          e.toString(),
        ),
      )
      .toList();
}

List<enums.PaymentConsentInlinePayeeInputNoneVerifiedSource>?
paymentConsentInlinePayeeInputNoneVerifiedSourceNullableListFromJson(
  List? paymentConsentInlinePayeeInputNoneVerifiedSource, [
  List<enums.PaymentConsentInlinePayeeInputNoneVerifiedSource>? defaultValue,
]) {
  if (paymentConsentInlinePayeeInputNoneVerifiedSource == null) {
    return defaultValue;
  }

  return paymentConsentInlinePayeeInputNoneVerifiedSource
      .map(
        (e) => paymentConsentInlinePayeeInputNoneVerifiedSourceFromJson(
          e.toString(),
        ),
      )
      .toList();
}

String?
paymentConsentInlinePayeeInputNoneVerifiedVerificationMethodNullableToJson(
  enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod?
  paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod,
) {
  return paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod?.value;
}

String? paymentConsentInlinePayeeInputNoneVerifiedVerificationMethodToJson(
  enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod
  paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod,
) {
  return paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod.value;
}

enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod
paymentConsentInlinePayeeInputNoneVerifiedVerificationMethodFromJson(
  Object? paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod, [
  enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod?
  defaultValue,
]) {
  return enums
          .PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod
          .values
          .firstWhereOrNull(
            (e) =>
                e.value ==
                paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod,
          ) ??
      defaultValue ??
      enums
          .PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod
          .swaggerGeneratedUnknown;
}

enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod?
paymentConsentInlinePayeeInputNoneVerifiedVerificationMethodNullableFromJson(
  Object? paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod, [
  enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod?
  defaultValue,
]) {
  if (paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod == null) {
    return null;
  }
  return enums
          .PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod
          .values
          .firstWhereOrNull(
            (e) =>
                e.value ==
                paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod,
          ) ??
      defaultValue;
}

String
paymentConsentInlinePayeeInputNoneVerifiedVerificationMethodExplodedListToJson(
  List<enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod>?
  paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod,
) {
  return paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String>
paymentConsentInlinePayeeInputNoneVerifiedVerificationMethodListToJson(
  List<enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod>?
  paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod,
) {
  if (paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod == null) {
    return [];
  }

  return paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod
      .map((e) => e.value!)
      .toList();
}

List<enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod>
paymentConsentInlinePayeeInputNoneVerifiedVerificationMethodListFromJson(
  List? paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod, [
  List<enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod>?
  defaultValue,
]) {
  if (paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod == null) {
    return defaultValue ?? [];
  }

  return paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod
      .map(
        (e) =>
            paymentConsentInlinePayeeInputNoneVerifiedVerificationMethodFromJson(
              e.toString(),
            ),
      )
      .toList();
}

List<enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod>?
paymentConsentInlinePayeeInputNoneVerifiedVerificationMethodNullableListFromJson(
  List? paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod, [
  List<enums.PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod>?
  defaultValue,
]) {
  if (paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod == null) {
    return defaultValue;
  }

  return paymentConsentInlinePayeeInputNoneVerifiedVerificationMethod
      .map(
        (e) =>
            paymentConsentInlinePayeeInputNoneVerifiedVerificationMethodFromJson(
              e.toString(),
            ),
      )
      .toList();
}

String? paymentConsentInlinePayeeInputClientVerifiedSourceNullableToJson(
  enums.PaymentConsentInlinePayeeInputClientVerifiedSource?
  paymentConsentInlinePayeeInputClientVerifiedSource,
) {
  return paymentConsentInlinePayeeInputClientVerifiedSource?.value;
}

String? paymentConsentInlinePayeeInputClientVerifiedSourceToJson(
  enums.PaymentConsentInlinePayeeInputClientVerifiedSource
  paymentConsentInlinePayeeInputClientVerifiedSource,
) {
  return paymentConsentInlinePayeeInputClientVerifiedSource.value;
}

enums.PaymentConsentInlinePayeeInputClientVerifiedSource
paymentConsentInlinePayeeInputClientVerifiedSourceFromJson(
  Object? paymentConsentInlinePayeeInputClientVerifiedSource, [
  enums.PaymentConsentInlinePayeeInputClientVerifiedSource? defaultValue,
]) {
  return enums.PaymentConsentInlinePayeeInputClientVerifiedSource.values
          .firstWhereOrNull(
            (e) =>
                e.value == paymentConsentInlinePayeeInputClientVerifiedSource,
          ) ??
      defaultValue ??
      enums
          .PaymentConsentInlinePayeeInputClientVerifiedSource
          .swaggerGeneratedUnknown;
}

enums.PaymentConsentInlinePayeeInputClientVerifiedSource?
paymentConsentInlinePayeeInputClientVerifiedSourceNullableFromJson(
  Object? paymentConsentInlinePayeeInputClientVerifiedSource, [
  enums.PaymentConsentInlinePayeeInputClientVerifiedSource? defaultValue,
]) {
  if (paymentConsentInlinePayeeInputClientVerifiedSource == null) {
    return null;
  }
  return enums.PaymentConsentInlinePayeeInputClientVerifiedSource.values
          .firstWhereOrNull(
            (e) =>
                e.value == paymentConsentInlinePayeeInputClientVerifiedSource,
          ) ??
      defaultValue;
}

String paymentConsentInlinePayeeInputClientVerifiedSourceExplodedListToJson(
  List<enums.PaymentConsentInlinePayeeInputClientVerifiedSource>?
  paymentConsentInlinePayeeInputClientVerifiedSource,
) {
  return paymentConsentInlinePayeeInputClientVerifiedSource
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> paymentConsentInlinePayeeInputClientVerifiedSourceListToJson(
  List<enums.PaymentConsentInlinePayeeInputClientVerifiedSource>?
  paymentConsentInlinePayeeInputClientVerifiedSource,
) {
  if (paymentConsentInlinePayeeInputClientVerifiedSource == null) {
    return [];
  }

  return paymentConsentInlinePayeeInputClientVerifiedSource
      .map((e) => e.value!)
      .toList();
}

List<enums.PaymentConsentInlinePayeeInputClientVerifiedSource>
paymentConsentInlinePayeeInputClientVerifiedSourceListFromJson(
  List? paymentConsentInlinePayeeInputClientVerifiedSource, [
  List<enums.PaymentConsentInlinePayeeInputClientVerifiedSource>? defaultValue,
]) {
  if (paymentConsentInlinePayeeInputClientVerifiedSource == null) {
    return defaultValue ?? [];
  }

  return paymentConsentInlinePayeeInputClientVerifiedSource
      .map(
        (e) => paymentConsentInlinePayeeInputClientVerifiedSourceFromJson(
          e.toString(),
        ),
      )
      .toList();
}

List<enums.PaymentConsentInlinePayeeInputClientVerifiedSource>?
paymentConsentInlinePayeeInputClientVerifiedSourceNullableListFromJson(
  List? paymentConsentInlinePayeeInputClientVerifiedSource, [
  List<enums.PaymentConsentInlinePayeeInputClientVerifiedSource>? defaultValue,
]) {
  if (paymentConsentInlinePayeeInputClientVerifiedSource == null) {
    return defaultValue;
  }

  return paymentConsentInlinePayeeInputClientVerifiedSource
      .map(
        (e) => paymentConsentInlinePayeeInputClientVerifiedSourceFromJson(
          e.toString(),
        ),
      )
      .toList();
}

String?
paymentConsentInlinePayeeInputClientVerifiedVerificationMethodNullableToJson(
  enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod?
  paymentConsentInlinePayeeInputClientVerifiedVerificationMethod,
) {
  return paymentConsentInlinePayeeInputClientVerifiedVerificationMethod?.value;
}

String? paymentConsentInlinePayeeInputClientVerifiedVerificationMethodToJson(
  enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod
  paymentConsentInlinePayeeInputClientVerifiedVerificationMethod,
) {
  return paymentConsentInlinePayeeInputClientVerifiedVerificationMethod.value;
}

enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod
paymentConsentInlinePayeeInputClientVerifiedVerificationMethodFromJson(
  Object? paymentConsentInlinePayeeInputClientVerifiedVerificationMethod, [
  enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod?
  defaultValue,
]) {
  return enums
          .PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod
          .values
          .firstWhereOrNull(
            (e) =>
                e.value ==
                paymentConsentInlinePayeeInputClientVerifiedVerificationMethod,
          ) ??
      defaultValue ??
      enums
          .PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod
          .swaggerGeneratedUnknown;
}

enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod?
paymentConsentInlinePayeeInputClientVerifiedVerificationMethodNullableFromJson(
  Object? paymentConsentInlinePayeeInputClientVerifiedVerificationMethod, [
  enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod?
  defaultValue,
]) {
  if (paymentConsentInlinePayeeInputClientVerifiedVerificationMethod == null) {
    return null;
  }
  return enums
          .PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod
          .values
          .firstWhereOrNull(
            (e) =>
                e.value ==
                paymentConsentInlinePayeeInputClientVerifiedVerificationMethod,
          ) ??
      defaultValue;
}

String
paymentConsentInlinePayeeInputClientVerifiedVerificationMethodExplodedListToJson(
  List<enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod>?
  paymentConsentInlinePayeeInputClientVerifiedVerificationMethod,
) {
  return paymentConsentInlinePayeeInputClientVerifiedVerificationMethod
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String>
paymentConsentInlinePayeeInputClientVerifiedVerificationMethodListToJson(
  List<enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod>?
  paymentConsentInlinePayeeInputClientVerifiedVerificationMethod,
) {
  if (paymentConsentInlinePayeeInputClientVerifiedVerificationMethod == null) {
    return [];
  }

  return paymentConsentInlinePayeeInputClientVerifiedVerificationMethod
      .map((e) => e.value!)
      .toList();
}

List<enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod>
paymentConsentInlinePayeeInputClientVerifiedVerificationMethodListFromJson(
  List? paymentConsentInlinePayeeInputClientVerifiedVerificationMethod, [
  List<enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod>?
  defaultValue,
]) {
  if (paymentConsentInlinePayeeInputClientVerifiedVerificationMethod == null) {
    return defaultValue ?? [];
  }

  return paymentConsentInlinePayeeInputClientVerifiedVerificationMethod
      .map(
        (e) =>
            paymentConsentInlinePayeeInputClientVerifiedVerificationMethodFromJson(
              e.toString(),
            ),
      )
      .toList();
}

List<enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod>?
paymentConsentInlinePayeeInputClientVerifiedVerificationMethodNullableListFromJson(
  List? paymentConsentInlinePayeeInputClientVerifiedVerificationMethod, [
  List<enums.PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod>?
  defaultValue,
]) {
  if (paymentConsentInlinePayeeInputClientVerifiedVerificationMethod == null) {
    return defaultValue;
  }

  return paymentConsentInlinePayeeInputClientVerifiedVerificationMethod
      .map(
        (e) =>
            paymentConsentInlinePayeeInputClientVerifiedVerificationMethodFromJson(
              e.toString(),
            ),
      )
      .toList();
}

String? paymentConsentInlinePayeeInputVerifiedVerifiedSourceNullableToJson(
  enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource?
  paymentConsentInlinePayeeInputVerifiedVerifiedSource,
) {
  return paymentConsentInlinePayeeInputVerifiedVerifiedSource?.value;
}

String? paymentConsentInlinePayeeInputVerifiedVerifiedSourceToJson(
  enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource
  paymentConsentInlinePayeeInputVerifiedVerifiedSource,
) {
  return paymentConsentInlinePayeeInputVerifiedVerifiedSource.value;
}

enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource
paymentConsentInlinePayeeInputVerifiedVerifiedSourceFromJson(
  Object? paymentConsentInlinePayeeInputVerifiedVerifiedSource, [
  enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource? defaultValue,
]) {
  return enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource.values
          .firstWhereOrNull(
            (e) =>
                e.value == paymentConsentInlinePayeeInputVerifiedVerifiedSource,
          ) ??
      defaultValue ??
      enums
          .PaymentConsentInlinePayeeInputVerifiedVerifiedSource
          .swaggerGeneratedUnknown;
}

enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource?
paymentConsentInlinePayeeInputVerifiedVerifiedSourceNullableFromJson(
  Object? paymentConsentInlinePayeeInputVerifiedVerifiedSource, [
  enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource? defaultValue,
]) {
  if (paymentConsentInlinePayeeInputVerifiedVerifiedSource == null) {
    return null;
  }
  return enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource.values
          .firstWhereOrNull(
            (e) =>
                e.value == paymentConsentInlinePayeeInputVerifiedVerifiedSource,
          ) ??
      defaultValue;
}

String paymentConsentInlinePayeeInputVerifiedVerifiedSourceExplodedListToJson(
  List<enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource>?
  paymentConsentInlinePayeeInputVerifiedVerifiedSource,
) {
  return paymentConsentInlinePayeeInputVerifiedVerifiedSource
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> paymentConsentInlinePayeeInputVerifiedVerifiedSourceListToJson(
  List<enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource>?
  paymentConsentInlinePayeeInputVerifiedVerifiedSource,
) {
  if (paymentConsentInlinePayeeInputVerifiedVerifiedSource == null) {
    return [];
  }

  return paymentConsentInlinePayeeInputVerifiedVerifiedSource
      .map((e) => e.value!)
      .toList();
}

List<enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource>
paymentConsentInlinePayeeInputVerifiedVerifiedSourceListFromJson(
  List? paymentConsentInlinePayeeInputVerifiedVerifiedSource, [
  List<enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource>?
  defaultValue,
]) {
  if (paymentConsentInlinePayeeInputVerifiedVerifiedSource == null) {
    return defaultValue ?? [];
  }

  return paymentConsentInlinePayeeInputVerifiedVerifiedSource
      .map(
        (e) => paymentConsentInlinePayeeInputVerifiedVerifiedSourceFromJson(
          e.toString(),
        ),
      )
      .toList();
}

List<enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource>?
paymentConsentInlinePayeeInputVerifiedVerifiedSourceNullableListFromJson(
  List? paymentConsentInlinePayeeInputVerifiedVerifiedSource, [
  List<enums.PaymentConsentInlinePayeeInputVerifiedVerifiedSource>?
  defaultValue,
]) {
  if (paymentConsentInlinePayeeInputVerifiedVerifiedSource == null) {
    return defaultValue;
  }

  return paymentConsentInlinePayeeInputVerifiedVerifiedSource
      .map(
        (e) => paymentConsentInlinePayeeInputVerifiedVerifiedSourceFromJson(
          e.toString(),
        ),
      )
      .toList();
}

String?
paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethodNullableToJson(
  enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod?
  paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod,
) {
  return paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod
      ?.value;
}

String? paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethodToJson(
  enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod
  paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod,
) {
  return paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod.value;
}

enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod
paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethodFromJson(
  Object? paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod, [
  enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod?
  defaultValue,
]) {
  return enums
          .PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod
          .values
          .firstWhereOrNull(
            (e) =>
                e.value ==
                paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod,
          ) ??
      defaultValue ??
      enums
          .PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod
          .swaggerGeneratedUnknown;
}

enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod?
paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethodNullableFromJson(
  Object? paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod, [
  enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod?
  defaultValue,
]) {
  if (paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod ==
      null) {
    return null;
  }
  return enums
          .PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod
          .values
          .firstWhereOrNull(
            (e) =>
                e.value ==
                paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod,
          ) ??
      defaultValue;
}

String
paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethodExplodedListToJson(
  List<enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod>?
  paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod,
) {
  return paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String>
paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethodListToJson(
  List<enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod>?
  paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod,
) {
  if (paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod ==
      null) {
    return [];
  }

  return paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod
      .map((e) => e.value!)
      .toList();
}

List<enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod>
paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethodListFromJson(
  List? paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod, [
  List<enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod>?
  defaultValue,
]) {
  if (paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod ==
      null) {
    return defaultValue ?? [];
  }

  return paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod
      .map(
        (e) =>
            paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethodFromJson(
              e.toString(),
            ),
      )
      .toList();
}

List<enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod>?
paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethodNullableListFromJson(
  List? paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod, [
  List<enums.PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod>?
  defaultValue,
]) {
  if (paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod ==
      null) {
    return defaultValue;
  }

  return paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod
      .map(
        (e) =>
            paymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethodFromJson(
              e.toString(),
            ),
      )
      .toList();
}

String? enduringAccessRequestTypeNullableToJson(
  enums.EnduringAccessRequestType? enduringAccessRequestType,
) {
  return enduringAccessRequestType?.value;
}

String? enduringAccessRequestTypeToJson(
  enums.EnduringAccessRequestType enduringAccessRequestType,
) {
  return enduringAccessRequestType.value;
}

enums.EnduringAccessRequestType enduringAccessRequestTypeFromJson(
  Object? enduringAccessRequestType, [
  enums.EnduringAccessRequestType? defaultValue,
]) {
  return enums.EnduringAccessRequestType.values.firstWhereOrNull(
        (e) => e.value == enduringAccessRequestType,
      ) ??
      defaultValue ??
      enums.EnduringAccessRequestType.swaggerGeneratedUnknown;
}

enums.EnduringAccessRequestType? enduringAccessRequestTypeNullableFromJson(
  Object? enduringAccessRequestType, [
  enums.EnduringAccessRequestType? defaultValue,
]) {
  if (enduringAccessRequestType == null) {
    return null;
  }
  return enums.EnduringAccessRequestType.values.firstWhereOrNull(
        (e) => e.value == enduringAccessRequestType,
      ) ??
      defaultValue;
}

String enduringAccessRequestTypeExplodedListToJson(
  List<enums.EnduringAccessRequestType>? enduringAccessRequestType,
) {
  return enduringAccessRequestType?.map((e) => e.value!).join(',') ?? '';
}

List<String> enduringAccessRequestTypeListToJson(
  List<enums.EnduringAccessRequestType>? enduringAccessRequestType,
) {
  if (enduringAccessRequestType == null) {
    return [];
  }

  return enduringAccessRequestType.map((e) => e.value!).toList();
}

List<enums.EnduringAccessRequestType> enduringAccessRequestTypeListFromJson(
  List? enduringAccessRequestType, [
  List<enums.EnduringAccessRequestType>? defaultValue,
]) {
  if (enduringAccessRequestType == null) {
    return defaultValue ?? [];
  }

  return enduringAccessRequestType
      .map((e) => enduringAccessRequestTypeFromJson(e.toString()))
      .toList();
}

List<enums.EnduringAccessRequestType>?
enduringAccessRequestTypeNullableListFromJson(
  List? enduringAccessRequestType, [
  List<enums.EnduringAccessRequestType>? defaultValue,
]) {
  if (enduringAccessRequestType == null) {
    return defaultValue;
  }

  return enduringAccessRequestType
      .map((e) => enduringAccessRequestTypeFromJson(e.toString()))
      .toList();
}

String? oAuthRedirectModeNullableToJson(
  enums.OAuthRedirectMode? oAuthRedirectMode,
) {
  return oAuthRedirectMode?.value;
}

String? oAuthRedirectModeToJson(enums.OAuthRedirectMode oAuthRedirectMode) {
  return oAuthRedirectMode.value;
}

enums.OAuthRedirectMode oAuthRedirectModeFromJson(
  Object? oAuthRedirectMode, [
  enums.OAuthRedirectMode? defaultValue,
]) {
  return enums.OAuthRedirectMode.values.firstWhereOrNull(
        (e) => e.value == oAuthRedirectMode,
      ) ??
      defaultValue ??
      enums.OAuthRedirectMode.swaggerGeneratedUnknown;
}

enums.OAuthRedirectMode? oAuthRedirectModeNullableFromJson(
  Object? oAuthRedirectMode, [
  enums.OAuthRedirectMode? defaultValue,
]) {
  if (oAuthRedirectMode == null) {
    return null;
  }
  return enums.OAuthRedirectMode.values.firstWhereOrNull(
        (e) => e.value == oAuthRedirectMode,
      ) ??
      defaultValue;
}

String oAuthRedirectModeExplodedListToJson(
  List<enums.OAuthRedirectMode>? oAuthRedirectMode,
) {
  return oAuthRedirectMode?.map((e) => e.value!).join(',') ?? '';
}

List<String> oAuthRedirectModeListToJson(
  List<enums.OAuthRedirectMode>? oAuthRedirectMode,
) {
  if (oAuthRedirectMode == null) {
    return [];
  }

  return oAuthRedirectMode.map((e) => e.value!).toList();
}

List<enums.OAuthRedirectMode> oAuthRedirectModeListFromJson(
  List? oAuthRedirectMode, [
  List<enums.OAuthRedirectMode>? defaultValue,
]) {
  if (oAuthRedirectMode == null) {
    return defaultValue ?? [];
  }

  return oAuthRedirectMode
      .map((e) => oAuthRedirectModeFromJson(e.toString()))
      .toList();
}

List<enums.OAuthRedirectMode>? oAuthRedirectModeNullableListFromJson(
  List? oAuthRedirectMode, [
  List<enums.OAuthRedirectMode>? defaultValue,
]) {
  if (oAuthRedirectMode == null) {
    return defaultValue;
  }

  return oAuthRedirectMode
      .map((e) => oAuthRedirectModeFromJson(e.toString()))
      .toList();
}

String? oAuthResponseTypeNullableToJson(
  enums.OAuthResponseType? oAuthResponseType,
) {
  return oAuthResponseType?.value;
}

String? oAuthResponseTypeToJson(enums.OAuthResponseType oAuthResponseType) {
  return oAuthResponseType.value;
}

enums.OAuthResponseType oAuthResponseTypeFromJson(
  Object? oAuthResponseType, [
  enums.OAuthResponseType? defaultValue,
]) {
  return enums.OAuthResponseType.values.firstWhereOrNull(
        (e) => e.value == oAuthResponseType,
      ) ??
      defaultValue ??
      enums.OAuthResponseType.swaggerGeneratedUnknown;
}

enums.OAuthResponseType? oAuthResponseTypeNullableFromJson(
  Object? oAuthResponseType, [
  enums.OAuthResponseType? defaultValue,
]) {
  if (oAuthResponseType == null) {
    return null;
  }
  return enums.OAuthResponseType.values.firstWhereOrNull(
        (e) => e.value == oAuthResponseType,
      ) ??
      defaultValue;
}

String oAuthResponseTypeExplodedListToJson(
  List<enums.OAuthResponseType>? oAuthResponseType,
) {
  return oAuthResponseType?.map((e) => e.value!).join(',') ?? '';
}

List<String> oAuthResponseTypeListToJson(
  List<enums.OAuthResponseType>? oAuthResponseType,
) {
  if (oAuthResponseType == null) {
    return [];
  }

  return oAuthResponseType.map((e) => e.value!).toList();
}

List<enums.OAuthResponseType> oAuthResponseTypeListFromJson(
  List? oAuthResponseType, [
  List<enums.OAuthResponseType>? defaultValue,
]) {
  if (oAuthResponseType == null) {
    return defaultValue ?? [];
  }

  return oAuthResponseType
      .map((e) => oAuthResponseTypeFromJson(e.toString()))
      .toList();
}

List<enums.OAuthResponseType>? oAuthResponseTypeNullableListFromJson(
  List? oAuthResponseType, [
  List<enums.OAuthResponseType>? defaultValue,
]) {
  if (oAuthResponseType == null) {
    return defaultValue;
  }

  return oAuthResponseType
      .map((e) => oAuthResponseTypeFromJson(e.toString()))
      .toList();
}

String? enduringPaymentConsentRequestTypeNullableToJson(
  enums.EnduringPaymentConsentRequestType? enduringPaymentConsentRequestType,
) {
  return enduringPaymentConsentRequestType?.value;
}

String? enduringPaymentConsentRequestTypeToJson(
  enums.EnduringPaymentConsentRequestType enduringPaymentConsentRequestType,
) {
  return enduringPaymentConsentRequestType.value;
}

enums.EnduringPaymentConsentRequestType
enduringPaymentConsentRequestTypeFromJson(
  Object? enduringPaymentConsentRequestType, [
  enums.EnduringPaymentConsentRequestType? defaultValue,
]) {
  return enums.EnduringPaymentConsentRequestType.values.firstWhereOrNull(
        (e) => e.value == enduringPaymentConsentRequestType,
      ) ??
      defaultValue ??
      enums.EnduringPaymentConsentRequestType.swaggerGeneratedUnknown;
}

enums.EnduringPaymentConsentRequestType?
enduringPaymentConsentRequestTypeNullableFromJson(
  Object? enduringPaymentConsentRequestType, [
  enums.EnduringPaymentConsentRequestType? defaultValue,
]) {
  if (enduringPaymentConsentRequestType == null) {
    return null;
  }
  return enums.EnduringPaymentConsentRequestType.values.firstWhereOrNull(
        (e) => e.value == enduringPaymentConsentRequestType,
      ) ??
      defaultValue;
}

String enduringPaymentConsentRequestTypeExplodedListToJson(
  List<enums.EnduringPaymentConsentRequestType>?
  enduringPaymentConsentRequestType,
) {
  return enduringPaymentConsentRequestType?.map((e) => e.value!).join(',') ??
      '';
}

List<String> enduringPaymentConsentRequestTypeListToJson(
  List<enums.EnduringPaymentConsentRequestType>?
  enduringPaymentConsentRequestType,
) {
  if (enduringPaymentConsentRequestType == null) {
    return [];
  }

  return enduringPaymentConsentRequestType.map((e) => e.value!).toList();
}

List<enums.EnduringPaymentConsentRequestType>
enduringPaymentConsentRequestTypeListFromJson(
  List? enduringPaymentConsentRequestType, [
  List<enums.EnduringPaymentConsentRequestType>? defaultValue,
]) {
  if (enduringPaymentConsentRequestType == null) {
    return defaultValue ?? [];
  }

  return enduringPaymentConsentRequestType
      .map((e) => enduringPaymentConsentRequestTypeFromJson(e.toString()))
      .toList();
}

List<enums.EnduringPaymentConsentRequestType>?
enduringPaymentConsentRequestTypeNullableListFromJson(
  List? enduringPaymentConsentRequestType, [
  List<enums.EnduringPaymentConsentRequestType>? defaultValue,
]) {
  if (enduringPaymentConsentRequestType == null) {
    return defaultValue;
  }

  return enduringPaymentConsentRequestType
      .map((e) => enduringPaymentConsentRequestTypeFromJson(e.toString()))
      .toList();
}

String? webhookEventsGetStatusNullableToJson(
  enums.WebhookEventsGetStatus? webhookEventsGetStatus,
) {
  return webhookEventsGetStatus?.value;
}

String? webhookEventsGetStatusToJson(
  enums.WebhookEventsGetStatus webhookEventsGetStatus,
) {
  return webhookEventsGetStatus.value;
}

enums.WebhookEventsGetStatus webhookEventsGetStatusFromJson(
  Object? webhookEventsGetStatus, [
  enums.WebhookEventsGetStatus? defaultValue,
]) {
  return enums.WebhookEventsGetStatus.values.firstWhereOrNull(
        (e) => e.value == webhookEventsGetStatus,
      ) ??
      defaultValue ??
      enums.WebhookEventsGetStatus.swaggerGeneratedUnknown;
}

enums.WebhookEventsGetStatus? webhookEventsGetStatusNullableFromJson(
  Object? webhookEventsGetStatus, [
  enums.WebhookEventsGetStatus? defaultValue,
]) {
  if (webhookEventsGetStatus == null) {
    return null;
  }
  return enums.WebhookEventsGetStatus.values.firstWhereOrNull(
        (e) => e.value == webhookEventsGetStatus,
      ) ??
      defaultValue;
}

String webhookEventsGetStatusExplodedListToJson(
  List<enums.WebhookEventsGetStatus>? webhookEventsGetStatus,
) {
  return webhookEventsGetStatus?.map((e) => e.value!).join(',') ?? '';
}

List<String> webhookEventsGetStatusListToJson(
  List<enums.WebhookEventsGetStatus>? webhookEventsGetStatus,
) {
  if (webhookEventsGetStatus == null) {
    return [];
  }

  return webhookEventsGetStatus.map((e) => e.value!).toList();
}

List<enums.WebhookEventsGetStatus> webhookEventsGetStatusListFromJson(
  List? webhookEventsGetStatus, [
  List<enums.WebhookEventsGetStatus>? defaultValue,
]) {
  if (webhookEventsGetStatus == null) {
    return defaultValue ?? [];
  }

  return webhookEventsGetStatus
      .map((e) => webhookEventsGetStatusFromJson(e.toString()))
      .toList();
}

List<enums.WebhookEventsGetStatus>? webhookEventsGetStatusNullableListFromJson(
  List? webhookEventsGetStatus, [
  List<enums.WebhookEventsGetStatus>? defaultValue,
]) {
  if (webhookEventsGetStatus == null) {
    return defaultValue;
  }

  return webhookEventsGetStatus
      .map((e) => webhookEventsGetStatusFromJson(e.toString()))
      .toList();
}

String? supportTransactionIdPost$RequestBodyTypeNullableToJson(
  enums.SupportTransactionIdPost$RequestBodyType?
  supportTransactionIdPost$RequestBodyType,
) {
  return supportTransactionIdPost$RequestBodyType?.value;
}

String? supportTransactionIdPost$RequestBodyTypeToJson(
  enums.SupportTransactionIdPost$RequestBodyType
  supportTransactionIdPost$RequestBodyType,
) {
  return supportTransactionIdPost$RequestBodyType.value;
}

enums.SupportTransactionIdPost$RequestBodyType
supportTransactionIdPost$RequestBodyTypeFromJson(
  Object? supportTransactionIdPost$RequestBodyType, [
  enums.SupportTransactionIdPost$RequestBodyType? defaultValue,
]) {
  return enums.SupportTransactionIdPost$RequestBodyType.values.firstWhereOrNull(
        (e) => e.value == supportTransactionIdPost$RequestBodyType,
      ) ??
      defaultValue ??
      enums.SupportTransactionIdPost$RequestBodyType.swaggerGeneratedUnknown;
}

enums.SupportTransactionIdPost$RequestBodyType?
supportTransactionIdPost$RequestBodyTypeNullableFromJson(
  Object? supportTransactionIdPost$RequestBodyType, [
  enums.SupportTransactionIdPost$RequestBodyType? defaultValue,
]) {
  if (supportTransactionIdPost$RequestBodyType == null) {
    return null;
  }
  return enums.SupportTransactionIdPost$RequestBodyType.values.firstWhereOrNull(
        (e) => e.value == supportTransactionIdPost$RequestBodyType,
      ) ??
      defaultValue;
}

String supportTransactionIdPost$RequestBodyTypeExplodedListToJson(
  List<enums.SupportTransactionIdPost$RequestBodyType>?
  supportTransactionIdPost$RequestBodyType,
) {
  return supportTransactionIdPost$RequestBodyType
          ?.map((e) => e.value!)
          .join(',') ??
      '';
}

List<String> supportTransactionIdPost$RequestBodyTypeListToJson(
  List<enums.SupportTransactionIdPost$RequestBodyType>?
  supportTransactionIdPost$RequestBodyType,
) {
  if (supportTransactionIdPost$RequestBodyType == null) {
    return [];
  }

  return supportTransactionIdPost$RequestBodyType.map((e) => e.value!).toList();
}

List<enums.SupportTransactionIdPost$RequestBodyType>
supportTransactionIdPost$RequestBodyTypeListFromJson(
  List? supportTransactionIdPost$RequestBodyType, [
  List<enums.SupportTransactionIdPost$RequestBodyType>? defaultValue,
]) {
  if (supportTransactionIdPost$RequestBodyType == null) {
    return defaultValue ?? [];
  }

  return supportTransactionIdPost$RequestBodyType
      .map(
        (e) => supportTransactionIdPost$RequestBodyTypeFromJson(e.toString()),
      )
      .toList();
}

List<enums.SupportTransactionIdPost$RequestBodyType>?
supportTransactionIdPost$RequestBodyTypeNullableListFromJson(
  List? supportTransactionIdPost$RequestBodyType, [
  List<enums.SupportTransactionIdPost$RequestBodyType>? defaultValue,
]) {
  if (supportTransactionIdPost$RequestBodyType == null) {
    return defaultValue;
  }

  return supportTransactionIdPost$RequestBodyType
      .map(
        (e) => supportTransactionIdPost$RequestBodyTypeFromJson(e.toString()),
      )
      .toList();
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  FutureOr<chopper.Response<ResultType>> convertResponse<ResultType, Item>(
    chopper.Response response,
  ) async {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    if (ResultType == String) {
      return response.copyWith();
    }

    if (ResultType == DateTime) {
      return response.copyWith(
        body:
            DateTime.parse((response.body as String).replaceAll('"', ''))
                as ResultType,
      );
    }

    final jsonRes = await super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
      body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType,
    );
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}

class Wrapped<T> {
  final T value;
  const Wrapped.value(this.value);
}
