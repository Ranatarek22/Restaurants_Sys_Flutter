import 'package:flutter/material.dart';
import '/widgets/forms/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Access Your World",
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
            const Text(
              "Log In to Seamlessly Navigate Your Experience",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            const LoginForm(),
            const Divider(
              height: 40,
              color: Colors.black54,
            ),
            GestureDetector(
                onTap: () =>
                    Navigator.restorablePushNamed(context, "/register"),
                child: const Text(
                  "Don't have an account?",
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }
}
