import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/notifications_provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch notifications on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationsProvider>().fetchNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationsProvider>();
    final isLoading = provider.isLoading;
    final error = provider.error;
    final notifications = provider.notifications;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: GoogleFonts.cormorantGaramond(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF002366)),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: isLoading
                ? null
                : () => context
                      .read<NotificationsProvider>()
                      .fetchNotifications(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : notifications.isEmpty
          ? const Center(child: Text('No notifications found.'))
          : ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                final n = notifications[i];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: n['read']! ? 1 : 4,
                  color: n['read']! ? Colors.grey[100] : Colors.white,
                  child: ListTile(
                    leading: Icon(
                      Icons.notifications,
                      color: n['read']! ? Colors.grey : Color(0xFF002366),
                    ),
                    title: Text(
                      n['title']!,
                      style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(n['body']!, style: GoogleFonts.openSans()),
                    trailing: n['read']!
                        ? null
                        : IconButton(
                            icon: const Icon(
                              Icons.circle,
                              color: Color(0xFFBFA14A),
                              size: 12,
                            ),
                            tooltip: 'Mark as read',
                            onPressed: () async {
                              await context
                                  .read<NotificationsProvider>()
                                  .markAsRead(n['id'] as int);
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Marked as read.')),
                                );
                              }
                            },
                          ),
                  ),
                );
              },
            ),
    );
  }
}
