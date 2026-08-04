// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum ConnectionType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('classic')
  classic('classic'),
  @JsonValue('official')
  official('official');

  final String? value;

  const ConnectionType(this.value);
}

enum ConnectionMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('strict')
  strict('strict'),
  @JsonValue('migration')
  migration('migration'),
  @JsonValue('side_by_side')
  sideBySide('side_by_side'),
  @JsonValue('developer')
  developer('developer');

  final String? value;

  const ConnectionMode(this.value);
}

enum PaymentPeriodFrequency {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('DAILY')
  daily('DAILY'),
  @JsonValue('WEEKLY')
  weekly('WEEKLY'),
  @JsonValue('FORTNIGHTLY')
  fortnightly('FORTNIGHTLY'),
  @JsonValue('MONTHLY')
  monthly('MONTHLY'),
  @JsonValue('ANNUALLY')
  annually('ANNUALLY');

  final String? value;

  const PaymentPeriodFrequency(this.value);
}

enum AccountStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('ACTIVE')
  active('ACTIVE'),
  @JsonValue('INACTIVE')
  inactive('INACTIVE');

  final String? value;

  const AccountStatus(this.value);
}

enum AccountType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('CHECKING')
  checking('CHECKING'),
  @JsonValue('SAVINGS')
  savings('SAVINGS'),
  @JsonValue('CREDITCARD')
  creditcard('CREDITCARD'),
  @JsonValue('LOAN')
  loan('LOAN'),
  @JsonValue('KIWISAVER')
  kiwisaver('KIWISAVER'),
  @JsonValue('INVESTMENT')
  investment('INVESTMENT'),
  @JsonValue('TERMDEPOSIT')
  termdeposit('TERMDEPOSIT'),
  @JsonValue('FOREIGN')
  foreign('FOREIGN'),
  @JsonValue('TAX')
  tax('TAX'),
  @JsonValue('REWARDS')
  rewards('REWARDS'),
  @JsonValue('WALLET')
  wallet('WALLET');

  final String? value;

  const AccountType(this.value);
}

enum AccountAttributes {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('TRANSACTIONS')
  transactions('TRANSACTIONS'),
  @JsonValue('PAYMENT_TO')
  paymentTo('PAYMENT_TO'),
  @JsonValue('PAYMENT_FROM')
  paymentFrom('PAYMENT_FROM');

  final String? value;

  const AccountAttributes(this.value);
}

enum Account$Meta$LoanDetailsPurpose {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('HOME')
  home('HOME'),
  @JsonValue('PERSONAL')
  personal('PERSONAL'),
  @JsonValue('BUSINESS')
  business('BUSINESS'),
  @JsonValue('UNKNOWN')
  unknown('UNKNOWN');

  final String? value;

  const Account$Meta$LoanDetailsPurpose(this.value);
}

enum Account$Meta$LoanDetailsType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('TABLE')
  table('TABLE'),
  @JsonValue('REDUCING')
  reducing('REDUCING'),
  @JsonValue('REVOLVING')
  revolving('REVOLVING'),
  @JsonValue('UNKNOWN')
  unknown('UNKNOWN');

  final String? value;

  const Account$Meta$LoanDetailsType(this.value);
}

enum Account$Meta$LoanDetails$InterestType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('FIXED')
  fixed('FIXED'),
  @JsonValue('FLOATING')
  floating('FLOATING');

  final String? value;

  const Account$Meta$LoanDetails$InterestType(this.value);
}

enum Account$Meta$LoanDetails$RepaymentFrequency {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('WEEKLY')
  weekly('WEEKLY'),
  @JsonValue('FORTNIGHTLY')
  fortnightly('FORTNIGHTLY'),
  @JsonValue('MONTHLY')
  monthly('MONTHLY'),
  @JsonValue('QUARTERLY')
  quarterly('QUARTERLY'),
  @JsonValue('BIANNUALLY')
  biannually('BIANNUALLY'),
  @JsonValue('ANNUALLY')
  annually('ANNUALLY');

  final String? value;

  const Account$Meta$LoanDetails$RepaymentFrequency(this.value);
}

