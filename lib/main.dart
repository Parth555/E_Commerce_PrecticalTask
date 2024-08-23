import '../services/dio_client.dart';
import '../ui/app/my_app.dart';
import '../utils/preference.dart';
import 'package:flutter/material.dart';
import 'database/objectbox.dart';
late ObjectBox objectbox;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
  await Preference().instance();
  await DioClient().instance();

  runApp(const MyApp());
}
