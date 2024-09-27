import "package:flutter/material.dart";
import "package:gr4/screens/authenticate/register.dart";
import "package:gr4/screens/authenticate/sign_in.dart";

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView, key: const ValueKey('signin'));
    } else {
      return Register(toggleView: toggleView, key: const ValueKey('register'));
    }
  }
}
