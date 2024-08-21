import '../services/dio_client.dart';
import '../ui/app/my_app.dart';
import '../utils/preference.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preference().instance();
  await DioClient().instance();

  runApp(const MyApp());
}
