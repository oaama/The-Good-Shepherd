import 'package:flutter/material.dart';

class PanicButton extends StatelessWidget {
  final VoidCallback onPressed;
  const PanicButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 32),
        elevation: 8,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.warning, color: Colors.white),
          SizedBox(width: 12),
          Text(
            'Panic',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
