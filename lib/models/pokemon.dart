import 'package:flutter/foundation.dart';

class Pokemon {
  final String id;
  final String name;
  final String imgUrl;
  final String type;
  final String type2;
  final ValueNotifier<bool> _isFavorite;

  Pokemon({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.type,
    required this.type2,
    isFavorite = false,
  }) : _isFavorite = ValueNotifier(isFavorite);

  set isFavorite(bool newValue) {
    _isFavorite.value = newValue;
  }

  bool get isFavorite {
    return _isFavorite.value;
  }

  ValueNotifier<bool> get isFavoriteListenable {
    return _isFavorite;
  }

  Pokemon copyWith({
    String? id,
    String? name,
    String? imgUrl,
    String? type,
    String? type2,
    bool? isFavorite,
  }) {
    return Pokemon(
        id: id ?? this.id,
        name: name ?? this.name,
        imgUrl: imgUrl ?? this.imgUrl,
        type: type ?? this.type,
        type2: type2 ?? this.type2);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'type': type,
      'type2': type2,
    };
  }

  static Pokemon fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imgUrl: json['imgUrl'],
      type: json['type'],
      type2: json['type2'],
    );
  }
}
