import 'package:flutter/material.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';

class PanicScreen extends StatefulWidget {
  const PanicScreen({super.key});

  @override
  State<PanicScreen> createState() => _PanicScreenState();
}

class _PanicScreenState extends State<PanicScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  bool _alertSent = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1, end: 1.15).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendAlert() async {
    setState(() => _alertSent = true);
    await _controller.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    await _controller.reverse();
    await Future.delayed(const Duration(seconds: 1));
    setState(() => _alertSent = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panic'),
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
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              color: AppTheme.cream,
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      size: 72,
                      color: AppTheme.gold,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Panic Mode',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: AppTheme.navyBlue,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Send an alert in case of emergency.',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: AppTheme.navyBlue),
                    ),
                    const SizedBox(height: 32),
                    ScaleTransition(
                      scale: _scaleAnim,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.gold,
                          foregroundColor: AppTheme.navyBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 18,
                            horizontal: 32,
                          ),
                          elevation: 8,
                        ),
                        icon: const Icon(Icons.warning_amber_rounded, size: 32),
                        label: Text(
                          _alertSent ? 'Alert Sent!' : 'Send Panic Alert',
                          style: const TextStyle(fontSize: 18),
                        ),
                        onPressed: _alertSent ? null : _sendAlert,
                      ),
                    ),
                  ],
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
