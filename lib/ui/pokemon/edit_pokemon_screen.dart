import 'package:flutter/material.dart';
import 'package:pokedex/ui/poketeam/poketeam_manager.dart';
import 'package:provider/provider.dart';
import '../../models/pokemon.dart';
import 'poke_manager.dart';

class EditPokeScreen extends StatefulWidget {
  static const routeName = '/edit-pokemon';
  EditPokeScreen(
    Pokemon? pokemon, {
    super.key,
  }) {
    if (pokemon == null) {
      this.pokemon = Pokemon(
        id: '',
        name: '',
        type: '',
        type2: '',
        imgUrl: '',
      );
    } else {
      this.pokemon = pokemon;
    }
  }
  late final Pokemon pokemon;
  @override
  State<EditPokeScreen> createState() => _EditPokeScreenState();
}

class _EditPokeScreenState extends State<EditPokeScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _editForm = GlobalKey<FormState>();
  late Pokemon _editedPokemon;
  var _isLoading = false;
  bool _isValidImageUrl(String value) {
    return (value.startsWith('http') || value.startsWith('https')) &&
        (value.endsWith('.png') ||
            value.endsWith('.jpg') ||
            value.endsWith('.jpeg'));
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      if (!_imageUrlFocusNode.hasFocus) {
        if (!_isValidImageUrl(_imageUrlController.text)) {
          return;
        }
        setState(() {});
      }
    });
    _editedPokemon = widget.pokemon;
    _imageUrlController.text = _editedPokemon.imgUrl;
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _editForm.currentState!.validate();
    if (!isValid) {
      return;
    }
    _editForm.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final pokeManager = context.read<PokeManager>();
      if (_editedPokemon.id != null) {
        pokeManager.updatePokemon(_editedPokemon);
      } else {
        pokeManager.addPokemon(_editedPokemon);
      }
    } catch (error) {
      await showErrorDialog(context, 'Something went wrong!');
    }
    setState(() {
      _isLoading = true;
    });
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Pokemon'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _editForm,
                child: ListView(
                  children: <Widget>[
                    buildPokemonPreview(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget buildPokemonPreview() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.only(
            top: 8,
            right: 10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: _imageUrlController.text.isEmpty
              ? const Text('Enter a URL')
              : FittedBox(
                  child: Image.network(
                    _imageUrlController.text,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        Expanded(
          child: buildImageURLField(),
        ),
      ],
    );
  }

  TextFormField buildImageURLField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Image URL'),
      keyboardType: TextInputType.url,
      textInputAction: TextInputAction.done,
      controller: _imageUrlController,
      focusNode: _imageUrlFocusNode,
      onFieldSubmitted: (value) => _saveForm(),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter an image URL!';
        }
        if (!_isValidImageUrl(value)) {
          return 'Please enter a valid image URL!';
        }
        return null;
      },
      onSaved: (value) {
        _editedPokemon = _editedPokemon.copyWith(imgUrl: value);
      },
    );
  }

  Future<void> showErrorDialog(BuildContext context, String message) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}
