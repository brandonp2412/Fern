import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_shell.dart';
import 'services/akahu_api.dart';
import 'state/app_state.dart';
import 'theme.dart';

void main() {
  runApp(const FernMoneyApp());
}

class FernMoneyApp extends StatelessWidget {
  const FernMoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fern',
      debugShowCheckedModeBanner: false,
      theme: Fern.theme(),
      home: const SetupScreen(),
    );
  }
}

class SetupScreen extends StatefulWidget {
  const SetupScreen({super.key});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  static const _userToken = String.fromEnvironment('AKAHU_ACCESS_TOKEN');
  static const _appToken = String.fromEnvironment('AKAHU_APP_ID_TOKEN');
  static const _appSecret = String.fromEnvironment('AKAHU_APP_SECRET');

  final _userCtrl = TextEditingController(text: _userToken);
  final _appCtrl = TextEditingController(text: _appToken);
  final _secretCtrl = TextEditingController(text: _appSecret);
  final _formKey = GlobalKey<FormState>();
  bool _connecting = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    final prefs = await SharedPreferences.getInstance();
    if (_userCtrl.text.isEmpty) {
      _userCtrl.text = prefs.getString('user_token') ?? '';
    }
    if (_appCtrl.text.isEmpty) {
      _appCtrl.text = prefs.getString('app_token') ?? '';
    }
    if (_secretCtrl.text.isEmpty) {
      _secretCtrl.text = prefs.getString('app_secret') ?? '';
    }
    if (mounted && _userCtrl.text.isNotEmpty && _appCtrl.text.isNotEmpty) {
      _connect();
    }
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _appCtrl.dispose();
    _secretCtrl.dispose();
    super.dispose();
  }

  Future<void> _connect() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _connecting = true;
      _error = null;
    });
    final api = AkahuApi(
      userToken: _userCtrl.text.trim(),
      appToken: _appCtrl.text.trim(),
      appSecret: _secretCtrl.text.trim(),
    );
    try {
      await api.getMe();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_token', _userCtrl.text.trim());
      await prefs.setString('app_token', _appCtrl.text.trim());
      await prefs.setString('app_secret', _secretCtrl.text.trim());
      if (!mounted) return;
      final state = AppState(api);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeShell(state: state)),
      );
    } catch (e) {
      setState(() {
        _error = e.toString();
        _connecting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Fern.deep, Fern.green, Fern.cream],
            stops: [0, 0.42, 0.42],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.eco_outlined,
                          size: 56, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Fern',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                      ),
                    ),
                    const Text(
                      'Your money, beautifully organised',
                      style: TextStyle(color: Fern.sprout, fontSize: 14),
                    ),
                    const SizedBox(height: 32),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                'Connect to Akahu',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextFormField(
                                controller: _userCtrl,
                                decoration: const InputDecoration(
                                  labelText: 'User access token',
                                  hintText: 'user_token_…',
                                  prefixIcon:
                                      Icon(Icons.person_outline, size: 20),
                                ),
                                validator: (v) =>
                                    v == null || v.trim().isEmpty
                                        ? 'Required'
                                        : null,
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _appCtrl,
                                decoration: const InputDecoration(
                                  labelText: 'App ID token',
                                  hintText: 'app_token_…',
                                  prefixIcon:
                                      Icon(Icons.apps_outlined, size: 20),
                                ),
                                validator: (v) =>
                                    v == null || v.trim().isEmpty
                                        ? 'Required'
                                        : null,
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _secretCtrl,
                                decoration: const InputDecoration(
                                  labelText: 'App secret (optional)',
                                  helperText:
                                      'Unlocks categories, connections & identity',
                                  prefixIcon:
                                      Icon(Icons.key_outlined, size: 20),
                                ),
                                obscureText: true,
                              ),
                              if (_error != null) ...[
                                const SizedBox(height: 12),
                                Text(
                                  _error!,
                                  style: const TextStyle(
                                      color: Fern.clay, fontSize: 12.5),
                                ),
                              ],
                              const SizedBox(height: 20),
                              FilledButton(
                                onPressed: _connecting ? null : _connect,
                                child: _connecting
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text('Connect'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Get your tokens at my.akahu.nz',
                      style: TextStyle(color: Fern.slate, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
