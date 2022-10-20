import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pokedex/pokemonStats.dart';

class PokemonDetails extends StatefulWidget {
  final PokemonStats? pokemon;
  const PokemonDetails({super.key, this.pokemon});

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Detalhes do Pokémon'),
        ),
        body: Container(
          color: widget.pokemon!.color,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  '${widget.pokemon!.name.toUpperCase()}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: size.width * 0.06),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: size.width * 0.4,
                            height: size.width * 0.4,
                            decoration: BoxDecoration(
                                color: widget.pokemon!.color,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                    style: BorderStyle.solid,
                                    color: Color.fromARGB(255, 151, 151, 151))),
                            padding: EdgeInsets.all(10),
                            child: Stack(children: [
                              Opacity(
                                  child: Image.network(widget.pokemon!.sprites,
                                      filterQuality: FilterQuality.low,
                                      color: Colors.black),
                                  opacity: 0.5),
                              ClipRect(
                                  child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5.0, sigmaY: 5.0),
                                      child: Image.network(
                                          widget.pokemon!.sprites))),
                            ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      'Tipo',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.035),
                                    ),
                                    Text(
                                      '${widget.pokemon!.types}',
                                      style: TextStyle(
                                          fontSize: size.width * 0.035),
                                    )
                                  ],
                                ),
                                SizedBox(height: 10),
                                Column(
                                  children: [
                                    Text(
                                      'Habilidades',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: size.width * 0.035),
                                    ),
                                    Text(
                                      '${widget.pokemon!.abilities}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: size.width * 0.035),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  'ATRIBUTOS',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: size.width * 0.04),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: Column(
                        children: [
                          StatusBar(title: 'Vida', color: widget.pokemon!.color, size: size, value: size.width * 0.9 * 0.5),
                          StatusBar(title: 'Ataque', color: widget.pokemon!.color, size: size, value: size.width * 0.9 * 0.5),
                          StatusBar(title: 'Defesa', color: widget.pokemon!.color, size: size, value: size.width * 0.9 * 0.5),
                          StatusBar(title: 'Ataque Especial', color: widget.pokemon!.color, size: size, value: size.width * 0.9 * 0.5),
                          StatusBar(title: 'Defesa Especial', color: widget.pokemon!.color, size: size, value: size.width * 0.9 * 0.5),
                          StatusBar(title: 'Velocidade', color: widget.pokemon!.color, size: size, value: size.width * 0.9 * 0.5),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Expanded(
              //   child: Card(
              //     child: Text('Evoluções'),
              //     color: Colors.amber,
              //   ),
              // ),
            ],
          ),
        ));
  }
}

class StatusBar extends StatelessWidget {
  final String? title;
  final color;
  final double? value;
  final size;
  const StatusBar({super.key, this.title, this.color, this.value, this.size});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title!,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.height * 0.021
              ),
            ),
          )
        ),
        Stack(
          children: [
            Container(
              height: 22,
              width: size.width * 0.9,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 49, 49, 49),
                  borderRadius: BorderRadius.circular(20),
              ),
            ),
            Container(
              height: 22,
              width: size.width * 0.9 * 0.5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  style: BorderStyle.solid,
                  width: 1,
                  color: Color.fromARGB(78, 0, 0, 0)
                )
              ),
            ),
          ],
        ),
        SizedBox(height: 5)
      ],
    );
  }
}
