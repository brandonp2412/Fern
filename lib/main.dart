import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';
import 'screens/home_shell.dart';
import 'services/akahu_api.dart';
import 'services/demo_akahu_api.dart';
import 'services/secure_store.dart';
import 'state/app_settings.dart';
import 'state/app_state.dart';
import 'theme.dart';

Future<void> _openLink(String url) async {
  await launchUrl(
    Uri.parse('https://$url'),
    mode: LaunchMode.externalApplication,
  );
}

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
  bool _checkedCredentials = false;
  AppState? _appState;

  @override
  void initState() {
    super.initState();
    _settings.load();
    _restore();
  }

  Future<void> _restore() async {
    final userToken = await SecureStore.userToken ?? '';
    final appToken = await SecureStore.appToken ?? '';
    if (userToken.isEmpty || appToken.isEmpty) {
      if (!mounted) return;
      setState(() => _checkedCredentials = true);
      return;
    }
    final api = AkahuApi(userToken: userToken, appToken: appToken);
    try {
      await api.getMe();
      if (!mounted) return;
      setState(() {
        _appState = AppState(api, _settings);
        _checkedCredentials = true;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _checkedCredentials = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _settings,
      builder: (context, _) {
        final appState = _appState;
        return MaterialApp(
          title: 'Fern',
          debugShowCheckedModeBanner: false,
          themeMode: _settings.themeMode,
          theme: Fern.buildTheme(
            brightness: Brightness.light,
            seed: _settings.seedColor,
          ),
          darkTheme: Fern.buildTheme(
            brightness: Brightness.dark,
            seed: _settings.seedColor,
          ),
          home: !_checkedCredentials
              ? const Scaffold(body: SizedBox.shrink())
              : appState != null
              ? HomeShell(state: appState)
              : SetupScreen(
                  settings: _settings,
                  onConnected: (state) => setState(() => _appState = state),
                ),
        );
      },
    );
  }
}

class SetupScreen extends StatefulWidget {
  final AppSettings settings;
  final ValueChanged<AppState> onConnected;

  const SetupScreen({
    super.key,
    required this.settings,
    required this.onConnected,
  });

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
  String? _error;

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
      widget.onConnected(AppState(api, widget.settings));
    } catch (e) {
      setState(() {
        _error = e.toString();
        _connecting = false;
      });
    }
  }

  void _openDemo() {
    widget.onConnected(AppState(DemoAkahuApi(), widget.settings));
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
          child: Column(
            children: [
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: fern.onDeep.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.eco_outlined, size: 56, color: fern.onDeep),
              ),
              const SizedBox(height: 16),
              Text(
                'Fern',
                style: TextStyle(
                  color: fern.onDeep,
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
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
                                        prefixIcon: Icon(
                                          Icons.person_outline,
                                          size: 20,
                                        ),
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
                                        prefixIcon: Icon(
                                          Icons.apps_outlined,
                                          size: 20,
                                        ),
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
                                          color: fern.clay,
                                          fontSize: 12.5,
                                        ),
                                      ),
                                    ],
                                    const SizedBox(height: 20),
                                    FilledButton(
                                      onPressed: _connecting ? null : _connect,
                                      child: _connecting
                                          ? SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: fern.onGreen,
                                              ),
                                            )
                                          : const Text('Connect'),
                                    ),
                                    const SizedBox(height: 10),
                                    OutlinedButton.icon(
                                      onPressed: _connecting ? null : _openDemo,
                                      icon: const Icon(Icons.explore_outlined),
                                      label: const Text('Explore demo'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Card(
                            child: Theme(
                              data: Theme.of(
                                context,
                              ).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                title: const Text(
                                  'Where do I get these tokens?',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                childrenPadding: const EdgeInsets.fromLTRB(
                                  20,
                                  0,
                                  20,
                                  16,
                                ),
                                expandedCrossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  _SetupStep(
                                    number: '1',
                                    prefix: 'Sign up at ',
                                    linkText: 'my.akahu.nz',
                                    linkUrl: 'my.akahu.nz',
                                    suffix:
                                        ' and link one of your bank accounts.',
                                  ),
                                  _SetupStep(
                                    number: '2',
                                    prefix: 'Go to ',
                                    linkText: 'my.akahu.nz/developers',
                                    linkUrl: 'my.akahu.nz/developers',
                                    suffix:
                                        " and create a personal app. You'll need to verify your identity and set up two-factor authentication.",
                                  ),
                                  _SetupStep(
                                    number: '3',
                                    text:
                                        'Akahu will show you a User access token and an App ID token — copy both into the fields above.',
                                  ),
                                  _SetupStep(
                                    number: '4',
                                    text:
                                        'Still on the developers page, under Accounts, enable the bank(s) you want Fern to access.',
                                  ),
                                ],
                              ),
                            ),
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

class _SetupStep extends StatelessWidget {
  final String number;
  final String? text;
  final String? prefix;
  final String? linkText;
  final String? linkUrl;
  final String? suffix;

  const _SetupStep({
    required this.number,
    this.text,
    this.prefix,
    this.linkText,
    this.linkUrl,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final fern = context.fern;
    final baseStyle = TextStyle(
      fontSize: 12.5,
      color: fern.slate,
      height: 1.35,
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 10,
            backgroundColor: fern.sprout.withValues(alpha: 0.3),
            child: Text(
              number,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: fern.green,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: linkText != null
                ? Text.rich(
                    TextSpan(
                      style: baseStyle,
                      children: [
                        if (prefix != null) TextSpan(text: prefix),
                        TextSpan(
                          text: linkText,
                          style: TextStyle(
                            color: fern.green,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => _openLink(linkUrl!),
                        ),
                        if (suffix != null) TextSpan(text: suffix),
                      ],
                    ),
                  )
                : Text(text ?? '', style: baseStyle),
          ),
        ],
      ),
    );
  }
}
