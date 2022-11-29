import 'package:client/home/home.dart';
import 'package:client/login/login.dart';
import 'package:client/registration/registration.dart';
import 'package:client/sorting/sorting.dart';
import 'package:client/doctor_queue/doctor_queue.dart';
import 'package:client/patient_queue/patient_queue.dart';

var routes = {
  '/': (context) => const SortingScreen(),
  '/home': (context) => const HomeScreen(),
  '/registration': (context) => const RegistrationScreen(),
  '/sorting': (context) => const SortingScreen(),
  '/doctor_queue': (context) => const DoctorQueueScreen(),
  '/patient_queue': (context) => const PatientQueueScreen(),
};
