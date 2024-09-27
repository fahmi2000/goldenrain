import "package:flutter/material.dart";
import "package:gr4/models/trophy.dart";
import "package:gr4/screens/home/trophy_tile.dart";
import "package:provider/provider.dart";

class TrophyList extends StatefulWidget {
  const TrophyList({super.key});

  @override
  State<TrophyList> createState() => _TrophyListState();
}

class _TrophyListState extends State<TrophyList> {
  @override
  Widget build(BuildContext context) {
    final trophy = Provider.of<List<Trophy>?>(context) ?? [];

    return ListView.builder(
      itemCount: trophy?.length ?? 0,
      itemBuilder: (context, index) {
        return TrophyTile(trophy: trophy![index]);
      },
    );
  }
}
