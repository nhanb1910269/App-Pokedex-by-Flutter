import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'yourteam_item_card.dart';
import 'yourteam_manager.dart';

import '../shared/app_drawer.dart';

class YourteamScreen extends StatelessWidget {
  static const routeName = '/orders';
  const YourteamScreen({super.key});
  @override
  Widget build(BuildContext context) {
    print('building team');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Poke Team'),
      ),
      drawer: const AppDrawer(),
      body: Consumer<YourteamsManager>(
        builder: (ctx, yourteamsManager, child) {
          return ListView.builder(
            itemCount: yourteamsManager.yourteamCount,
            itemBuilder: (ctx, i) =>
                YourteamItemCard(yourteamsManager.yourteams[i]),
          );
        },
      ),
    );
  }
}
