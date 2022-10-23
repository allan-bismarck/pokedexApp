import 'package:flutter/material.dart';
import 'package:pokedex/customFutureBuilder.dart';
import 'package:pokedex/pokemon.dart';
import 'package:pokedex/pokemonList.dart';
import 'package:provider/provider.dart';
import 'mobx/appStore.dart';

class PokemonListScreen extends StatefulWidget {
  final String? namePokemon;
  const PokemonListScreen({super.key, this.namePokemon});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  @override
  Widget build(BuildContext context) {
    final appStore = Provider.of<AppStore>(context);
    var content;

    if (widget.namePokemon == null) {
      content = appStore.pokemonSearchByToggleButtons();
    } else {
        content = appStore.pokemonSearchByWord(widget.namePokemon!);
    }

    return CustomFutureBuilder<List<Pokemon>>(
          future: content,
          onComplete: (context, data) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Lista de Pokémons'),
              ),
              body: SingleChildScrollView(
              child: Container(
                  color: data[0].color,
                  child: PokemonList(pokemonList: data)
                ),
              )
            );
          },
          onEmpty: ((context) {
            print('empty');
            return Center(child: Text('Não há Pokémons a ser exibidos'));
          }),
          onLoading: ((context) {
            print('loading');
            return Scaffold(
              body: Center(child: Text('Carregando...'))
            );
          }),
          onError: ((context, error) {
            print('error');
            return Center(child: Text(error.toString()));
          }),
        );
  }
}
