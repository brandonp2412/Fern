import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../theme.dart';
import '../utils/format.dart';
import 'common.dart';

class TxnTile extends StatelessWidget {
  final Transaction tx;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final String? categoryGroupOverride;
  final String? imagePath;
  final bool masked;
  final bool selectionMode;
  final bool selected;

  const TxnTile({
    super.key,
    required this.tx,
    this.onTap,
    this.onLongPress,
    this.categoryGroupOverride,
    this.imagePath,
    this.masked = false,
    this.selectionMode = false,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final group =
        categoryGroupOverride ?? tx.category?.groupName ?? 'Uncategorised';
    final subtitle = <String>[relativeDate(tx.date), group].join(' · ');

    return Container(
      decoration: BoxDecoration(
        color: selected ? fern.green.withValues(alpha: 0.08) : null,
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              _leading(fern),
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
      ),
    );
  }

  Widget _leading(FernPalette fern) {
    if (!selectionMode) {
      return LogoAvatar(
        url: tx.meta?.logo,
        filePath: imagePath,
        fallback: _iconFor(tx.type),
        size: 38,
      );
    }
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? fern.green : fern.mist,
        border: Border.all(
          color: selected ? fern.green : fern.slate.withValues(alpha: 0.4),
          width: 2,
        ),
      ),
      child: selected
          ? Icon(Icons.check, color: fern.onGreen, size: 20)
          : null,
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
