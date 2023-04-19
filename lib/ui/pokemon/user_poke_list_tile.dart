import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:provider/provider.dart';

import '../screens.dart';

class UserPokeListTile extends StatelessWidget {
  final Pokemon pokemon;

  const UserPokeListTile(this.pokemon, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(pokemon.name),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(pokemon.imgUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            buildEditButton(context),
            buildDeleteButton(context),
          ],
        ),
      ),
    );
  }

  Widget buildDeleteButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () {
        context.read<PokeManager>().deletePokemon(pokemon.id);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text(
                'Pokemon removed',
                textAlign: TextAlign.center,
              ),
            ),
          );
      },
      color: Theme.of(context).colorScheme.error,
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditPokeScreen.routeName,
          arguments: pokemon.id,
        );
      },
      color: Theme.of(context).primaryColor,
    );
  }
}
