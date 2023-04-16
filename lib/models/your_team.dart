import 'poke_team.dart';

class YourTeamItem {
  final String? id;
  final List<PokeTeam> pokemons;
  final DateTime dateTime;

  int get pokemonCount {
    return pokemons.length;
  }

  YourTeamItem({
    this.id,
    required this.pokemons,
    DateTime? dateTime,
  }) : dateTime = dateTime ?? DateTime.now();

  YourTeamItem copyWith({
    String? id,
    List<PokeTeam>? pokemons,
    DateTime? dateTime,
  }) {
    return YourTeamItem(
      id: id ?? this.id,
      pokemons: pokemons ?? this.pokemons,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
