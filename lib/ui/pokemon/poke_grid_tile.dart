import 'package:flutter/material.dart';

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
          onTap: () {},
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
      leading: IconButton(
        icon: Icon(
          pokemon.isFavorite ? Icons.favorite : Icons.favorite_border,
        ),
        color: Theme.of(context).colorScheme.secondary,
        onPressed: () {},
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
