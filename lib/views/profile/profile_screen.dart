import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController(
    text: 'John Doe',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '0123456789',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'john@email.com',
  );
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    // Load user profile on screen init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<UserProvider>();
    final isLoading = userProvider.isLoading;
    final profile = userProvider.profile;
    final error = userProvider.error;

    // Update controllers with loaded profile data
    if (profile != null && _nameController.text != profile.fullName) {
      _nameController.text = profile.fullName;
      _phoneController.text = profile.phone;
      _emailController.text = profile.email;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.cormorantGaramond(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF002366)),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Edit Profile',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF002366),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 18),
                    CustomTextField(
                      controller: _nameController,
                      label: 'Full Name',
                      prefixIcon: Icons.person_outline,
                    ),
                    const SizedBox(height: 14),
                    CustomTextField(
                      controller: _phoneController,
                      label: 'Phone',
                      keyboardType: TextInputType.phone,
                      prefixIcon: Icons.phone_outlined,
                    ),
                    const SizedBox(height: 14),
                    CustomTextField(
                      controller: _emailController,
                      label: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 14),
                    CustomTextField(
                      controller: _passwordController,
                      label: 'New Password',
                      obscureText: _obscurePassword,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    CustomTextField(
                      controller: _confirmPasswordController,
                      label: 'Confirm Password',
                      obscureText: _obscureConfirmPassword,
                      prefixIcon: Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () => setState(
                          () => _obscureConfirmPassword =
                              !_obscureConfirmPassword,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    CustomButton(
                      label: isLoading ? 'Saving...' : 'Save Changes',
                      isLoading: isLoading,
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (_formKey.currentState!.validate()) {
                                FocusScope.of(context).unfocus();
                                try {
                                  await context
                                      .read<UserProvider>()
                                      .editProfile(
                                        fullName: _nameController.text.trim(),
                                        phone: _phoneController.text.trim(),
                                        email: _emailController.text.trim(),
                                      );
                                  if (context.read<UserProvider>().error ==
                                      null) {
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Profile updated!'),
                                        ),
                                      );
                                    }
                                  } else if (context
                                          .read<UserProvider>()
                                          .error !=
                                      null) {
                                    if (mounted) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            context.read<UserProvider>().error!,
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
                    const SizedBox(height: 18),
                    CustomButton(
                      label: 'Change Password',
                      onPressed: isLoading
                          ? null
                          : () async {
                              if (_passwordController.text.isEmpty ||
                                  _confirmPasswordController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Please enter and confirm your new password.',
                                    ),
                                  ),
                                );
                                return;
                              }
                              if (_passwordController.text !=
                                  _confirmPasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Passwords do not match.'),
                                  ),
                                );
                                return;
                              }
                              try {
                                await context.read<UserProvider>().changePassword(
                                  oldPassword:
                                      '', // TODO: Add old password field if needed
                                  newPassword: _passwordController.text.trim(),
                                );
                                if (context.read<UserProvider>().error ==
                                    null) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Password changed successfully!',
                                        ),
                                      ),
                                    );
                                    _passwordController.clear();
                                    _confirmPasswordController.clear();
                                  }
                                } else if (context.read<UserProvider>().error !=
                                    null) {
                                  if (mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          context.read<UserProvider>().error!,
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
                            },
                    ),
                    if (error != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          error,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
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
