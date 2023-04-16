import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens.dart';
import '../shared/app_drawer.dart';
import 'user_poke_list_tile.dart';
import 'poke_manager.dart';

class UserPokeScreen extends StatelessWidget {
  static const routeName = '/user-poke';
  const UserPokeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pokeManager = PokeManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          buildAddButton(context),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
          onRefresh: () async => print('something'),
          child: buildUserPokeListView(pokeManager)),
    );
  }

  Widget buildUserPokeListView(PokeManager pokeManager) {
    return Consumer<PokeManager>(
      builder: (ctx, pokeManager, child) {
        return ListView.builder(
          itemCount: pokeManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserPokeListTile(
                pokeManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditPokeScreen.routeName,
        );
      },
    );
  }
}
