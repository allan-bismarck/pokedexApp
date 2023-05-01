import 'package:pokedex/service/service.dart';
import 'package:pokedex/functions/translator.dart';

class Extractor {

  extractNamesFromPokemons(list, screen) {
    var temp = [];
    for (int x = 0; x < list.length; x++) {
      temp.add(list[x]['pokemon']['name']);
    }

    return temp;
  }

  extractPokemonsFromSpecies(content, formatListPokemonByType) async {
    List<dynamic> temp = [];
    var pokemons;
    for (int index = 0; index < content.length; index++) {
      pokemons = await ApiService().myRequest(content[index]['url'].substring(26));
      pokemons = pokemons['varieties'];
      pokemons = formatListPokemonByType(pokemons);
      for (int i = 0; i < pokemons.length; i++) {
        temp.add(pokemons[i]);
      }
    }
    return temp;
  }

  extractTypesFromPokemonAppStore(types) {
    String strType = '';
    var translator = Translator();
    for (int index = 0; index < types.length; index++) {
      strType += translator.translateType(types[index]['type']['name']);
      strType += ' | ';
    }
    strType = strType.substring(0, strType.length - 3);
    return strType;
  }

  extractTypesFromPokemonStats(types) {
    var translator = Translator();
    String strType = '';
    for (int index = 0; index < types.length; index++) {
      strType += translator.translateType(types[index]['type']['name']);
      strType += ', ';
    }
    strType = strType.substring(0, strType.length - 2);
    return strType;
  }

  extractAbilitiesFromPokemon(abilities) {
    String strAbility = '';
    for (int index = 0; index < abilities.length; index++) {
      strAbility += abilities[index];
      strAbility += '\n';
    }
    strAbility = strAbility.substring(0, strAbility.length - 2);
    return strAbility;
  }

  extractAbilityNames(list) {
    var temp = [];
    for (int x = 0; x < list.length; x++) {
      temp.add(list[x]['ability']['name']);
    }
    return temp;
  }

  extractEvolutionsFromPokemon(list) {
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

}