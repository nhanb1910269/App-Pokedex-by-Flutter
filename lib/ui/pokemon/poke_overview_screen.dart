import 'package:flutter/material.dart';
import 'poke_grid.dart';

enum FilterOptions { favorites, all }

class PokeOverviewScreen extends StatefulWidget {
  const PokeOverviewScreen({super.key});

  @override
  State<PokeOverviewScreen> createState() => _PokeOverviewScreenState();
}

class _PokeOverviewScreenState extends State<PokeOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        actions: <Widget>[
          buildPokeFilterMenu(),
          buildPokeTeamIcon(),
        ],
      ),
      body: PokeGrid(_showOnlyFavorites),
    );
  }

  Widget buildPokeFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        if (selectedValue == FilterOptions.favorites) {
          _showOnlyFavorites = true;
        } else {
          _showOnlyFavorites = false;
        }
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorites'),
        ),
        const PopupMenuItem(value: FilterOptions.all, child: Text('Show All'))
      ],
    );
  }

  Widget buildPokeTeamIcon() {
    return IconButton(
      icon: const Icon(
        Icons.group_add,
      ),
      onPressed: () {},
    );
  }
}
