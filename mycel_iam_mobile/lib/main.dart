import 'package:flutter/material.dart';
import 'package:mycel_core_mobile/mycel_core_mobile.dart';

import 'module.dart';
import 'screens/login/iam_login_screen.dart';

void main() => runApp(const MycelIamApp());

class MycelIamApp extends StatelessWidget {
  const MycelIamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MycelTheme.light(),
      darkTheme: MycelTheme.dark(),
      home: IamLoginScreen(
        onAuthenticated: (token) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => MycelShell(
                authToken: token,
                modules: [MycelIamModule()],
              ),
            ),
          );
        },
      ),
    );
  }
}
