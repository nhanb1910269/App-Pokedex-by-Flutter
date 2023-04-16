import 'package:flutter/material.dart';
import 'package:pokedex/models/poke_team.dart';
import 'package:pokedex/ui/screens.dart';
import 'package:provider/provider.dart';

import '../../models/pokemon.dart';

class PokeGridTile extends StatelessWidget {
  const PokeGridTile(this.pokemon, {super.key});

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: buildGridFooterBar(context),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              PokeDetailScreen.routeName,
              arguments: pokemon.id,
            );
          },
          child: Image.network(
            pokemon.imgUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget buildGridFooterBar(BuildContext context) {
    return GridTileBar(
      leading: ValueListenableBuilder<bool>(
        valueListenable: pokemon.isFavoriteListenable,
        builder: (ctx, isFavorite, child) {
          return IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              final poketeam = context.read<poketeamManager>();
              poketeam.addPoke(pokemon as PokeTeam);
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: const Text(
                      'Pokemon has added to team',
                    ),
                    duration: const Duration(seconds: 2),
                    action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        poketeam.removeSinglePoke(pokemon.id!);
                      },
                    ),
                  ),
                );
            },
          );
        },
      ),
      title: Text(
        style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        pokemon.name,
        textAlign: TextAlign.center,
      ),
      trailing: IconButton(
        icon: const Icon(
          Icons.add,
        ),
        onPressed: () {},
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
