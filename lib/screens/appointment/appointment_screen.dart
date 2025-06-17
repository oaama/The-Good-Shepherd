import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/appointment_provider.dart';
import '../../widgets/custom_button.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    // Load appointments on screen init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AppointmentProvider>().getAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    final appointmentProvider = context.watch<AppointmentProvider>();
    final isLoading = appointmentProvider.isLoading;
    final error = appointmentProvider.error;
    final appointments = appointmentProvider.appointments;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Confession Appointment',
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
                : () => context.read<AppointmentProvider>().getAppointments(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Schedule New Appointment',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 22,
                      color: Color(0xFF002366),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  final date = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(
                                      const Duration(days: 365),
                                    ),
                                  );
                                  if (date != null)
                                    setState(() => _selectedDate = date);
                                },
                          child: Text(
                            _selectedDate == null
                                ? 'Select Date'
                                : _selectedDate!.toLocal().toString().split(
                                    ' ',
                                  )[0],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  );
                                  if (time != null)
                                    setState(() => _selectedTime = time);
                                },
                          child: Text(
                            _selectedTime == null
                                ? 'Select Time'
                                : _selectedTime!.format(context),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  CustomButton(
                    label: isLoading ? 'Booking...' : 'Book Appointment',
                    isLoading: isLoading,
                    onPressed: isLoading
                        ? null
                        : () async {
                            if (_selectedDate == null ||
                                _selectedTime == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please select date and time.'),
                                ),
                              );
                              return;
                            }
                            try {
                              await context
                                  .read<AppointmentProvider>()
                                  .scheduleAppointment(
                                    date: _selectedDate!,
                                    time: _selectedTime!.format(context),
                                  );
                              if (context.read<AppointmentProvider>().error ==
                                  null) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Appointment booked!'),
                                    ),
                                  );
                                  setState(() {
                                    _selectedDate = null;
                                    _selectedTime = null;
                                  });
                                }
                              } else if (context
                                      .read<AppointmentProvider>()
                                      .error !=
                                  null) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        context
                                            .read<AppointmentProvider>()
                                            .error!,
                                      ),
                                    ),
                                  );
                                }
                              }
                            } catch (e) {
                              if (mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'An error occurred. Please try again.',
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                  ),
                  if (error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        error,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ),
                  const SizedBox(height: 32),
                  Text(
                    'Previous Appointments',
                    style: GoogleFonts.cormorantGaramond(
                      fontSize: 18,
                      color: Color(0xFFBFA14A),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (appointments.isEmpty)
                    const Text('No appointments found.')
                  else
                    Expanded( // Added Expanded
                      child: ListView.builder( // Added ListView.builder
                        itemCount: appointments.length,
                        itemBuilder: (context, index) {
                          final a = appointments[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            elevation: 2,
                            child: ListTile(
                              leading: const Icon(
                                Icons.event_available,
                                color: Color(0xFF002366),
                              ),
                              title: Text(
                                'Date: ${a['date']}',
                                style: GoogleFonts.openSans(),
                              ),
                              subtitle: Text(
                                'Time: ${a['time']}',
                                style: GoogleFonts.openSans(),
                              ),
                            ),
                          );
                        },
                      ),
                    ), // This closing parenthesis for map was removed, builder now returns the Card
                  // Removed extra closing parenthesis from map
                ],
              ),
            ),
    );
  }
}
