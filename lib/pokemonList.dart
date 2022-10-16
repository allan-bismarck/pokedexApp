import 'package:flutter/material.dart';
import 'package:pokedex/pokemon.dart';
import 'package:pokedex/pokemonCard.dart';
import 'package:pokedex/service/api.dart';
import 'package:provider/provider.dart';
import 'mobx/appStore.dart';

class PokemonList extends StatefulWidget {
  const PokemonList({super.key});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  @override
  Widget build(BuildContext context) {
    final appStore = Provider.of<AppStore>(context);
    var content = appStore.getContent();

    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Pokémons'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => SizedBox(height: 1),
                itemCount: content == null ? 1 : content.length,
                itemBuilder: (context, index) {
                  return content == null
                      ? Text('Nenhum item a ser exibido')
                      : PokemonCard(pokemon: content[index]);
                },
              )
            ],
          ),
        ));
  }
}
