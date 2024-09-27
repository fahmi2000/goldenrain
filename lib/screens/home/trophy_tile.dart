import 'package:flutter/material.dart';
import '../../models/trophy.dart';

class TrophyTile extends StatelessWidget {
  const TrophyTile({Key? key, required this.trophy}) : super(key: key);

  final Trophy trophy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
            leading: CircleAvatar(backgroundColor: Colors.brown[trophy.z]),
            title: Text(trophy.x),
            subtitle: Text('Takes ${trophy.y} y')),
      ),
    );
  }
}
