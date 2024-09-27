import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gr4/models/trophy.dart';
import 'package:gr4/screens/home/add_form.dart';
import 'package:gr4/screens/home/trophy_list.dart';
import 'package:gr4/screens/services/auth.dart';
import 'package:gr4/screens/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showAddPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: AddForm(),
            );
          });
    }

    return StreamProvider<List<Trophy>?>.value(
      value: DatabaseService(uid: '').trophy,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Osem Salmon'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            ElevatedButton.icon(
              icon: Icon(Icons.person),
              label: Text('logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.plus_one),
              label: Text('Add'),
              onPressed: () => _showAddPanel(),
            ),
          ],
        ),
        body: TrophyList(),
      ),
    );
  }
}
