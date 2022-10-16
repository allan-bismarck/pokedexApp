import 'package:flutter/material.dart';
import 'package:pokedex/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon? pokemon;
  const PokemonCard({super.key, this.pokemon});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Card(
        color: pokemon!.color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: size.width * 0.27,
                child: pokemon!.sprites['front_default'] == null ? 
                  Container(
                    color: Colors.red, 
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text('Imagem não localizada',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: size.width * 0.035
                        ),
                      ),
                )) : Image.network(pokemon!.sprites['front_default'])),
            Column(
              children: [
                Text(
                  '${pokemon!.name.toUpperCase()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: size.width * 0.04
                  ),
                ),
                Text(
                  '${pokemon!.types}',
                  textAlign: TextAlign.center,
                )
              ],
            ),
            SizedBox(width: size.width * 0.08)
          ],
        ));
  }
}
