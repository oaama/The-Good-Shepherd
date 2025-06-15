import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';
import '../../utils/validators.dart';
import '../../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _gender;
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Register',
          style: GoogleFonts.cormorantGaramond(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF002366)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Create Account',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF002366),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                CustomTextField(
                  controller: _fullNameController,
                  label: 'Full Name',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Full name required'
                      : null,
                  prefixIcon: Icons.person_outline,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: _ageController,
                  label: 'Age',
                  keyboardType: TextInputType.number,
                  validator: (value) =>
                      value == null || int.tryParse(value) == null
                      ? 'Enter valid age'
                      : null,
                  prefixIcon: Icons.cake_outlined,
                ),
                const SizedBox(height: 14),
                DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    filled: true,
                    fillColor: const Color(0xFFF6F6F6),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 20,
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Male', child: Text('Male')),
                    DropdownMenuItem(value: 'Female', child: Text('Female')),
                  ],
                  onChanged: (val) => setState(() => _gender = val),
                  validator: (value) => value == null ? 'Select gender' : null,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: _phoneController,
                  label: 'Phone',
                  keyboardType: TextInputType.phone,
                  validator: (value) => value == null || value.length < 8
                      ? 'Enter valid phone'
                      : null,
                  prefixIcon: Icons.phone_outlined,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) => validateEmail(value),
                  prefixIcon: Icons.email_outlined,
                ),
                const SizedBox(height: 14),
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
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  obscureText: _obscureConfirmPassword,
                  validator: (value) => value != _passwordController.text
                      ? 'Passwords do not match'
                      : null,
                  prefixIcon: Icons.lock_outline,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () => setState(
                      () => _obscureConfirmPassword = !_obscureConfirmPassword,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                CustomButton(
                  label: authProvider.isLoading ? 'Registering...' : 'Register',
                  isLoading: authProvider.isLoading,
                  onPressed: authProvider.isLoading
                      ? null
                      : () async {
                          if (_formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            try {
                              await context.read<AuthProvider>().register(
                                fullName: _fullNameController.text.trim(),
                                age:
                                    int.tryParse(_ageController.text.trim()) ??
                                    0,
                                gender: _gender ?? '',
                                phone: _phoneController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                              if (context.read<AuthProvider>().error == null) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Registration successful! Please login.',
                                      ),
                                    ),
                                  );
                                  Navigator.of(
                                    context,
                                  ).pushReplacementNamed('/login');
                                }
                              } else if (context.read<AuthProvider>().error !=
                                  null) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        context.read<AuthProvider>().error!,
                                      ),
                                    ),
                                  );
                                }
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
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
                ),
                if (authProvider.error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      authProvider.error!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                const SizedBox(height: 18),
                TextButton(
                  onPressed: authProvider.isLoading
                      ? null
                      : () => Navigator.of(context).pop(),
                  child: Text(
                    'Already have an account? Login',
                    style: GoogleFonts.openSans(
                      color: Color(0xFF002366),
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
