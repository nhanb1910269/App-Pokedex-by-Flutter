import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:pokedex/models/poke_team.dart';
import 'package:pokedex/models/your_team.dart';

class YourteamsManager with ChangeNotifier {
  final List<YourTeamItem> _yourteams = [
    YourTeamItem(
      id: 'o1',
      pokemons: [
        PokeTeam(
          id: 'c1',
          name: 'bulbasaur',
          quantity: 2,
        )
      ],
      dateTime: DateTime.now(),
    )
  ];

  void addYourteam(List<PokeTeam> poketeamPokemon) async {
    _yourteams.insert(
      0,
      YourTeamItem(
        id: 'o${DateTime.now().toIso8601String()}',
        pokemons: poketeamPokemon,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  int get yourteamCount {
    return _yourteams.length;
  }

  List<YourTeamItem> get yourteams {
    return [..._yourteams];
  }
}
