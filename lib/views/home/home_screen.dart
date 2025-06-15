import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'The Good Shepherd',
          style: GoogleFonts.cormorantGaramond(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: Color(0xFF002366),
            ),
            onPressed: () => Navigator.of(context).pushNamed('/notifications'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, Youth!',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF002366),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daily Bible Verse',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 18,
                        color: Color(0xFFBFA14A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'I am the good shepherd. The good shepherd lays down his life for the sheep. (John 10:11)',
                      style: GoogleFonts.openSans(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Spiritual Quote',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 18,
                        color: Color(0xFFBFA14A),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Be still, and know that I am God.',
                      style: GoogleFonts.openSans(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            CustomButton(
              label: 'Panic',
              onPressed: () => Navigator.of(context).pushNamed('/panic'),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _QuickAccessCard(
                  icon: Icons.event_available,
                  label: 'Appointment',
                  onTap: () => Navigator.of(context).pushNamed('/appointment'),
                ),
                _QuickAccessCard(
                  icon: Icons.person,
                  label: 'Spiritual Father',
                  onTap: () =>
                      Navigator.of(context).pushNamed('/contact-father'),
                ),
                _QuickAccessCard(
                  icon: Icons.announcement,
                  label: 'Announcements',
                  onTap: () =>
                      Navigator.of(context).pushNamed('/announcements'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAccessCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickAccessCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          child: Column(
            children: [
              Icon(icon, color: Color(0xFF002366), size: 32),
              const SizedBox(height: 8),
              Text(
                label,
                style: GoogleFonts.openSans(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
