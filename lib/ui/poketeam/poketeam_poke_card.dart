import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'poketeam_manager.dart';
import '../../models/poke_team.dart';
import '../shared/dialog_utils.dart';

class PoketeamPokeCard extends StatelessWidget {
  final String pokemonId;
  final PokeTeam pokeTeam;

  const PoketeamPokeCard({
    required this.pokemonId,
    required this.pokeTeam,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(pokeTeam.id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showConfirmDialog(
            context, 'Do you wanna remove this poke from your team?');
      },
      onDismissed: (direction) {
        context.read<poketeamManager>().removePoke(pokemonId);
      },
      child: buildItemCard(),
    );
  }

  Widget buildItemCard() {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: const CircleAvatar(),
          title: Text(pokeTeam.name),
          trailing: Text('${pokeTeam.quantity}x'),
        ),
      ),
    );
  }
}

/*
Widget Dismissible là widget có thể được loại bỏ (dismiss)
 bằng cách vuốt theo hướng chỉ định.
Một số thuộc tính quan trọng của Dismissable: key thuộc tính đùng định danh
 widget; direction chỉ định hướng vuốt widget (DismissDirection);
  background widget nền cho widget con; confirmDismiss
hàm được gọi để xác nhận loại bỏ, trả về true widget sẽ được loại bỏ,
 ngược lại quay về vị trí cũ;
onDismissed hàm được gọi sau khi widget đã được loại bỏ.


Widget FittedBox co giãn và bố trí con của nó theo tiêu chí 
được chỉ định bởi thuộc tính fit (mặc định là BoxFit.contain).
*/