enum AddressType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('RESIDENTIAL')
  residential('RESIDENTIAL'),
  @JsonValue('POSTAL')
  postal('POSTAL'),
  @JsonValue('UNKNOWN')
  unknown('UNKNOWN');

  final String? value;

  const AddressType(this.value);
}

enum OneOffIdentityStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('PROCESSING')
  processing('PROCESSING'),
  @JsonValue('COMPLETE')
  complete('COMPLETE'),
  @JsonValue('ERROR')
  error('ERROR');

  final String? value;

  const OneOffIdentityStatus(this.value);
}

enum VerifyNameMatchType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('MATCH')
  match('MATCH'),
  @JsonValue('PARTIAL_MATCH')
  partialMatch('PARTIAL_MATCH');

  final String? value;

  const VerifyNameMatchType(this.value);
}

enum VerifyNamePartySourceType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('PARTY_NAME')
  partyName('PARTY_NAME');

  final String? value;

  const VerifyNamePartySourceType(this.value);
}

enum VerifyNameHolderSourceType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('HOLDER_NAME')
  holderName('HOLDER_NAME');

  final String? value;

  const VerifyNameHolderSourceType(this.value);
}

enum OneOffIdentityPartyGender {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('MALE')
  male('MALE'),
  @JsonValue('FEMALE')
  female('FEMALE'),
  @JsonValue('UNKNOWN')
  unknown('UNKNOWN');

  final String? value;

  const OneOffIdentityPartyGender(this.value);
}

enum OneOffVerifyNamePartySourceType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('PARTY_NAME')
  partyName('PARTY_NAME');

  final String? value;

  const OneOffVerifyNamePartySourceType(this.value);
}

enum OneOffVerifyNameHolderSourceType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('HOLDER_NAME')
  holderName('HOLDER_NAME');

  final String? value;

  const OneOffVerifyNameHolderSourceType(this.value);
}

enum TransactionType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('CREDIT')
  credit('CREDIT'),
  @JsonValue('DEBIT')
  debit('DEBIT'),
  @JsonValue('PAYMENT')
  payment('PAYMENT'),
  @JsonValue('TRANSFER')
  transfer('TRANSFER'),
  @JsonValue('STANDING ORDER')
  standingOrder('STANDING ORDER'),
  @JsonValue('EFTPOS')
  eftpos('EFTPOS'),
  @JsonValue('INTEREST')
  interest('INTEREST'),
  @JsonValue('FEE')
  fee('FEE'),
  @JsonValue('TAX')
  tax('TAX'),
  @JsonValue('CREDIT CARD')
  creditCard('CREDIT CARD'),
  @JsonValue('DIRECT CREDIT')
  directCredit('DIRECT CREDIT'),
  @JsonValue('DIRECT DEBIT')
  directDebit('DIRECT DEBIT'),
  @JsonValue('ATM')
  atm('ATM'),
  @JsonValue('LOAN')
  loan('LOAN');

  final String? value;

  const TransactionType(this.value);
}

enum PaymentStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('READY')
  ready('READY'),
  @JsonValue('PENDING_APPROVAL')
  pendingApproval('PENDING_APPROVAL'),
  @JsonValue('SENT')
  sent('SENT'),
  @JsonValue('PAUSED')
  paused('PAUSED'),
  @JsonValue('DECLINED')
  declined('DECLINED'),
  @JsonValue('CANCELLED')
  cancelled('CANCELLED'),
  @JsonValue('ERROR')
  error('ERROR');

  final String? value;

  const PaymentStatus(this.value);
}

enum PartyType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('INDIVIDUAL')
  individual('INDIVIDUAL');

  final String? value;

  const PartyType(this.value);
}

enum Party$PhoneNumbers$ItemSubtype {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('MOBILE')
  mobile('MOBILE'),
  @JsonValue('HOME')
  home('HOME'),
  @JsonValue('WORK')
  work('WORK');

  final String? value;

  const Party$PhoneNumbers$ItemSubtype(this.value);
}

enum Party$EmailAddresses$ItemSubtype {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('PRIMARY')
  primary('PRIMARY');

  final String? value;

  const Party$EmailAddresses$ItemSubtype(this.value);
}

