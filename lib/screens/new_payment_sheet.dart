import 'package:flutter/material.dart';
import '../models/account.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';

class NewPaymentSheet extends StatefulWidget {
  final AppState state;

  const NewPaymentSheet({super.key, required this.state});

  @override
  State<NewPaymentSheet> createState() => _NewPaymentSheetState();
}

class _NewPaymentSheetState extends State<NewPaymentSheet> {
  final _formKey = GlobalKey<FormState>();
  int _mode = 0;
  Account? _from;
  Account? _transferTo;
  final _toNumberCtrl = TextEditingController();
  final _toNameCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _particularsCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _referenceCtrl = TextEditingController();
  final _taxNumberCtrl = TextEditingController();
  final _taxTypeCtrl = TextEditingController();
  final _taxPeriodCtrl = TextEditingController();
  bool _sending = false;
  String? _error;

  List<Account> get _payableFrom => widget.state.accounts
      .where((a) => a.canPayFrom && a.isActive)
      .toList();

  List<Account> get _payableTo => widget.state.accounts
      .where((a) => a.canPayTo && a.isActive && a.id != _from?.id)
      .toList();

  @override
  void initState() {
    super.initState();
    if (_payableFrom.isNotEmpty) _from = _payableFrom.first;
  }

  @override
  void dispose() {
    _toNumberCtrl.dispose();
    _toNameCtrl.dispose();
    _amountCtrl.dispose();
    _particularsCtrl.dispose();
    _codeCtrl.dispose();
    _referenceCtrl.dispose();
    _taxNumberCtrl.dispose();
    _taxTypeCtrl.dispose();
    _taxPeriodCtrl.dispose();
    super.dispose();
  }

  String? _clean(TextEditingController c) {
    final v = c.text.trim();
    return v.isEmpty ? null : v;
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _sending = true;
      _error = null;
    });
    final amount = double.tryParse(_amountCtrl.text.trim()) ?? 0;
    try {
      if (_mode == 2) {
        await widget.state.api.createIrdPayment(
          from: _from!.id,
          amount: amount,
          taxNumber: _taxNumberCtrl.text.trim(),
          taxType: _taxTypeCtrl.text.trim().toUpperCase(),
          taxPeriod: _clean(_taxPeriodCtrl),
        );
      } else {
        final toNumber = _mode == 1
            ? _transferTo!.formattedAccount!
            : _toNumberCtrl.text.trim();
        final toName =
            _mode == 1 ? (_transferTo!.holder ?? _transferTo!.name) : _clean(_toNameCtrl);
        await widget.state.api.createPayment(
          from: _from!.id,
          toAccountNumber: toNumber,
          toName: toName,
          amount: amount,
          destParticulars: _clean(_particularsCtrl),
          destCode: _clean(_codeCtrl),
          destReference: _clean(_referenceCtrl),
        );
      }
      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      setState(() {
        _error = e.toString();
        _sending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Fern.slate.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('New payment',
                  style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 14),
              SegmentedButton<int>(
                segments: const [
                  ButtonSegment(value: 0, label: Text('Someone')),
                  ButtonSegment(value: 1, label: Text('My accounts')),
                  ButtonSegment(value: 2, label: Text('IRD')),
                ],
                selected: {_mode},
                onSelectionChanged: (s) => setState(() => _mode = s.first),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith((states) =>
                      states.contains(WidgetState.selected)
                          ? Fern.green
                          : Colors.white),
                  foregroundColor: WidgetStateProperty.resolveWith((states) =>
                      states.contains(WidgetState.selected)
                          ? Colors.white
                          : Fern.ink),
                ),
              ),
              const SizedBox(height: 14),
              DropdownButtonFormField<Account>(
                initialValue: _from,
                decoration: const InputDecoration(labelText: 'From account'),
                items: [
                  for (final a in _payableFrom)
                    DropdownMenuItem(
                      value: a,
                      child: Text(
                        '${a.name} · ${money(a.displayBalance)}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                ],
                onChanged: (a) => setState(() {
                  _from = a;
                  _transferTo = null;
                }),
              ),
              const SizedBox(height: 12),
              if (_mode == 0) ...[
                TextFormField(
                  controller: _toNumberCtrl,
                  decoration: const InputDecoration(
                      labelText: 'Account number',
                      hintText: '12-1234-1234567-00'),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _toNameCtrl,
                  decoration: const InputDecoration(
                      labelText: 'Payee name (optional)'),
                ),
              ] else if (_mode == 1) ...[
                DropdownButtonFormField<Account>(
                  initialValue: _transferTo,
                  decoration: const InputDecoration(labelText: 'To account'),
                  items: [
                    for (final a in _payableTo)
                      DropdownMenuItem(
                        value: a,
                        child: Text(
                          a.formattedAccount != null
                              ? '${a.name} · ${a.formattedAccount}'
                              : a.name,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                  ],
                  validator: (v) => v == null ? 'Pick an account' : null,
                  onChanged: (a) => setState(() => _transferTo = a),
                ),
              ] else ...[
                TextFormField(
                  controller: _taxNumberCtrl,
                  decoration: const InputDecoration(
                      labelText: 'IRD / GST number', hintText: '123456789'),
                  validator: (v) {
                    final digits = (v ?? '').replaceAll(RegExp(r'\D'), '');
                    return digits.length < 8 || digits.length > 9
                        ? 'Enter a valid 8–9 digit IRD number'
                        : null;
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _taxTypeCtrl,
                        textCapitalization: TextCapitalization.characters,
                        decoration: const InputDecoration(
                            labelText: 'Tax type', hintText: 'INC'),
                        validator: (v) =>
                            (v ?? '').trim().length != 3 ? '3 letters' : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _taxPeriodCtrl,
                        decoration: const InputDecoration(
                            labelText: 'Period end (optional)',
                            hintText: '2026-03-31'),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$ ',
                ),
                validator: (v) {
                  final n = double.tryParse((v ?? '').trim());
                  if (n == null || n <= 0) return 'Enter a valid amount';
                  return null;
                },
              ),
              if (_mode != 2) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _particularsCtrl,
                        maxLength: 12,
                        decoration: const InputDecoration(
                            labelText: 'Particulars', counterText: ''),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _codeCtrl,
                        maxLength: 12,
                        decoration: const InputDecoration(
                            labelText: 'Code', counterText: ''),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: _referenceCtrl,
                        maxLength: 12,
                        decoration: const InputDecoration(
                            labelText: 'Reference', counterText: ''),
                      ),
                    ),
                  ],
                ),
              ],
              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(_error!,
                    style: const TextStyle(color: Fern.clay, fontSize: 12.5)),
              ],
              const SizedBox(height: 18),
              FilledButton.icon(
                onPressed: _sending ? null : _send,
                icon: _sending
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white))
                    : const Icon(Icons.send, size: 18),
                label: Text(_mode == 2
                    ? 'Pay IRD'
                    : _mode == 1
                        ? 'Transfer'
                        : 'Send payment'),
              ),
              const SizedBox(height: 8),
              const Text(
                'Payments are processed by Akahu via your bank.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Fern.slate, fontSize: 11.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
