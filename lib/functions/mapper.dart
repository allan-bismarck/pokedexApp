import 'package:pokedex/functions/pokemon.dart';
import 'package:pokedex/service/service.dart';

import 'colors.dart';
import 'extractor.dart';

class Mapper {

  mapNameforPokemon(listPokemon) async {
    List<Pokemon> pokemons = [];
    for (int index = 0; index < listPokemon.length; index++) {
      var temp = await getPokemonDetails(listPokemon[index]);
      if (temp != null) {
        pokemons.add(temp);
      }
    }
    return pokemons;
  }

  getPokemonDetails(item) async {
    var pokemon = Pokemon();
    var extractor = Extractor();
    var geralPokemon = await ApiService().myRequest('pokemon-form/$item');
    if (geralPokemon != null) {
      pokemon.name = geralPokemon['name'];
      pokemon.types = extractor.extractTypesFromPokemonAppStore(geralPokemon['types']);
      pokemon.sprites = geralPokemon['sprites']['front_default'];
      pokemon.color = ColorsBackground().getColor(pokemon.types, ' | ');
      return pokemon;
    }

    return null;
  }
}