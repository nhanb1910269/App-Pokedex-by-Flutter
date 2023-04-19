import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';
import '../../models/your_team.dart';

class YourteamItemCard extends StatefulWidget {
  final YourTeamItem yourteam;
  const YourteamItemCard(this.yourteam, {super.key});

  @override
  State<YourteamItemCard> createState() => _YourteamItemCardState();
}

class _YourteamItemCardState extends State<YourteamItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          buildYourteamSummary(),
          if (_expanded) buildYourteamDetails()
        ],
      ),
    );
  }

  Widget buildYourteamDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      height: min(widget.yourteam.pokemonCount * 20.0 + 10, 100),
      child: ListView(
        children: widget.yourteam.pokemons
            .map(
              (prod) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    prod.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildYourteamSummary() {
    return ListTile(
      title: Text('\$${widget.yourteam}'),
      subtitle: Text(
        DateFormat('dd/MM/yyyy hh:mm').format(widget.yourteam.dateTime),
      ),
      trailing: IconButton(
        icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
        onPressed: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
      ),
    );
  }
}

/*
Widget YourteamItemCard sử dụng thư viện intl để định dạng ngày tháng, khai báo thư viện trong
pubspec.yaml (chọn phiên bản mới nhất):
*/