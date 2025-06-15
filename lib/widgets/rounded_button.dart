import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final IconData? icon;

  const RoundedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.color,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon != null ? Icon(icon, size: 20) : const SizedBox.shrink(),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        textStyle: Theme.of(context).textTheme.titleLarge,
      ),
      onPressed: onPressed,
    );
  }
}
