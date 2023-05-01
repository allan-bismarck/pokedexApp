import 'dart:ui';
import 'package:pokedex/service/service.dart';

import '../functions/colors.dart';
import '../functions/extractor.dart';

class PokemonStats {
  String abilities = '';
  String name = '';
  String types = '';
  List<dynamic> stats = [];
  var sprites;
  Color color = Color.fromARGB(255, 255, 255, 255);

  getPokemon(name) async {
    var extractor = Extractor();
    var pokemon = PokemonStats();
    var content = await ApiService().myRequest('pokemon/$name');
    pokemon.name = content['name'];
    pokemon.types = extractor.extractTypesFromPokemonStats(content['types']);
    pokemon.color = ColorsBackground().getColor(pokemon.types, ', ');
    pokemon.sprites = content['sprites']['other']['home']['front_default'];
    var tempAbilities = extractor.extractAbilityNames(content['abilities']);
    pokemon.abilities = extractor.extractAbilitiesFromPokemon(tempAbilities);
    pokemon.stats = content['stats'];

    return pokemon;
  }

}
