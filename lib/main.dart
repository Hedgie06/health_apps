import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_apps/globals.dart';
import 'package:health_apps/screens/doctor/main_page_doctor.dart';
import 'package:health_apps/screens/doctor_or_patient.dart';
import 'package:health_apps/screens/firebase_auth.dart';
import 'package:health_apps/screens/my_profile.dart';
import 'package:health_apps/screens/patient/appointments.dart';
import 'package:health_apps/screens/patient/doctor_profile.dart';
import 'package:health_apps/screens/patient/main_page_patient.dart';
import 'package:health_apps/screens/skip.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase for all platforms (Android, iOS, web, etc.)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    setState(() {
      user = _auth.currentUser; // Safely retrieve the current user
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // Define app routes
        '/': (context) =>
            user == null ? const Skip() : const DoctorOrPatient(),
        '/login': (context) => const FireBaseAuth(),
        '/home': (context) =>
            isDoctor ? const MainPageDoctor() : const MainPagePatient(),
        '/profile': (context) => const MyProfile(),
        '/MyAppointments': (context) => const Appointments(),
        '/DoctorProfile': (context) => DoctorProfile(),
      },
      theme: ThemeData(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
    );
  }
}
