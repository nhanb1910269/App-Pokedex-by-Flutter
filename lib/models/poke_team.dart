class PokeTeam {
  final String id;
  final String name;
  final int quantity;

  PokeTeam({
    required this.id,
    required this.name,
    required this.quantity,
  });

  PokeTeam copyWith({
    String? id,
    String? name,
    int? quantity,
  }) {
    return PokeTeam(
        id: id ?? this.id,
        name: name ?? this.name,
        quantity: quantity ?? this.quantity);
  }
}
