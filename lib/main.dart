import 'package:flutter/material.dart';
import 'package:hemat_yuk/Auth/login.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const SupabaseUrl = 'Supabase.url.com';
const supabaseKey = "your_anon_key";
Future<void> main() async {
  await Supabase.initialize(url: SupabaseUrl,anonKey: supabaseKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final supabase  = Supabase.instance.client;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hemat Yuk',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const Login(),
    );
  }
}