enum WebhookEventStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('SENT')
  sent('SENT'),
  @JsonValue('RETRY')
  retry('RETRY'),
  @JsonValue('FAILED')
  failed('FAILED');

  final String? value;

  const WebhookEventStatus(this.value);
}

enum WebhookEvent$PayloadWebhookType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('TOKEN')
  token('TOKEN'),
  @JsonValue('ACCOUNT')
  account('ACCOUNT'),
  @JsonValue('TRANSACTION')
  transaction('TRANSACTION'),
  @JsonValue('PAYMENT')
  payment('PAYMENT'),
  @JsonValue('TRANSFER')
  transfer('TRANSFER');

  final String? value;

  const WebhookEvent$PayloadWebhookType(this.value);
}

enum AuthorisationRequestSuccessResponseSuccess {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('true')
  $true('true');

  final String? value;

  const AuthorisationRequestSuccessResponseSuccess(this.value);
}

enum OAuth400ErrorCode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('invalid_request')
  invalidRequest('invalid_request'),
  @JsonValue('unsupported_response_type')
  unsupportedResponseType('unsupported_response_type'),
  @JsonValue('unsupported_grant_type')
  unsupportedGrantType('unsupported_grant_type');

  final String? value;

  const OAuth400ErrorCode(this.value);
}

enum CreateAuthorisationRequestIssueCode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('invalid_request')
  invalidRequest('invalid_request'),
  @JsonValue('not_found')
  notFound('not_found'),
  @JsonValue('single_limit_exceeded')
  singleLimitExceeded('single_limit_exceeded'),
  @JsonValue('invalid_payee')
  invalidPayee('invalid_payee'),
  @JsonValue('multiple_payees_not_supported')
  multiplePayeesNotSupported('multiple_payees_not_supported'),
  @JsonValue('account_payment_from_unsupported')
  accountPaymentFromUnsupported('account_payment_from_unsupported');

  final String? value;

  const CreateAuthorisationRequestIssueCode(this.value);
}

enum CreateAuthorisationRequestInvalidRequestResponseSuccess {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('false')
  $false('false');

  final String? value;

  const CreateAuthorisationRequestInvalidRequestResponseSuccess(this.value);
}

enum OAuth401ErrorCode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('invalid_client')
  invalidClient('invalid_client');

  final String? value;

  const OAuth401ErrorCode(this.value);
}

enum OAuthUnauthorizedResponseSuccess {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('false')
  $false('false');

  final String? value;

  const OAuthUnauthorizedResponseSuccess(this.value);
}

enum OAuth500ErrorCode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('server_error')
  serverError('server_error');

  final String? value;

  const OAuth500ErrorCode(this.value);
}

enum OAuthInternalServerErrorResponseSuccess {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('false')
  $false('false');

  final String? value;

  const OAuthInternalServerErrorResponseSuccess(this.value);
}

