import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../theme.dart';
import '../utils/format.dart';
import 'common.dart';

class TxnTile extends StatelessWidget {
  final Transaction tx;
  final VoidCallback? onTap;
  final String? categoryGroupOverride;
  final bool masked;

  const TxnTile({
    super.key,
    required this.tx,
    this.onTap,
    this.categoryGroupOverride,
    this.masked = false,
  });

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final group = categoryGroupOverride ?? tx.category?.groupName;
    final subtitle = <String>[relativeDate(tx.date), ?group].join(' · ');

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Row(
          children: [
            LogoAvatar(
              url: tx.meta?.logo,
              fallback: _iconFor(tx.type),
              size: 38,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tx.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: fern.ink,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: fern.slate),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            AmountText(tx.amount, masked: masked),
          ],
        ),
      ),
    );
  }

  static IconData _iconFor(String type) => switch (type) {
    'EFTPOS' => Icons.credit_card,
    'TRANSFER' => Icons.swap_horiz,
    'PAYMENT' => Icons.payments_outlined,
    'DIRECT DEBIT' => Icons.repeat,
    'DIRECT CREDIT' => Icons.call_received,
    'ATM' => Icons.local_atm,
    'INTEREST' => Icons.percent,
    'FEE' => Icons.receipt_outlined,
    'TAX' => Icons.account_balance,
    'LOAN' => Icons.home_outlined,
    'CREDIT CARD' => Icons.credit_card,
    'STANDING ORDER' => Icons.event_repeat,
    _ => Icons.shopping_bag_outlined,
  };
}
