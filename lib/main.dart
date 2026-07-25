import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/akahu_api.dart';

void main() {
  runApp(const FernMoneyApp());
}

class FernMoneyApp extends StatelessWidget {
  const FernMoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FernMoney',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const ApiSetupScreen(),
    );
  }
}

class ApiSetupScreen extends StatefulWidget {
  const ApiSetupScreen({super.key});

  @override
  State<ApiSetupScreen> createState() => _ApiSetupScreenState();
}

class _ApiSetupScreenState extends State<ApiSetupScreen> {
  final _userTokenCtrl = TextEditingController();
  final _appTokenCtrl = TextEditingController();
  final _appSecretCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userTokenCtrl.dispose();
    _appTokenCtrl.dispose();
    _appSecretCtrl.dispose();
    super.dispose();
  }

  void _connect() {
    if (_formKey.currentState!.validate()) {
      final api = AkahuApi(
        userToken: _userTokenCtrl.text.trim(),
        appToken: _appTokenCtrl.text.trim(),
        appSecret: _appSecretCtrl.text.trim(),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeScreen(api: api)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FernMoney'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.eco, size: 64, color: Colors.green),
                const SizedBox(height: 8),
                Text(
                  'Connect to Akahu',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _userTokenCtrl,
                  decoration: const InputDecoration(
                    labelText: 'User Token',
                    hintText: 'user_xxx...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _appTokenCtrl,
                  decoration: const InputDecoration(
                    labelText: 'App Token',
                    hintText: 'app_token_xxx...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _appSecretCtrl,
                  decoration: const InputDecoration(
                    labelText: 'App Secret',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 24),
                FilledButton(
                  onPressed: _connect,
                  child: const Text('Connect'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
