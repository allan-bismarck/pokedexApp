import 'package:flutter/material.dart';
import 'package:pokedex/functions/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon? pokemon;
  const PokemonCard({super.key, this.pokemon});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double fontsize = size.width > size.height ? size.height : size.width;

    return Container(
      constraints: BoxConstraints(
        maxHeight: 120
      ),
      height: fontsize * 0.3,
      child: Card(
          elevation: 3,
          color: pokemon!.color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: fontsize * 0.27,
                  child: pokemon!.sprites == null
                      ? Container(
                          color: Colors.red,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Imagem não localizada',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontsize * 0.035),
                            ),
                          ))
                      : Image.network(pokemon!.sprites)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${pokemon!.name.toUpperCase()}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontsize * 0.035,
                        color: Colors.black),
                  ),
                  Text(
                    '${pokemon!.types}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontsize * 0.03,
                    ),
                  )
                ],
              ),
              SizedBox(width: fontsize * 0.08)
            ],
          )),
    );
  }
}
