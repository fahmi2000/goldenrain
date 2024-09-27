import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gr4/models/user.dart';
import 'package:gr4/screens/services/auth.dart';
import 'package:gr4/screens/wrapper.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