enum ConnectionStub {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('amex')
  amex('amex'),
  @JsonValue('amex:classic')
  amexClassic('amex:classic'),
  @JsonValue('anz')
  anz('anz'),
  @JsonValue('anz:classic')
  anzClassic('anz:classic'),
  @JsonValue('anz:official')
  anzOfficial('anz:official'),
  @JsonValue('asb')
  asb('asb'),
  @JsonValue('asb:classic')
  asbClassic('asb:classic'),
  @JsonValue('asb:official')
  asbOfficial('asb:official'),
  @JsonValue('bnz')
  bnz('bnz'),
  @JsonValue('bnz:classic')
  bnzClassic('bnz:classic'),
  @JsonValue('bnz:official')
  bnzOfficial('bnz:official'),
  @JsonValue('booster')
  booster('booster'),
  @JsonValue('booster:classic')
  boosterClassic('booster:classic'),
  @JsonValue('coop')
  coop('coop'),
  @JsonValue('coop:classic')
  coopClassic('coop:classic'),
  @JsonValue('demo_bank')
  demoBank('demo_bank'),
  @JsonValue('demo_bank:classic')
  demoBankClassic('demo_bank:classic'),
  @JsonValue('demo_bank:official')
  demoBankOfficial('demo_bank:official'),
  @JsonValue('fisher_funds')
  fisherFunds('fisher_funds'),
  @JsonValue('fisher_funds:classic')
  fisherFundsClassic('fisher_funds:classic'),
  @JsonValue('generate')
  generate('generate'),
  @JsonValue('generate:classic')
  generateClassic('generate:classic'),
  @JsonValue('hatch')
  hatch('hatch'),
  @JsonValue('hatch:classic')
  hatchClassic('hatch:classic'),
  @JsonValue('hatch:official')
  hatchOfficial('hatch:official'),
  @JsonValue('heartland')
  heartland('heartland'),
  @JsonValue('heartland:classic')
  heartlandClassic('heartland:classic'),
  @JsonValue('ird')
  ird('ird'),
  @JsonValue('ird:classic')
  irdClassic('ird:classic'),
  @JsonValue('pie_funds')
  pieFunds('pie_funds'),
  @JsonValue('pie_funds:classic')
  pieFundsClassic('pie_funds:classic'),
  @JsonValue('kernel')
  kernel('kernel'),
  @JsonValue('kernel:classic')
  kernelClassic('kernel:classic'),
  @JsonValue('kiwibank')
  kiwibank('kiwibank'),
  @JsonValue('kiwibank:classic')
  kiwibankClassic('kiwibank:classic'),
  @JsonValue('kiwibank:official')
  kiwibankOfficial('kiwibank:official'),
  @JsonValue('latitude')
  latitude('latitude'),
  @JsonValue('latitude:classic')
  latitudeClassic('latitude:classic'),
  @JsonValue('milford')
  milford('milford'),
  @JsonValue('milford:classic')
  milfordClassic('milford:classic'),
  @JsonValue('nzhl')
  nzhl('nzhl'),
  @JsonValue('nzhl:classic')
  nzhlClassic('nzhl:classic'),
  @JsonValue('nzhl:official')
  nzhlOfficial('nzhl:official'),
  @JsonValue('rabobank')
  rabobank('rabobank'),
  @JsonValue('rabobank:classic')
  rabobankClassic('rabobank:classic'),
  @JsonValue('sbs')
  sbs('sbs'),
  @JsonValue('sbs:classic')
  sbsClassic('sbs:classic'),
  @JsonValue('sharesies')
  sharesies('sharesies'),
  @JsonValue('sharesies:classic')
  sharesiesClassic('sharesies:classic'),
  @JsonValue('sharesight')
  sharesight('sharesight'),
  @JsonValue('sharesight:classic')
  sharesightClassic('sharesight:classic'),
  @JsonValue('simplicity')
  simplicity('simplicity'),
  @JsonValue('simplicity:classic')
  simplicityClassic('simplicity:classic'),
  @JsonValue('stake')
  stake('stake'),
  @JsonValue('stake:classic')
  stakeClassic('stake:classic'),
  @JsonValue('superlife')
  superlife('superlife'),
  @JsonValue('superlife:classic')
  superlifeClassic('superlife:classic'),
  @JsonValue('tsb')
  tsb('tsb'),
  @JsonValue('tsb:classic')
  tsbClassic('tsb:classic'),
  @JsonValue('westpac')
  westpac('westpac'),
  @JsonValue('westpac:classic')
  westpacClassic('westpac:classic'),
  @JsonValue('westpac:official')
  westpacOfficial('westpac:official'),
  @JsonValue('wise')
  wise('wise'),
  @JsonValue('wise:classic')
  wiseClassic('wise:classic');

  final String? value;

  const ConnectionStub(this.value);
}

enum EnduringAccessScope {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('user:basic')
  userBasic('user:basic'),
  @JsonValue('user:email')
  userEmail('user:email'),
  @JsonValue('identity:name')
  identityName('identity:name'),
  @JsonValue('identity:dob')
  identityDob('identity:dob'),
  @JsonValue('identity:email')
  identityEmail('identity:email'),
  @JsonValue('identity:phone')
  identityPhone('identity:phone'),
  @JsonValue('identity:address')
  identityAddress('identity:address'),
  @JsonValue('identity:tax_number')
  identityTaxNumber('identity:tax_number'),
  @JsonValue('accounts:basic')
  accountsBasic('accounts:basic'),
  @JsonValue('accounts:balance')
  accountsBalance('accounts:balance'),
  @JsonValue('accounts:details')
  accountsDetails('accounts:details'),
  @JsonValue('accounts:owner')
  accountsOwner('accounts:owner'),
  @JsonValue('transactions:credits')
  transactionsCredits('transactions:credits'),
  @JsonValue('transactions:debits')
  transactionsDebits('transactions:debits'),
  @JsonValue('payments')
  payments('payments');

