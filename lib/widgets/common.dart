import 'dart:io';

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
  final bool masked;

  const MoneyText(
    this.value, {
    super.key,
    this.currency = 'NZD',
    this.size = 16,
    this.weight = FontWeight.w700,
    this.color,
    this.signed = false,
    this.masked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      masked ? '••••' : money(value, currency: currency, sign: signed),
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color ?? context.fern.ink,
        letterSpacing: -0.3,
        fontFeatures: const [],
      ),
    );
  }
}

class LogoAvatar extends StatelessWidget {
  final String? url;
  final String? filePath;
  final IconData fallback;
  final double size;

  const LogoAvatar({
    super.key,
    this.url,
    this.filePath,
    this.fallback = Icons.account_balance,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final bg = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: fern.mist,
        borderRadius: BorderRadius.circular(size * 0.3),
      ),
      clipBehavior: Clip.antiAlias,
      child: filePath != null && filePath!.isNotEmpty
          ? Image.file(
              File(filePath!),
              key: ValueKey(
                '$filePath-${_fileStamp(filePath!)}',
              ),
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, e, s) => _icon(fern),
            )
          : url != null && url!.isNotEmpty
          ? Image.network(
              url!,
              width: size,
              height: size,
              fit: BoxFit.cover,
              errorBuilder: (_, e, s) => _icon(fern),
              loadingBuilder: (context, child, progress) =>
                  progress == null ? child : _icon(fern),
            )
          : _icon(fern),
    );
    return bg;
  }

  Widget _icon(FernPalette fern) => Center(
        child: Icon(fallback, color: fern.green, size: size * 0.55),
      );

  int _fileStamp(String path) {
    try {
      return File(path).lastModifiedSync().millisecondsSinceEpoch;
    } catch (_) {
      return 0;
    }
  }
}

class AppBarSpinner extends StatelessWidget {
  const AppBarSpinner({super.key});

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(14),
        child: SizedBox(
            width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
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
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.2,
                color: context.fern.ink,
              ),
            ),
          ),
          ?trailing,
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
    final fern = context.fern;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: fern.mist,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: fern.green, size: 36),
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
                style: TextStyle(color: fern.slate, fontSize: 13.5),
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
    final fern = context.fern;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.cloud_off_outlined, color: fern.clay, size: 40),
            const SizedBox(height: 12),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: fern.slate, fontSize: 13),
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
  final bool masked;

  const AmountText(this.value, {super.key, this.size = 14, this.masked = false});

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final positive = value > 0;
    return Text(
      masked ? '••••' : money(value, sign: true),
      style: TextStyle(
        fontSize: size,
        fontWeight: FontWeight.w600,
        color: positive ? fern.green : fern.ink,
      ),
    );
  }
}

class CategoryPicker extends StatefulWidget {
  final Map<String, List<String>> known;
  final List<String> extra;
  final String? current;
  final void Function(String category, bool applyToFuture) onPick;
  final String? matchLabel;

  const CategoryPicker({
    super.key,
    required this.known,
    required this.extra,
    required this.current,
    required this.onPick,
    this.matchLabel,
  });

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  final _searchCtrl = TextEditingController();
  String _q = '';
  bool _applyToFuture = false;

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() => setState(() => _q = _searchCtrl.text.toLowerCase()));
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  bool _matches(String cat) => _q.isEmpty || cat.toLowerCase().contains(_q);

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      expand: false,
      builder: (context, scroll) => Column(
        children: [
          const SizedBox(height: 8),
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: fern.slate.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: TextField(
              controller: _searchCtrl,
              decoration: InputDecoration(
                hintText: 'Search categories...',
                prefixIcon: Icon(Icons.search, size: 20, color: fern.slate),
                filled: true,
                fillColor: fern.mist,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              ),
            ),
          ),
          if (widget.matchLabel != null)
            CheckboxListTile(
              dense: true,
              contentPadding: const EdgeInsets.only(left: 12, right: 16),
              controlAffinity: ListTileControlAffinity.leading,
              value: _applyToFuture,
              onChanged: (v) => setState(() => _applyToFuture = v ?? false),
              title: Text(
                'Auto-categorize future "${widget.matchLabel}" transactions',
                style: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
              ),
            ),
          Expanded(
            child: ListView(
              controller: scroll,
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              children: [
                if (_matches('Uncategorised'))
                  _catOption('Uncategorised', null, context),
                for (final e in widget.known.entries) ...[
                  if (e.value.any(_matches)) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 14, 4, 4),
                      child: Text(
                        e.key,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: fern.slate,
                        ),
                      ),
                    ),
                    for (final cat in e.value)
                      if (_matches(cat)) _catOption(cat, e.key, context),
                  ],
                ],
                if (widget.extra.any(_matches)) ...[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(4, 14, 4, 4),
                    child: Text(
                      'From bank',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: fern.slate,
                      ),
                    ),
                  ),
                  for (final cat in widget.extra)
                    if (_matches(cat)) _catOption(cat, null, context),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _catOption(String name, String? group, BuildContext context) {
    final fern = context.fern;
    final selected = widget.current == name;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        tileColor: selected ? fern.green.withValues(alpha: 0.08) : null,
        title: Text(
          name,
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? fern.green : null,
          ),
        ),
        trailing: selected
            ? Icon(Icons.check, size: 18, color: fern.green)
            : null,
        onTap: () => widget.onPick(
          name,
          name != 'Uncategorised' && _applyToFuture,
        ),
      ),
    );
  }
}
