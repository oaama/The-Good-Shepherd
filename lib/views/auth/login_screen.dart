import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Placeholder
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      Icons.church,
                      size: 48,
                      color: Color(0xFFBFA14A),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome Back',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF002366),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 32),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => validateEmail(value),
                        prefixIcon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 18),
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        obscureText: _obscurePassword,
                        validator: (value) => validatePassword(value),
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 28),
                      CustomButton(
                        label: authProvider.isLoading
                            ? 'Logging in...'
                            : 'Login',
                        onPressed: authProvider.isLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  try {
                                    await context.read<AuthProvider>().login(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                                    if (context.read<AuthProvider>().error ==
                                            null &&
                                        context
                                            .read<AuthProvider>()
                                            .isLoggedIn) {
                                      if (mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Login successful!'),
                                          ),
                                        );
                                        Navigator.of(
                                          context,
                                        ).pushReplacementNamed('/home');
                                      }
                                    } else if (context
                                            .read<AuthProvider>()
                                            .error !=
                                        null) {
                                      if (mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              context
                                                  .read<AuthProvider>()
                                                  .error!,
                                            ),
                                          ),
                                        );
                                      }
                                    }
                                  } catch (e) {
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'An error occurred. Please try again.',
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                }
                              },
                        isLoading: authProvider.isLoading,
                      ),
                      if (authProvider.error != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            authProvider.error!,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: authProvider.isLoading
                      ? null
                      : () {
                          Navigator.of(context).pushNamed('/register');
                        },
                  child: Text(
                    "Don't have an account? Register",
                    style: GoogleFonts.openSans(
                      color: const Color(0xFF002366),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
