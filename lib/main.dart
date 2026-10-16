import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models.dart';
import 'screens/main_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(VocabGroupAdapter());
  Hive.registerAdapter(WordAdapter());
  Hive.registerAdapter(ErrorRecordAdapter());

  await Hive.openBox<VocabGroup>('vocab_groups');
  await Hive.openBox<ErrorRecord>('error_records');

  runApp(const VocabApp());
}

class VocabApp extends StatelessWidget {
  const VocabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '词汇学习',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF38BDF8),
          brightness: Brightness.dark,
          surface: const Color(0xFF0F131C),
          primary: const Color(0xFF38BDF8),
          secondary: const Color(0xFF6EE7B7),
        ),
        scaffoldBackgroundColor: const Color(0xFF05070C),
        cardTheme: CardTheme(
          color: const Color(0xFF161D2B),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0A0D12),
          elevation: 0,
        ),
        dialogTheme: DialogTheme(
          backgroundColor: const Color(0xFF161D2B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}