  final String? value;

  const EnduringAccessScope(this.value);
}

enum EnduringPaymentFrequency {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('DAILY')
  daily('DAILY'),
  @JsonValue('WEEKLY')
  weekly('WEEKLY'),
  @JsonValue('FORTNIGHTLY')
  fortnightly('FORTNIGHTLY'),
  @JsonValue('MONTHLY')
  monthly('MONTHLY'),
  @JsonValue('ANNUALLY')
  annually('ANNUALLY');

  final String? value;

  const EnduringPaymentFrequency(this.value);
}

enum PaymentConsentStaticPayeeInputSource {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('STATIC')
  $static('STATIC');

  final String? value;

  const PaymentConsentStaticPayeeInputSource(this.value);
}

enum PaymentConsentRegisteredPayeeInputSource {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('REGISTERED')
  registered('REGISTERED');

  final String? value;

  const PaymentConsentRegisteredPayeeInputSource(this.value);
}

enum PaymentConsentInlinePayeeInputNoneVerifiedSource {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('INLINE')
  inline('INLINE');

  final String? value;

  const PaymentConsentInlinePayeeInputNoneVerifiedSource(this.value);
}

enum PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('NONE')
  none('NONE');

  final String? value;

  const PaymentConsentInlinePayeeInputNoneVerifiedVerificationMethod(
    this.value,
  );
}

enum PaymentConsentInlinePayeeInputClientVerifiedSource {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('INLINE')
  inline('INLINE');

  final String? value;

  const PaymentConsentInlinePayeeInputClientVerifiedSource(this.value);
}

enum PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('CLIENT_VERIFIED')
  clientVerified('CLIENT_VERIFIED');

  final String? value;

  const PaymentConsentInlinePayeeInputClientVerifiedVerificationMethod(
    this.value,
  );
}

enum PaymentConsentInlinePayeeInputVerifiedVerifiedSource {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('INLINE')
  inline('INLINE');

  final String? value;

  const PaymentConsentInlinePayeeInputVerifiedVerifiedSource(this.value);
}

enum PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('VERIFICATION_TOKEN')
  verificationToken('VERIFICATION_TOKEN');

  final String? value;

  const PaymentConsentInlinePayeeInputVerifiedVerifiedVerificationMethod(
    this.value,
  );
}

enum EnduringAccessRequestType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('enduring_access')
  enduringAccess('enduring_access');

  final String? value;

  const EnduringAccessRequestType(this.value);
}

enum OAuthRedirectMode {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('default')
  $default('default'),
  @JsonValue('embedded')
  embedded('embedded'),
  @JsonValue('deep_link')
  deepLink('deep_link');

  final String? value;

  const OAuthRedirectMode(this.value);
}

enum OAuthResponseType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('code')
  code('code');

  final String? value;

  const OAuthResponseType(this.value);
}

enum EnduringPaymentConsentRequestType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('enduring_payment_consent')
  enduringPaymentConsent('enduring_payment_consent');

  final String? value;

  const EnduringPaymentConsentRequestType(this.value);
}

enum WebhookEventsGetStatus {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('SENT')
  sent('SENT'),
  @JsonValue('FAILED')
  failed('FAILED'),
  @JsonValue('RETRY')
  retry('RETRY');

  final String? value;

  const WebhookEventsGetStatus(this.value);
}

enum SupportTransactionIdPost$RequestBodyType {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('DUPLICATE')
  duplicate('DUPLICATE'),
  @JsonValue('ENRICHMENT_ERROR')
  enrichmentError('ENRICHMENT_ERROR'),
  @JsonValue('ENRICHMENT_SUGGESTION')
  enrichmentSuggestion('ENRICHMENT_SUGGESTION');

  final String? value;

  const SupportTransactionIdPost$RequestBodyType(this.value);
}
