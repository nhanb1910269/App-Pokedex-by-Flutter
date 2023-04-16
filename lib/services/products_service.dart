import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon.dart';
import '../models/auth_token.dart';

import 'firebase_service.dart';

class ProductService extends FirebaseService {
  ProductService([AuthToken? authToken]) : super(authToken);

  Future<List<Pokemon>> fetchProducts([bool filterByUser = false]) async {
    final List<Pokemon> pokemons = [];
    try {
      final filters =
          filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
      final productsUrl =
          Uri.parse('$databaseUrl/products.json?auth=$token&$filters');
      final response = await http.get(productsUrl);
      final productsMap = json.decode(response.body) as Map<String, dynamic>;

      if (response.statusCode != 200) {
        print(productsMap['error']);
        return pokemons;
      }
      final userFavoriteUrl =
          Uri.parse('$databaseUrl/userFavorites/$userId.json?auth=$token');
      final userFavoriteResponse = await http.get(userFavoriteUrl);
      final userFavoriteMap = json.decode(userFavoriteResponse.body);

      productsMap.forEach((productId, product) {
        final isFavorite = (userFavoriteMap == null)
            ? false
            : (userFavoriteMap[productId] ?? false);
        pokemons.add(
          Pokemon.fromJson({
            'id': productId,
            ...product,
          }).copyWith(isFavorite: isFavorite),
        );
      });
      return pokemons;
    } catch (error) {
      print(error);
      return pokemons;
    }
  }

  Future<Pokemon?> addPokemon(Pokemon pokemon) async {
    try {
      final url = Uri.parse('$databaseUrl/products.json?auth=$token');
      final response = await http.post(
        url,
        body: json.encode(
          pokemon.toJson()
            ..addAll({
              'creatorId: userId',
            } as Map<String, dynamic>),
        ),
      );
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return pokemon.copyWith(
        id: json.decode(response.body)['name'],
      );
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<bool> updatePokemon(Pokemon pokemon) async {
    try {
      final url =
          Uri.parse('$databaseUrl/products/${pokemon.id}.json?auth=$token');
      final response = await http.patch(
        url,
        body: json.encode(pokemon.toJson()),
      );
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> deletePokemon(String id) async {
    try {
      final url = Uri.parse('$databaseUrl/products/$id.json?auth=$token');
      final response = await http.delete(url);
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }

  Future<bool> saveFavoriteStatus(Pokemon pokemon) async {
    try {
      final url = Uri.parse(
          '$databaseUrl/userFavorites/$userId/${pokemon.id}.json?auth=$token');
      final response = await http.put(
        url,
        body: json.encode(
          pokemon.isFavorite,
        ),
      );
      if (response.statusCode != 200) {
        throw Exception(json.decode(response.body)['error']);
      }
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
}
