import 'package:flutter/material.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';

class PanicScreen extends StatelessWidget {
  const PanicScreen({super.key});

  void _sendPanic(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Panic alert sent!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panic')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'In case of emergency, press the panic button',
              style: TextStyle(
                color: AppTheme.darkBlue,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(32),
              ),
              onPressed: () => _sendPanic(context),
              child: const Icon(
                Icons.warning_amber_rounded,
                size: 48,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
