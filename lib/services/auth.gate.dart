import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_application_1/MainScreen%20Page.dart';
import 'package:flutter_application_1/pages/auth/login.dart';
// import 'package:flutter_application_1/pages/auth/signup.dart';
// import 'package:flutter_application_1/utils/supabase.clients.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    // return StreamBuilder(
    //   stream: supabaseClient.auth.onAuthStateChange,
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Scaffold(body: Center(child: CircularProgressIndicator()));
    //     }

    //     final session = snapshot.hasData ? snapshot.data!.session : null;

    //     if (session != null) {
    //       return LogInPage();
    //     } else {
    //       return MainScreenPage();
    //     }
    //   },
    // );

    return LogInPage();
    // return Material(
    //   // Wrap the content inside a Material widget
    //   child: Scaffold(
    //     // Ensure that your content has a scaffold
    //     body: SignUpPage(),
    //   ),
    // );
  }
}
