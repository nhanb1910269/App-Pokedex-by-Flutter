import 'package:flutter/foundation.dart';
import '../../models/poke_team.dart';

class poketeamManager with ChangeNotifier {
  Map<String, PokeTeam> _items = {
    '1': PokeTeam(
      id: 'c1',
      name: 'bulbasaur',
      quantity: 2,
    ),
  };

  void addPoke(PokeTeam pokeTeam) {
    if (_items.containsKey(pokeTeam.id)) {
      _items.update(
        pokeTeam.id!,
        (existingPokeTeam) => existingPokeTeam.copyWith(
          quantity: existingPokeTeam.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        pokeTeam.id!,
        () => PokeTeam(
          id: 'c${DateTime.now().toIso8601String()}',
          name: pokeTeam.name,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removePoke(String pokemonId) {
    _items.remove(pokemonId);
    notifyListeners();
  }

  void removeSinglePoke(String pokemonId) {
    if (_items.containsKey(pokemonId)) {
      return;
    }
    if (_items[pokemonId]?.quantity as num > 1) {
      _items.update(
        pokemonId,
        (existingPokeTeam) => existingPokeTeam.copyWith(
          quantity: existingPokeTeam.quantity - 1,
        ),
      );
    } else {
      _items.remove(pokemonId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  int get pokeCount {
    return _items.length;
  }

  List<PokeTeam> get pokemons {
    return _items.values.toList();
  }

  Iterable<MapEntry<String, PokeTeam>> get pokeEntries {
    return {..._items}.entries;
  }
}
