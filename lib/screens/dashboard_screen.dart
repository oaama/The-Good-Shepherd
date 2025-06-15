import 'package:flutter/material.dart';
import 'package:the_good_shepherd/theme/app_theme.dart';
import 'package:go_router/go_router.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: AppTheme.navyBlue,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Decorative church arch background
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
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.church, size: 72, color: AppTheme.gold),
                    const SizedBox(height: 20),
                    Text(
                      'Welcome to your Dashboard',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: AppTheme.navyBlue,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 24),
                    _DashboardButton(
                      icon: Icons.person,
                      label: 'Profile',
                      onTap: () => context.go('/profile'),
                    ),
                    const SizedBox(height: 12),
                    _DashboardButton(
                      icon: Icons.family_restroom,
                      label: 'Parents',
                      onTap: () => context.go('/parents'),
                    ),
                    const SizedBox(height: 12),
                    _DashboardButton(
                      icon: Icons.warning_amber_rounded,
                      label: 'Panic',
                      onTap: () => context.go('/panic'),
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

class _DashboardButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _DashboardButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_DashboardButton> createState() => _DashboardButtonState();
}

class _DashboardButtonState extends State<_DashboardButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnim = Tween<double>(begin: 1, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          width: 220,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: AppTheme.gold.withOpacity(0.15),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppTheme.gold, width: 1.5),
            boxShadow: [
              BoxShadow(
                color: AppTheme.gold.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: AppTheme.navyBlue, size: 28),
              const SizedBox(width: 16),
              Text(
                widget.label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppTheme.navyBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
