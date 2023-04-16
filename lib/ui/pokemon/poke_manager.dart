import 'package:flutter/material.dart';
import 'package:pokedex/services/products_service.dart';
import '../../models/auth_token.dart';
import '../../models/pokemon.dart';

class PokeManager with ChangeNotifier {
  final List<Pokemon> _items = [
    Pokemon(
      id: '1',
      name: 'bulbasaur',
      type: 'grass',
      type2: 'poison',
      imgUrl:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      isFavorite: true,
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

  final ProductService _productService;

  PokeManager([AuthToken? authToken])
      : _productService = ProductService(authToken);

  set authToken(AuthToken? authToken) {
    _productService.authToken = authToken;
  }

/*
  Future<void> fetchProducts([bool filterByUser = false]) async {
    _items = await _productService.fetchProducts(filterByUser);
    notifyListeners();
  }

  Future<void> addPokemon(Pokemon pokemon) async {
    final newProduct = await _productService.addPokemon(pokemon);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updatePokemon(Pokemon pokemon) async {
    final index = _items.indexWhere((item) => item.id == pokemon.id);
    if (index >= 0) {
      if (await _productService.updatePokemon(pokemon)) {
        _items[index] = pokemon;
        notifyListeners();
      }
    }
  }

  Future<void> deletePokemon(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    Pokemon? existingProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();

    if (!await _productService.deletePokemon(id)) {
      _items.insert(index, existingProduct);
      notifyListeners();
    }
  }

  Future<void> toggleFavoriteStatus(Pokemon pokemon) async {
    final savedStatus = pokemon.isFavorite;
    pokemon.isFavorite = !savedStatus;

    if (!await _productService.saveFavoriteStatus(pokemon)) {
      pokemon.isFavorite = savedStatus;
    }
  }
  */
  Pokemon findById(String id) {
    return _items.firstWhere((item) => item.id == id);
  }

  void addPokemon(Pokemon pokemon) {
    _items.add(
      pokemon.copyWith(
        id: 'p${DateTime.now().toIso8601String()}',
      ),
    );
    notifyListeners();
  }

  void updatePokemon(Pokemon pokemon) {
    final index = _items.indexWhere((item) => item.id == pokemon.id);
    if (index >= 0) {
      _items[index] = pokemon;
      notifyListeners();
    }
  }

  void deletePokemon(String id) {
    final index = _items.indexWhere((item) => item.id == id);
    _items.removeAt(index);
    notifyListeners();
  }

  void toggleFavoriteStatus(Pokemon pokemon) {
    final saveStatus = pokemon.isFavorite;
    pokemon.isFavorite = !saveStatus;
  }

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
