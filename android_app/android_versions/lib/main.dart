// lib/main.dart

import 'package:flutter/material.dart';
import 'models/user.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'services/user_service.dart';

void main() {
  runApp(const AndroidApp());
}

class AndroidApp extends StatelessWidget {
  const AndroidApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Android Versions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF3DDC84),
          surface: const Color(0xFF1A0A2E),
        ),
        scaffoldBackgroundColor: const Color(0xFF0F0F1A),
        fontFamily: 'sans-serif',
      ),
      home: FutureBuilder<User?>(
        future: UserService.loadUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Scaffold(
              backgroundColor: Color(0xFF0F0F1A),
              body: Center(
                child: CircularProgressIndicator(color: Color(0xFF3DDC84)),
              ),
            );
          }

          final user = snapshot.data;
          if (user == null) {
            return const LoginScreen();
          }
          return HomeScreen(currentUser: user);
        },
      ),
    );
  }
}
