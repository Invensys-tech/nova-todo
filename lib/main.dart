import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/intro.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://iazgcqadmrjhszpeqxpj.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlhemdjcWFkbXJqaHN6cGVxeHBqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIzODMxNDksImV4cCI6MjA1Nzk1OTE0OX0.v70ChJdX7BiAjvW3DmeZ1ekZ9gKGQ5zNxgbaKfsCC9c",
  );

  runApp(MyApp());
}

// final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nova Todo',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const IntorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
