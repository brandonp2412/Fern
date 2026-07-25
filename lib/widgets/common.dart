import 'package:flutter/material.dart';
import '../theme.dart';
import '../utils/format.dart';

class MoneyText extends StatelessWidget {
  final num? value;
  final String currency;
  final double size;
  final FontWeight weight;
  final Color? color;
  final bool signed;

  const MoneyText(
    this.value, {
    super.key,
    this.currency = 'NZD',
    this.size = 16,
    this.weight = FontWeight.w700,
    this.color,
    this.signed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      money(value, currency: currency, sign: signed),
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color ?? Fern.ink,
        letterSpacing: -0.3,
        fontFeatures: const [],
      ),
    );
  }
}

class LogoAvatar extends StatelessWidget {
  final String? url;
  final IconData fallback;
  final double size;

  const LogoAvatar({
    super.key,
    this.url,
    this.fallback = Icons.account_balance,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    final bg = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Fern.mist,
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      clipBehavior: Clip.antiAlias,
      child: url != null && url!.isNotEmpty
          ? Image.network(
              url!,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, e, s) => _icon(),
              loadingBuilder: (context, child, progress) =>
                  progress == null ? child : _icon(),
            )
          : _icon(),
    );
    return bg;
  }

  Widget _icon() => Center(
        child: Icon(fallback, color: Fern.green, size: size * 0.55),
      );
}

class StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const StatusChip(this.label, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;

  const SectionHeader(this.title, {super.key, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 20, 4, 10),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
                color: Fern.ink,
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? message;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Fern.mist,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Fern.green, size: 36),
            ),
            const SizedBox(height: 16),
            Text(title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            if (message != null) ...[
              const SizedBox(height: 6),
              Text(
                message!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Fern.slate, fontSize: 13.5),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;

  const ErrorState({super.key, required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off_outlined, color: Fern.clay, size: 40),
            const SizedBox(height: 12),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Fern.slate, fontSize: 13),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh, size: 18),
              label: const Text('Try again'),
            ),
          ],
        ),
      ),
    );
  }
}

class AmountText extends StatelessWidget {
  final num value;
  final double size;

  const AmountText(this.value, {super.key, this.size = 14});

  @override
  Widget build(BuildContext context) {
    final positive = value > 0;
    return Text(
      money(value, sign: true),
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w600,
        color: positive ? Fern.green : Fern.ink,
      ),
    );
  }
}
