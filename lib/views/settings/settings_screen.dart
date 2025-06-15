import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.cormorantGaramond(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF002366)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              value: _notifications,
              onChanged: (val) => setState(() => _notifications = val),
              title: Text('Notifications', style: GoogleFonts.openSans()),
              activeColor: const Color(0xFFBFA14A),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.privacy_tip_outlined,
                color: Color(0xFF002366),
              ),
              title: Text('Privacy Policy', style: GoogleFonts.openSans()),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.support_agent,
                color: Color(0xFF002366),
              ),
              title: Text('Contact Support', style: GoogleFonts.openSans()),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Color(0xFF002366)),
              title: Text('App Version 1.0.0', style: GoogleFonts.openSans()),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: Text(
                'Logout',
                style: GoogleFonts.openSans(color: Colors.redAccent),
              ),
              onTap: () {
                // TODO: Implement logout
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/login', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}
