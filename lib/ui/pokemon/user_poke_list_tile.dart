import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';

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
      onPressed: () {},
      color: Theme.of(context).colorScheme.error,
    );
  }

  Widget buildEditButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () {},
      color: Theme.of(context).primaryColor,
    );
  }
}
