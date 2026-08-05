import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final _money = NumberFormat('#,##0.00');

String money(num? value, {String currency = 'NZD', bool sign = false}) {
  if (value == null) return '—';
  final symbol = currency == 'NZD' ? '\$' : '$currency ';
  final prefix = value < 0 ? '-' : (sign ? '+' : '');
  return '$prefix$symbol${_money.format(value.abs())}';
}

DateTime? parseDate(String? iso) =>
    iso == null || iso.isEmpty ? null : DateTime.tryParse(iso)?.toLocal();

String shortDate(String? iso) {
  final d = parseDate(iso);
  return d == null ? '' : DateFormat('d MMM').format(d);
}

String longDate(String? iso) {
  final d = parseDate(iso);
  return d == null ? '' : DateFormat('EEE d MMM y').format(d);
}

String dateTime(String? iso) {
  final d = parseDate(iso);
  return d == null ? '' : DateFormat('d MMM y, h:mm a').format(d);
}

String relativeDate(String? iso) {
  final d = parseDate(iso);
  if (d == null) return '';
  final now = DateTime.now();
  final day = DateTime(d.year, d.month, d.day);
  final today = DateTime(now.year, now.month, now.day);
  final diff = today.difference(day).inDays;
  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  if (diff < 7) return DateFormat('EEEE').format(d);
  return DateFormat('d MMM').format(d);
}

String isoDay(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

String accountTypeLabel(String type) => switch (type.toUpperCase()) {
  'CHECKING' => 'Everyday',
  'SAVINGS' => 'Savings',
  'CREDITCARD' => 'Credit card',
  'LOAN' => 'Loan',
  'KIWISAVER' => 'KiwiSaver',
  'INVESTMENT' => 'Investment',
  'TERMDEPOSIT' => 'Term deposit',
  'FOREIGN' => 'Foreign currency',
  'TAX' => 'Tax',
  'REWARDS' => 'Rewards',
  'WALLET' => 'Wallet',
  _ => type,
};

IconData accountTypeIcon(String type) => switch (type.toUpperCase()) {
  'CHECKING' => Icons.account_balance_wallet_outlined,
  'SAVINGS' => Icons.savings_outlined,
  'CREDITCARD' => Icons.credit_card,
  'LOAN' => Icons.home_outlined,
  'KIWISAVER' => Icons.eco_outlined,
  'INVESTMENT' => Icons.trending_up,
  'TERMDEPOSIT' => Icons.lock_outline,
  'FOREIGN' => Icons.public,
  'TAX' => Icons.receipt_long_outlined,
  'REWARDS' => Icons.card_giftcard,
  'WALLET' => Icons.account_balance_wallet_outlined,
  _ => Icons.account_balance_outlined,
};

String txTypeLabel(String type) => switch (type) {
  'CREDIT' => 'Credit',
  'DEBIT' => 'Debit',
  'PAYMENT' => 'Payment',
  'TRANSFER' => 'Transfer',
  'STANDING ORDER' => 'Standing order',
  'EFTPOS' => 'EFTPOS',
  'INTEREST' => 'Interest',
  'FEE' => 'Fee',
  'TAX' => 'Tax',
  'CREDIT CARD' => 'Card payment',
  'DIRECT CREDIT' => 'Direct credit',
  'DIRECT DEBIT' => 'Direct debit',
  'ATM' => 'ATM',
  'LOAN' => 'Loan payment',
  _ => type,
};
