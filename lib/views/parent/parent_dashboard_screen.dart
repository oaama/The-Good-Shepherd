import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../providers/parent_dashboard_provider.dart';

class ParentDashboardScreen extends StatefulWidget {
  const ParentDashboardScreen({Key? key}) : super(key: key);

  @override
  State<ParentDashboardScreen> createState() => _ParentDashboardScreenState();
}

class _ParentDashboardScreenState extends State<ParentDashboardScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch child data on screen load (dummy childId for now)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ParentDashboardProvider>().fetchChildData('child-id-1');
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ParentDashboardProvider>();
    final isLoading = provider.isLoading;
    final error = provider.error;
    final data = provider.childData;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Parent Dashboard',
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
                : () => context.read<ParentDashboardProvider>().fetchChildData(
                    'child-id-1',
                  ),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? Center(
              child: Text(error, style: const TextStyle(color: Colors.red)),
            )
          : data == null
          ? const Center(child: Text('No child data found.'))
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Child: ${data['name']}',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 22,
                      color: Color(0xFF002366),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      _ScoreCard(
                        label: 'Behavior',
                        score: data['behaviorScore'] ?? 0,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 18),
                      _ScoreCard(
                        label: 'Risk',
                        score: data['riskScore'] ?? 0,
                        color: Colors.redAccent,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Advice:',
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                  ),
                  Text(data['advice'] ?? '', style: GoogleFonts.openSans()),
                  const SizedBox(height: 24),
                  Text(
                    'Behavioral Flags:',
                    style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    children: (data['flags'] as List<dynamic>? ?? []).map((
                      flag,
                    ) {
                      return Chip(
                        label: Text(flag['label'] ?? ''),
                        backgroundColor: flag['active'] == true
                            ? Colors.redAccent
                            : Colors.grey[300],
                        labelStyle: GoogleFonts.openSans(
                          color: flag['active'] == true
                              ? Colors.white
                              : Colors.black87,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final String label;
  final int score;
  final Color color;
  const _ScoreCard({
    required this.label,
    required this.score,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        child: Column(
          children: [
            Text(
              label,
              style: GoogleFonts.openSans(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '$score',
              style: GoogleFonts.cormorantGaramond(fontSize: 22, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
