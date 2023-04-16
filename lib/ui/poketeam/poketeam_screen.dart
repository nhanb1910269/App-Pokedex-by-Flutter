import 'package:flutter/material.dart';
import 'package:pokedex/ui/pokemon/poke_manager.dart';
import 'package:pokedex/ui/yourteam/yourteam_manager.dart';
import 'package:provider/provider.dart';
//import 'package:provider/provider.dart';

import 'poketeam_manager.dart';
import 'poketeam_poke_card.dart';

class PoketeamScreen extends StatelessWidget {
  static const routeName = '/poketeam';

  const PoketeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final poketeam = context.watch<poketeamManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Team'),
      ),
      body: Column(
        children: <Widget>[
          buildPoketeamSummary(poketeam, context),
          const SizedBox(height: 10),
          Expanded(
            child: buildPoketeamDetails(poketeam),
          )
        ],
      ),
    );
  }

  Widget buildPoketeamDetails(poketeamManager poketeam) {
    return ListView(
      children: poketeam.pokeEntries
          .map(
            (entry) => PoketeamPokeCard(
              pokemonId: entry.key,
              pokeTeam: entry.value,
            ),
          )
          .toList(),
    );
  }

  Widget buildPoketeamSummary(poketeamManager poketeam, BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Total',
              style: TextStyle(fontSize: 20),
            ),
            TextButton(
              onPressed: () {
                context.read<YourteamsManager>().addYourteam(
                      poketeam.pokemons,
                    );
                poketeam.clear();
              },
              style: TextButton.styleFrom(
                textStyle: TextStyle(color: Theme.of(context).primaryColor),
              ),
              child: const Text('Add Now'),
            )
          ],
        ),
      ),
    );
  }
}
