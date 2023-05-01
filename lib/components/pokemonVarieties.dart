import 'package:flutter/material.dart';
import 'package:pokedex/components/pokemonCard.dart';
import 'package:pokedex/components/pokemonStats.dart';
import 'package:pokedex/screens/pokemonDetails.dart';

import '../functions/pokemon.dart';

class PokemonVarieties extends StatefulWidget {
  final List<Pokemon>? pokemonVarieties;
  const PokemonVarieties({super.key, this.pokemonVarieties});

  @override
  State<PokemonVarieties> createState() => _PokemonVarietiesState();
}

class _PokemonVarietiesState extends State<PokemonVarieties> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 1),
          itemCount: widget.pokemonVarieties == null
              ? 1
              : widget.pokemonVarieties!.length,
          itemBuilder: (context, index) {
            return widget.pokemonVarieties == null
                ? Text('Nenhum item a ser exibido')
                : InkWell(
                    onTap: () async {
                      var pokemon = PokemonStats();
                      pokemon = await pokemon.getPokemon(
                          widget.pokemonVarieties![index].name);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PokemonDetails(pokemon: pokemon)),
                      );
                    },
                    child:
                        PokemonCard(pokemon: widget.pokemonVarieties![index]));
          },
        )
      ]),
    );
  }
}
