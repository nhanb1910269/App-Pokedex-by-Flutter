import 'package:flutter/material.dart';

import '../../models/pokemon.dart';

class PokeDetailScreen extends StatelessWidget {
  static const routeName = '/poke-detail';
  const PokeDetailScreen(
    this.pokemon, {
    super.key,
    required,
  });

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                pokemon.imgUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                pokemon.type,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                pokemon.type2,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            )
          ],
        ),
      ),
    );
  }
}
