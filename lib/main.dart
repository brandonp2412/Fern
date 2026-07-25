import 'package:flutter/material.dart';
import 'screens/home_shell.dart';
import 'services/akahu_api.dart';
import 'services/secure_store.dart';
import 'state/app_settings.dart';
import 'state/app_state.dart';
import 'theme.dart';

void main() {
  runApp(const FernApp());
}

class FernApp extends StatefulWidget {
  const FernApp({super.key});

  @override
  State<FernApp> createState() => _FernAppState();
}

class _FernAppState extends State<FernApp> {
  final _settings = AppSettings();

  @override
  void initState() {
    super.initState();
    _settings.load();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _settings,
      builder: (context, _) => MaterialApp(
        title: 'Fern',
        debugShowCheckedModeBanner: false,
        themeMode: _settings.themeMode,
        theme: Fern.buildTheme(brightness: Brightness.light, seed: _settings.seedColor),
        darkTheme: Fern.buildTheme(brightness: Brightness.dark, seed: _settings.seedColor),
        home: SetupScreen(settings: _settings),
      ),
    );
  }
}

class SetupScreen extends StatefulWidget {
  final AppSettings settings;

  const SetupScreen({super.key, required this.settings});

  @override
  State<SetupScreen> createState() => _SetupScreenState();
}

class _SetupScreenState extends State<SetupScreen> {
  static const _userToken = String.fromEnvironment('AKAHU_ACCESS_TOKEN');
  static const _appToken = String.fromEnvironment('AKAHU_APP_ID_TOKEN');

  final _userCtrl = TextEditingController(text: _userToken);
  final _appCtrl = TextEditingController(text: _appToken);
  final _formKey = GlobalKey<FormState>();
  bool _connecting = false;
  bool _restoring = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _restore();
  }

  Future<void> _restore() async {
    if (_userCtrl.text.isEmpty) {
      _userCtrl.text = await SecureStore.userToken ?? '';
    }
    if (_appCtrl.text.isEmpty) {
      _appCtrl.text = await SecureStore.appToken ?? '';
    }
    if (!mounted) return;
    if (_userCtrl.text.isNotEmpty && _appCtrl.text.isNotEmpty) {
      _connect();
    } else {
      setState(() => _restoring = false);
    }
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _appCtrl.dispose();
    super.dispose();
  }

  Future<void> _connect() async {
    if (_formKey.currentState?.validate() == false) return;
    setState(() {
      _connecting = true;
      _error = null;
    });
    final api = AkahuApi(
      userToken: _userCtrl.text.trim(),
      appToken: _appCtrl.text.trim(),
    );
    try {
      await api.getMe();
      await SecureStore.saveCredentials(
        userToken: _userCtrl.text.trim(),
        appToken: _appCtrl.text.trim(),
      );
      if (!mounted) return;
      final state = AppState(api, widget.settings);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => HomeShell(state: state)),
      );
    } catch (e) {
      setState(() {
        _error = e.toString();
        _connecting = false;
        _restoring = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [fern.deep, fern.green, fern.cream],
            stops: const [0, 0.42, 0.42],
          ),
        ),
        child: SafeArea(
          child: _restoring
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : Column(
                  children: [
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.eco_outlined, size: 56, color: Colors.white),
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
                    Text(
                      'Your money, beautifully organised',
                      style: TextStyle(color: fern.sprout, fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 420),
                            child: Column(
                              children: [
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
                                          if (_error != null) ...[
                                            const SizedBox(height: 12),
                                            Text(
                                              _error!,
                                              style: TextStyle(
                                                  color: fern.clay, fontSize: 12.5),
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
                                Text(
                                  'Get your tokens at my.akahu.nz',
                                  style: TextStyle(color: fern.slate, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
