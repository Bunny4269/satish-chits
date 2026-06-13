import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/storage_service.dart';
import 'services/group_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageService.init();

  await Future.delayed(
    const Duration(milliseconds: 100),
  );

  GroupData.loadSavedData();

  runApp(const ChitApp());
}

class ChitApp extends StatelessWidget {
  const ChitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}