import 'package:flutter/material.dart';
import 'package:pokedex/ui/pokemon/poke_detail_screen.dart';
import 'package:pokedex/ui/pokemon/poke_manager.dart';
import 'package:pokedex/ui/pokemon/poke_overview_screen.dart';
import 'package:pokedex/ui/pokemon/user_poke_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'LaTo',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.deepOrange,
        ),
      ),
      home: const SafeArea(
        child: PokeOverviewScreen(),
      ),
    );
  }
}
