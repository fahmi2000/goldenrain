import "package:flutter/material.dart";
import "package:gr4/models/user.dart";
import "package:gr4/screens/authenticate/authenticate.dart";
import "package:gr4/screens/home/home.dart";
import "package:provider/provider.dart";

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    print(user);

    //return to home or auth page
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
