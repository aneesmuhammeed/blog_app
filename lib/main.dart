import 'package:flutter/material.dart';
import 'package:newflu/core/secrets/supabase_secrets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:newflu/core/theme/theme.dart';
import 'package:newflu/feature/auth/presentation/pages/login_page.dart';
import 'package:newflu/feature/auth/presentation/pages/sigup_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load environment variables from a local .env file (gitignored).
  await dotenv.load(fileName: ".env");

  final supabase = await Supabase.initialize(
    url: SupabaseSecrets.supabaseUrl,
    anonKey: SupabaseSecrets.anonKey,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
