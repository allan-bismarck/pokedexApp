import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pokedex/animationPokebola.dart';
import 'package:pokedex/customFutureBuilder.dart';
import 'package:pokedex/pokemon.dart';
import 'package:pokedex/pokemonStats.dart';
import 'package:pokedex/pokemonList.dart';
import 'package:pokedex/service/api.dart';
import 'mobx/appStore.dart';
import 'myAppBar.dart';
import 'statusBarAnimation.dart';

class PokemonDetails extends StatefulWidget {
  final PokemonStats? pokemon;
  const PokemonDetails({super.key, this.pokemon});

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  List<bool> isSelected = [true, false, false];

  List<Widget> options = [
    Container(
      padding: EdgeInsets.all(10),
      child: Text('ATRIBUTOS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
    ),
    Container(
      padding: EdgeInsets.all(10),
      child: Text('EVOLUÇÕES',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
    ),
    Container(
      padding: EdgeInsets.all(10),
      child: Text('VARIANTES',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          )),
    )
  ];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.11),
            child: MyAppBar(title: 'Detalhes do Pokémon', fontsize: 0.66)),
        body: Stack(
          children: [
            Container(
              color: widget.pokemon!.color,
              height: size.height * 0.89,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ToggleButtons(
                        onPressed: (int index) {
                          setState(() {
                            for (int buttonIndex = 0;
                                buttonIndex < isSelected.length;
                                buttonIndex++) {
                              if (buttonIndex == index) {
                                isSelected[buttonIndex] = true;
                              } else {
                                isSelected[buttonIndex] = false;
                              }
                            }
                          });
                        },
                        children: options,
                        isSelected: isSelected,
                        borderRadius: BorderRadius.circular(10),
                        selectedColor: Colors.black,
                        fillColor: Colors.white,
                        color: Colors.black,
                      ),
                    ),
                    isSelected[0] == true
                        ? showAtributes(size)
                        : SingleChildScrollView(child: showContent())
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  showAtributes(size) {
    return Column(children: [
      Padding(
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
                    child: widget.pokemon!.sprites != null
                        ? Stack(children: [
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
                          ])
                        : Center(
                            child: Container(
                                child: Text(
                              'Imagem não localizada',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            )),
                          )),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Stack(
                              children: [
                                Text(
                                  '${widget.pokemon!.name.toUpperCase()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size.width * 0.035,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Tipo',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: size.width * 0.035,
                                color: Colors.black),
                          ),
                          Text(
                            '${widget.pokemon!.types}',
                            style: TextStyle(
                                fontSize: size.width * 0.035,
                                color: Colors.black),
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
                                fontSize: size.width * 0.035,
                                color: Colors.black),
                          ),
                          Text(
                            '${widget.pokemon!.abilities}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: size.width * 0.035,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10),
              ],
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                StatusBar(
                    title: 'Vida',
                    color: widget.pokemon!.color,
                    size: size,
                    value: widget.pokemon!.stats[0]['base_stat']),
                StatusBar(
                    title: 'Ataque',
                    color: widget.pokemon!.color,
                    size: size,
                    value: widget.pokemon!.stats[1]['base_stat']),
                StatusBar(
                    title: 'Defesa',
                    color: widget.pokemon!.color,
                    size: size,
                    value: widget.pokemon!.stats[2]['base_stat']),
                StatusBar(
                    title: 'Ataque Especial',
                    color: widget.pokemon!.color,
                    size: size,
                    value: widget.pokemon!.stats[3]['base_stat']),
                StatusBar(
                    title: 'Defesa Especial',
                    color: widget.pokemon!.color,
                    size: size,
                    value: widget.pokemon!.stats[4]['base_stat']),
                StatusBar(
                    title: 'Velocidade',
                    color: widget.pokemon!.color,
                    size: size,
                    value: widget.pokemon!.stats[5]['base_stat']),
              ],
            ),
          ),
        ),
      )
    ]);
  }

  Widget showContent() {
    String search;
    if (isSelected[1] == true) {
      search = 'evolutions';
    } else {
      search = 'varieties';
    }

    return CustomFutureBuilder<List<Pokemon>>(
      future: getEvolutionsOrVarieties(search),
      onComplete: (context, data) {
        var size = MediaQuery.of(context).size;
        return data[0].name == '' ? Container(
          color: Color.fromARGB(62, 0, 0, 0),
          height: size.height * 0.89,
          width: size.width,
          child: Center(
            child: Container(
              width: size.width * 0.7,
              child: Text(
                'Não há pokémons a serem exibidos',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
            ),
          ),
        ) : 
          Container(
            color: Color.fromARGB(62, 0, 0, 0),
            height: size.height * 0.89,
            child: SingleChildScrollView(
              child: PokemonList(pokemonList: data),
            ));
      },
      onEmpty: ((context) {
        print('empty');
        return Center(child: Text('Não há Pokémons a ser exibidos'));
      }),
      onLoading: ((context) {
        print('loading');
        var size = MediaQuery.of(context).size;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: size.height * 0.2),
            AnimationPokebola(
                legend: 'Carregando...', color: widget.pokemon!.color),
          ],
        );
      }),
      onError: ((context, error) {
        print('error');
        return Center(child: Text(error.toString()));
      }),
    );
  }

  Future<List<Pokemon>> getEvolutionsOrVarieties(search) async {
    var content = await api().myRequest('pokemon/${widget.pokemon!.name}');
    var species;
    species = content['species']['url'];
    species = species.split('/');
    species = species[species.length - 2];
    species = await api().myRequest('pokemon-species/$species');
    if (search == 'evolutions') {
      if (species['evolution_chain'] == null) {
        content = [Pokemon()];
      } else {
        content = species['evolution_chain']['url'];
        content = content.split('/');
        content = content[content.length - 2];
        content = await api().myRequest('evolution-chain/${content}');
        content = content['chain'];
        content = extracEvolutionsFromPokemon(content);
        var listEvolutions = await AppStore().mapNameforPokemon(content);
        content = listEvolutions;
      }
    } else {
      if (species['varieties'] == null) {
        content = [Pokemon()];
      } else {
        content = species['varieties'];
        var listPokemons = extractNamesFromPokemons(content);
        listPokemons = await AppStore().mapNameforPokemon(listPokemons);
        content = listPokemons;
      }
    }

    return content;
  }

  extracEvolutionsFromPokemon(list) {
    var temp = list;
    var temp2 = [];
    temp2.add(temp['species']['name']);
    temp = temp['evolves_to'];
    for (int index = 0; index < temp.length; index++) {
      temp2.add(temp[index]['species']['name']);
      if (temp[index]['evolves_to'] != []) {
        var temp3 = temp;
        temp3 = temp[index]['evolves_to'];
        for (int x = 0; x < temp3.length; x++) {
          temp2.add(temp3[x]['species']['name']);
        }
      }
    }
    return temp2;
  }

  extractNamesFromPokemons(listPokemons) {
    var temp = [];
    for (int index = 0; index < listPokemons.length; index++) {
      temp.add(listPokemons[index]['pokemon']['name']);
    }

    return temp;
  }
}
