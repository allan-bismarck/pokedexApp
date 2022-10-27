import 'package:flutter/material.dart';
import 'package:pokedex/animationPokebola.dart';
import 'package:pokedex/customFutureBuilder.dart';
import 'package:pokedex/pokemon.dart';
import 'package:pokedex/pokemonList.dart';
import 'package:provider/provider.dart';
import 'mobx/appStore.dart';
import 'myAppBar.dart';

class PokemonListScreen extends StatefulWidget {
  final String? namePokemon;
  const PokemonListScreen({super.key, this.namePokemon});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
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
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.11),
            child: MyAppBar(title: 'Lista de Pokémons'),
          ),
          body: Stack(
            children: [
              Container(
                height: size.height * 0.89,
                color: data[0].color,
              ),
              Container(
                height: size.height * 0.89,
                color: Color.fromARGB(62, 0, 0, 0),
                child: SingleChildScrollView(
                  child: PokemonList(pokemonList: data),
                ),
              ),
            ],
          ));
      },
      onEmpty: ((context) {
        print('empty');
        return Center(child: Text('Não há Pokémons a ser exibidos'));
      }),
      onLoading: ((context) {
        print('loading');
        return Scaffold(
          body: AnimationPokebola(legend: 'Carregando...'),
        );
      }),
      onError: ((context, error) {
        print('error');
        return Center(child: Text(error.toString()));
      }),
    );
  }
}
