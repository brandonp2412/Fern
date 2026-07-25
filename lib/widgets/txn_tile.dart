import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../theme.dart';
import '../utils/format.dart';
import 'common.dart';

class TxnTile extends StatelessWidget {
  final Transaction tx;
  final VoidCallback? onTap;
  final String? accountName;

  const TxnTile({super.key, required this.tx, this.onTap, this.accountName});

  @override
  Widget build(BuildContext context) {
    final subtitle = <String>[
      if (accountName != null) accountName!,
      relativeDate(tx.date),
      if (tx.category?.groupName != null) tx.category!.groupName!,
    ].join(' · ');

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
                    style: const TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: Fern.ink,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Fern.slate),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            AmountText(tx.amount),
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
