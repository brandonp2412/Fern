import 'package:flutter/material.dart';
import '../models/payment.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';
import 'new_payment_sheet.dart';

class PaymentsScreen extends StatefulWidget {
  final AppState state;

  const PaymentsScreen({super.key, required this.state});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  List<Payment>? _payments;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _payments = null;
      _error = null;
    });
    try {
      final payments = await widget.state.api.getPayments();
      if (mounted) setState(() => _payments = payments);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  bool get _canPay =>
      widget.state.accounts.any((a) => a.canPayFrom && a.isActive);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payments')),
      floatingActionButton: _canPay && _error == null
          ? FloatingActionButton.extended(
              backgroundColor: Fern.green,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.add),
              label: const Text('New payment'),
              onPressed: () async {
                final made = await showModalBottomSheet<bool>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => NewPaymentSheet(state: widget.state),
                );
                if (made == true) _load();
              },
            )
          : null,
      body: _payments == null && _error == null
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _error!.contains('403')
                  ? const EmptyState(
                      icon: Icons.lock_outline,
                      title: 'Payments unavailable',
                      message:
                          'Your Akahu app or token doesn\'t have the payments scope enabled.')
                  : ErrorState(error: _error!, onRetry: _load)
              : _payments!.isEmpty
                  ? EmptyState(
                      icon: Icons.payments_outlined,
                      title: 'No payments yet',
                      message: _canPay
                          ? 'Make your first payment or transfer.'
                          : 'None of your accounts can initiate payments.',
                    )
                  : RefreshIndicator(
                      onRefresh: _load,
                      child: ListView.builder(
                        padding:
                            const EdgeInsets.fromLTRB(16, 8, 16, 100),
                        itemCount: _payments!.length,
                        itemBuilder: (context, i) =>
                            _paymentCard(_payments![i]),
                      ),
                    ),
    );
  }

  Widget _paymentCard(Payment p) {
    final color = paymentStatusColor(p.status);
    final from = widget.state.accountById(p.from);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () => _showDetail(p),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(
                    p.isSuccess
                        ? Icons.north_east
                        : p.isFailed
                            ? Icons.close
                            : Icons.schedule,
                    color: color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p.to?.name ?? p.to?.accountNumber ?? 'Payment',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14.5, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        [
                          if (from != null) 'from ${from.name}',
                          relativeDate(p.createdAt),
                        ].join(' · '),
                        style:
                            const TextStyle(fontSize: 12, color: Fern.slate),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MoneyText(p.amount, size: 15),
                    const SizedBox(height: 4),
                    StatusChip(paymentStatusLabel(p.status), color),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDetail(Payment p) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _PaymentDetailSheet(
        state: widget.state,
        payment: p,
        onChanged: _load,
      ),
    );
  }
}

class _PaymentDetailSheet extends StatefulWidget {
  final AppState state;
  final Payment payment;
  final VoidCallback onChanged;

  const _PaymentDetailSheet({
    required this.state,
    required this.payment,
    required this.onChanged,
  });

  @override
  State<_PaymentDetailSheet> createState() => _PaymentDetailSheetState();
}

class _PaymentDetailSheetState extends State<_PaymentDetailSheet> {
  late Payment _payment = widget.payment;
  bool _busy = false;

  Future<void> _cancel() async {
    setState(() => _busy = true);
    try {
      final updated =
          await widget.state.api.cancelPayment(_payment.id);
      setState(() => _payment = updated);
      widget.onChanged();
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Payment cancelled')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
    if (mounted) setState(() => _busy = false);
  }

  @override
  Widget build(BuildContext context) {
    final p = _payment;
    final color = paymentStatusColor(p.status);
    final from = widget.state.accountById(p.from);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: Fern.slate.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            money(p.amount),
            style: const TextStyle(
                fontSize: 36, fontWeight: FontWeight.w800, letterSpacing: -1),
          ),
          const SizedBox(height: 4),
          Text(
            'to ${p.to?.name ?? p.to?.accountNumber ?? 'recipient'}',
            style: const TextStyle(color: Fern.slate, fontSize: 14),
          ),
          const SizedBox(height: 10),
          StatusChip(paymentStatusLabel(p.status), color),
          if (p.statusText != null) ...[
            const SizedBox(height: 8),
            Text(p.statusText!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Fern.slate, fontSize: 12.5)),
          ],
          const SizedBox(height: 20),
          Card(
            child: Column(
              children: [
                if (from != null) _row('From', from.name),
                if (p.to?.accountNumber != null)
                  _row('To account', p.to!.accountNumber!),
                if (p.sid != null) _row('Akahu SID', p.sid!),
                if (p.createdAt != null)
                  _row('Created', dateTime(p.createdAt)),
                if (p.receivedAt != null)
                  _row('Received', dateTime(p.receivedAt)),
                _row('Payment ID', p.id),
              ],
            ),
          ),
          if (p.timeline.isNotEmpty) ...[
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Timeline',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    for (final e in p.timeline)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Icon(Icons.circle,
                                size: 8, color: paymentStatusColor(e.status)),
                            const SizedBox(width: 10),
                            Text(paymentStatusLabel(e.status),
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600)),
                            const Spacer(),
                            Text(dateTime(e.time),
                                style: const TextStyle(
                                    fontSize: 12, color: Fern.slate)),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
          if (p.cancellable) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _busy ? null : _cancel,
                icon: const Icon(Icons.cancel_outlined,
                    size: 18, color: Fern.clay),
                label: const Text('Cancel payment',
                    style: TextStyle(color: Fern.clay)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Fern.clay),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label,
                style: const TextStyle(color: Fern.slate, fontSize: 13)),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                  fontSize: 13.5, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
