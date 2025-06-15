import 'package:flutter/material.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1, end: 0.97).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(seconds: 1)); // Simulate API
    setState(() => _loading = false);
    if (_emailController.text == 'user@church.com' &&
        _passwordController.text == '123456') {
      if (mounted) context.go('/dashboard');
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Invalid email or password'),
            backgroundColor: Colors.red.shade700,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: AppTheme.navyBlue,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.08,
              child: Icon(Icons.church, size: 400, color: AppTheme.navyBlue),
            ),
          ),
          // Debug message always visible
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'DEBUG: LoginScreen content should appear below. If you see this and nothing else, there is a widget tree issue.',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                color: AppTheme.cream,
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 64,
                          color: AppTheme.gold,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Welcome to The Good Shepherd',
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: AppTheme.navyBlue,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 24),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          validator: (v) =>
                              v == null || v.isEmpty || !v.contains('@')
                              ? 'Enter a valid email'
                              : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          validator: (v) => v == null || v.length < 6
                              ? 'Password must be at least 6 characters'
                              : null,
                        ),
                        const SizedBox(height: 24),
                        ScaleTransition(
                          scale: _scaleAnim,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.gold,
                              foregroundColor: AppTheme.navyBlue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            onPressed: _loading
                                ? null
                                : () {
                                    _controller.forward().then(
                                      (_) => _controller.reverse(),
                                    );
                                    _login();
                                  },
                            child: _loading
                                ? const SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Login'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () => context.go('/register'),
                          child: const Text('Don\'t have an account? Register'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppTheme.navyBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: AppTheme.cream,
    );
  }
}
