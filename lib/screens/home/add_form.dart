import "package:flutter/material.dart";
import "package:gr4/models/user.dart";
import "package:gr4/screens/services/database.dart";
import "package:gr4/shared/constant.dart";
import "package:gr4/shared/loading.dart";
import "package:provider/provider.dart";

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> y = ['0', '1', '2', '3', '4'];

  //form values
  late String _currentX = ''; // Initialize with an empty string
  late String _currentY = ''; // Initialize with an empty string
  late int _currentZ = 100; // Initialize with 0

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users?>(context);
    return StreamBuilder<UserData>(
        stream: user != null
            ? DatabaseService(uid: user.uid).userData.cast<UserData>()
            : null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Update your trophy customisation.',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  TextFormField(
                    initialValue: userData?.x,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentX = val),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentY == '' ? y[0] : y[0],
                    items: y.map((y) {
                      return DropdownMenuItem(
                          value: y, child: Text('$y [Placeholder y] '));
                    }).toList(),
                    onChanged: (value) {
                      setState(() => _currentY = value as String);
                    },
                  ),
                  Slider(
                    value: (_currentZ ?? 100).toDouble(),
                    activeColor: Colors.brown[_currentZ ?? 100],
                    inactiveColor: Colors.brown,
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (value) =>
                        setState(() => _currentZ = value.round()),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: user!.uid).updateUserData(
                          _currentX ?? userData?.x ?? '',
                          _currentY ?? userData?.y ?? '',
                          _currentZ ?? userData?.z ?? 0,
                        );
                        Navigator.pop(context);
                      }

                      // print(_currentX);
                      // print(_currentY);
                      // print(_currentZ);
                    },
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
