import 'package:flutter/material.dart';

import 'poke_grid_tile.dart';
import 'poke_manager.dart';

class PokeGrid extends StatelessWidget {
  final bool showFavorites;

  const PokeGrid(
    this.showFavorites, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pokeManager = PokeManager();
    final pokemon =
        showFavorites ? pokeManager.favoriteItems : pokeManager.items;
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      itemCount: pokemon.length,
      itemBuilder: (ctx, i) => PokeGridTile(pokemon[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
