import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:pokedex/components/animationPokebola.dart';
import 'package:pokedex/components/customFutureBuilder.dart';
import 'package:pokedex/functions/pokemon.dart';
import 'package:pokedex/components/pokemonStats.dart';
import 'package:pokedex/components/pokemonList.dart';
import 'package:pokedex/service/service.dart';
import '../functions/extractor.dart';
import '../functions/mapper.dart';
import '../components/myAppBar.dart';
import '../components/statusBarAnimation.dart';

class PokemonDetails extends StatefulWidget {
  final PokemonStats? pokemon;
  const PokemonDetails({super.key, this.pokemon});

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double fontsize = size.width > size.height * 0.8 ? size.height : size.width;

    List<Widget> options = [
    Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text('ATRIBUTOS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: fontsize * 0.03
        )),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text('EVOLUÇÕES',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontsize * 0.03
            )),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text('VARIANTES',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontsize * 0.03
            )),
      )
    ];

    return Scaffold(
        backgroundColor: widget.pokemon!.color,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.11),
            child: MyAppBar(title: 'Detalhes do Pokémon')),
        body: Center(
          child: Stack(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 500
                ),
                height: size.height * 0.89,
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 5),
                      Container(
                        height: fontsize * 0.12,
                        padding: const EdgeInsets.symmetric(vertical: 2),
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
                          ? showAtributes(size, fontsize)
                          : SingleChildScrollView(child: showContent())
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  showAtributes(size, fontsize) {
    return Column(
      children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  constraints: BoxConstraints(
                    maxWidth: 200,
                    maxHeight: 200
                  ),
                    width: size.width * 0.33,
                    height: size.width * 0.33,
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
                                    fontSize: fontsize * 0.04,
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
                                      fontSize: fontsize * 0.03,
                                      color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'Tipo',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: fontsize * 0.03,
                                color: Colors.black),
                          ),
                          Text(
                            '${widget.pokemon!.types}',
                            style: TextStyle(
                                fontSize: fontsize * 0.03,
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
                                fontSize: fontsize * 0.03,
                                color: Colors.black),
                          ),
                          Text(
                            '${widget.pokemon!.abilities}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: fontsize * 0.03,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
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
        return data[0].name == ''
            ? Container(
                color: Color.fromARGB(62, 0, 0, 0),
                height: size.height * 0.89,
                width: size.width,
                child: Center(
                  child: Container(
                    width: size.width * 0.7,
                    child: Text(
                      'Não há pokémons a serem exibidos',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ),
              )
            : Container(
                color: Color.fromARGB(62, 0, 0, 0),
                child: SingleChildScrollView(
                  child: PokemonList(pokemonList: data),
                ));
      },
      onEmpty: ((context) {
        return Center(child: Text('Não há Pokémons a ser exibidos'));
      }),
      onLoading: ((context) {
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
        return Center(child: Text(error.toString()));
      }),
    );
  }

  Future<List<Pokemon>> getEvolutionsOrVarieties(search) async {
    var mapper = Mapper();
    var apiService = ApiService();
    var extractor = Extractor();
    var content = await apiService.myRequest('pokemon/${widget.pokemon!.name}');
    var species;
    species = content['species']['url'];
    species = species.split('/');
    species = species[species.length - 2];
    species = await apiService.myRequest('pokemon-species/$species');
    if (search == 'evolutions') {
      if (species['evolution_chain'] == null) {
        content = [Pokemon()];
      } else {
        content = species['evolution_chain']['url'];
        content = content.split('/');
        content = content[content.length - 2];
        content = await apiService.myRequest('evolution-chain/$content');
        content = content['chain'];
        content = extractor.extractEvolutionsFromPokemon(content);
        var listEvolutions = await mapper.mapNameforPokemon(content);
        content = listEvolutions;
      }
    } else {
      if (species['varieties'] == null) {
        content = [Pokemon()];
      } else {
        content = species['varieties'];
        var listPokemons = extractor.extractNamesFromPokemons(content, 'pokemonDetails');
        listPokemons = await mapper.mapNameforPokemon(listPokemons);
        content = listPokemons;
      }
    }

    return content;
  }

}
