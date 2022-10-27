import 'package:flutter/material.dart';
import 'package:pokedex/pokemon.dart';
import 'package:pokedex/pokemonCard.dart';
import 'package:pokedex/pokemonDetails.dart';
import 'package:pokedex/pokemonStats.dart';

class PokemonList extends StatefulWidget {
  final List<Pokemon>? pokemonList;
  const PokemonList({super.key, this.pokemonList});

  @override
  State<PokemonList> createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 500,
        ),
        child: Column(
          children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.pokemonList == null
                ? 1
                : widget.pokemonList!.length,
            itemBuilder: (context, index) {
              return widget.pokemonList == null
                ? Text('Nenhum item a ser exibido')
                : InkWell(
                    onTap: () async {
                      var pokemon = PokemonStats();
                      pokemon = await pokemon.getPokemon(
                          widget.pokemonList![index].name);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PokemonDetails(pokemon: pokemon)),
                      );
                    },
                    child:
                        PokemonCard(pokemon: widget.pokemonList![index]));
            },
          )
        ]),
      ),
    );
  }
}
