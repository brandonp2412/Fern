import 'package:flutter/material.dart';
import '../models/webhook.dart';
import '../state/app_state.dart';
import '../theme.dart';
import '../utils/format.dart';
import '../widgets/common.dart';

class WebhooksScreen extends StatefulWidget {
  final AppState state;

  const WebhooksScreen({super.key, required this.state});

  @override
  State<WebhooksScreen> createState() => _WebhooksScreenState();
}

class _WebhooksScreenState extends State<WebhooksScreen> {
  List<Webhook>? _webhooks;
  List<WebhookEvent>? _events;
  String? _error;
  bool _showEvents = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _webhooks = null;
      _events = null;
      _error = null;
    });
    try {
      final hooks = await widget.state.api.getWebhooks();
      List<WebhookEvent>? events;
      if (widget.state.api.hasAppSecret) {
        try {
          events = await widget.state.api.getWebhookEvents();
        } catch (_) {}
      }
      if (mounted) {
        setState(() {
          _webhooks = hooks;
          _events = events;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  Future<void> _create() async {
    final typeCtrl = TextEditingController(text: 'TRANSACTION');
    final stateCtrl = TextEditingController();
    final created = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New webhook'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: typeCtrl.text,
              decoration: const InputDecoration(labelText: 'Event type'),
              items: const [
                DropdownMenuItem(value: 'TOKEN', child: Text('Token')),
                DropdownMenuItem(value: 'ACCOUNT', child: Text('Account')),
                DropdownMenuItem(
                    value: 'TRANSACTION', child: Text('Transaction')),
                DropdownMenuItem(value: 'PAYMENT', child: Text('Payment')),
                DropdownMenuItem(value: 'TRANSFER', child: Text('Transfer')),
              ],
              onChanged: (v) => typeCtrl.text = v!,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: stateCtrl,
              decoration: const InputDecoration(
                  labelText: 'State (optional)',
                  helperText: 'Returned to you in each webhook payload'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(minimumSize: const Size(90, 44)),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    if (created != true) return;
    try {
      await widget.state.api.createWebhook(
        typeCtrl.text,
        state: stateCtrl.text.trim().isEmpty ? null : stateCtrl.text.trim(),
      );
      _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  Future<void> _delete(Webhook hook) async {
    try {
      await widget.state.api.deleteWebhook(hook.id);
      _load();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasEvents = _events != null && _events!.isNotEmpty;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Webhooks'),
        actions: [
          if (hasEvents)
            TextButton(
              onPressed: () => setState(() => _showEvents = !_showEvents),
              child: Text(_showEvents ? 'Hooks' : 'Events',
                  style: const TextStyle(color: Fern.green)),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Fern.green,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Subscribe'),
        onPressed: _create,
      ),
      body: _webhooks == null && _error == null
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? ErrorState(error: _error!, onRetry: _load)
              : _showEvents && hasEvents
                  ? _eventsList(_events!)
                  : _webhooks!.isEmpty
                      ? const EmptyState(
                          icon: Icons.webhook_outlined,
                          title: 'No webhooks',
                          message:
                              'Subscribe to receive events at your app\'s webhook URL.',
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _webhooks!.length,
                          itemBuilder: (context, i) =>
                              _hookCard(_webhooks![i]),
                        ),
    );
  }

  Widget _hookCard(Webhook hook) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Fern.mist,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.webhook_outlined,
                color: Fern.green, size: 19),
          ),
          title: Text(hook.id,
              style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          subtitle: Text(
            [
              if (hook.state != null) 'state: ${hook.state}',
              if (hook.lastCalledAt != null)
                'last fired ${relativeDate(hook.lastCalledAt)}',
            ].join(' · '),
            style: const TextStyle(fontSize: 12, color: Fern.slate),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, color: Fern.clay, size: 20),
            onPressed: () => _delete(hook),
          ),
        ),
      ),
    );
  }

  Widget _eventsList(List<WebhookEvent> events) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, i) {
        final e = events[i];
        final color = switch (e.status) {
          'SENT' => Fern.green,
          'RETRY' => const Color(0xFFB8860B),
          _ => Fern.clay,
        };
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Card(
            child: ListTile(
              dense: true,
              leading: Icon(Icons.bolt, color: color, size: 20),
              title: Text(
                '${e.webhookType ?? 'event'} · ${e.webhookCode ?? ''}',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                dateTime(e.createdAt),
                style: const TextStyle(fontSize: 11.5, color: Fern.slate),
              ),
              trailing: StatusChip(e.status, color),
            ),
          ),
        );
      },
    );
  }
}
