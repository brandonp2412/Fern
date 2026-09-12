import 'package:flutter/material.dart';

Future<String?> showBackupPasswordDialog(
  BuildContext context, {
  required bool creating,
}) async {
  final password = TextEditingController();
  final confirmation = TextEditingController();
  String? error;
  var obscure = true;

  try {
    return await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text(creating ? 'Encrypt Fern backup' : 'Unlock Fern backup'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  creating
                      ? 'This full backup includes your Akahu credentials. Choose a password so the ZIP is safe to move between devices.'
                      : 'Enter the password used when this Fern backup was created.',
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: password,
                  obscureText: obscure,
                  autofocus: true,
                  decoration: InputDecoration(
                    labelText: 'Backup password',
                    errorText: error,
                    suffixIcon: IconButton(
                      onPressed: () => setState(() => obscure = !obscure),
                      icon: Icon(
                        obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                ),
                if (creating) ...[
                  const SizedBox(height: 12),
                  TextField(
                    controller: confirmation,
                    obscureText: obscure,
                    decoration: const InputDecoration(
                      labelText: 'Confirm password',
                    ),
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                final value = password.text;
                if (creating && value.length < 8) {
                  setState(() => error = 'Use at least 8 characters');
                  return;
                }
                if (creating && value != confirmation.text) {
                  setState(() => error = 'Passwords do not match');
                  return;
                }
                if (!creating && value.isEmpty) {
                  setState(() => error = 'Password required');
                  return;
                }
                Navigator.of(dialogContext).pop(value);
              },
              child: Text(creating ? 'Create backup' : 'Restore'),
            ),
          ],
        ),
      ),
    );
  } finally {
    password.dispose();
    confirmation.dispose();
  }
}
