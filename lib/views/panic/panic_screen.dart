import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/panic_provider.dart';
import '../../widgets/custom_button.dart';

class PanicScreen extends StatelessWidget {
  const PanicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final panicProvider = context.watch<PanicProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Panic'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF002366)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning_amber_rounded,
              color: Colors.redAccent,
              size: 80,
            ),
            const SizedBox(height: 24),
            Text(
              'Emergency Panic',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF002366),
              ),
            ),
            const SizedBox(height: 18),
            panicProvider.isSending
                ? const CircularProgressIndicator()
                : CustomButton(
                    label: 'Send Panic',
                    isLoading: false,
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Confirm Panic'),
                          content: const Text(
                            'Are you sure you want to send a panic alert?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(false),
                              child: const Text('Cancel'),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.of(ctx).pop(true),
                              child: const Text('Send'),
                            ),
                          ],
                        ),
                      );
                      if (confirmed == true) {
                        try {
                          await context.read<PanicProvider>().sendPanic();
                          if (context.read<PanicProvider>().error == null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Panic sent successfully!'),
                                ),
                              );
                            }
                          } else if (context.read<PanicProvider>().error !=
                              null) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    context.read<PanicProvider>().error!,
                                  ),
                                ),
                              );
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
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
            if (panicProvider.error != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  panicProvider.error!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
