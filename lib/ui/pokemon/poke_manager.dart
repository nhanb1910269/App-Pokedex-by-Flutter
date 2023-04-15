import '../../models/pokemon.dart';

class PokeManager {
  final List<Pokemon> _items = [
    Pokemon(
      id: '1',
      name: 'bulbasaur',
      type: 'grass',
      type2: 'poison',
      imgUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      isFavorite: false,
    ),
    Pokemon(
      id: '2',
      name: 'ivysaur',
      type: 'grass',
      type2: 'poison',
      imgUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
      isFavorite: false,
    ),
    Pokemon(
      id: '3',
      name: 'venusaur',
      type: 'grass',
      type2: 'poison',
      imgUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png',
      isFavorite: false,
    ),
    Pokemon(
      id: '4',
      name: 'charmander',
      type: 'fire',
      type2: '',
      imgUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
      isFavorite: false,
    ),
    Pokemon(
      id: '5',
      name: 'charmeleon',
      type: 'fire',
      type2: '',
      imgUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png',
      isFavorite: false,
    ),
    Pokemon(
      id: '6',
      name: 'charizard',
      type: 'fire',
      type2: 'flying',
      imgUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png',
      isFavorite: false,
    ),
  ];

  int get itemCount {
    return _items.length;
  }

  List<Pokemon> get items {
    return [..._items];
  }

  List<Pokemon> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }
}
