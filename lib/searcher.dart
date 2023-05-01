import 'package:pokedex/pokemon.dart';
import 'package:pokedex/service/service.dart';

import 'Strings.dart';
import 'filter.dart';

class Searcher {

  // Future<List<Pokemon>> pokemonSearchByToggleButtons() async {
  //   var contentGeneration = [], contentType = [], contentTemp;
  //   content = [];
  //   var strings = GlobalStrings();
  //   var apiService = ApiService();

  //   for (int x = 0; x < strings.generation.length; x++) {
  //     if (selectedGeneration.value[x] == true) {
  //       contentTemp = await apiService.myRequest('generation/${x + 1}/');
  //       contentTemp = contentTemp['pokemon_species'];
  //       contentGeneration += contentTemp;
  //     }
  //   }

  //   for (int x = 0; x < strings.type.length; x++) {
  //     if (selectedType.value[x] == true) {
  //       if (x == 18) {
  //         contentTemp = await apiService.myRequest('type/10001/');
  //       } else {
  //         if (x == 19) {
  //           contentTemp = await apiService.myRequest('type/10002/');
  //         } else {
  //           contentTemp = await apiService.myRequest('type/${x + 1}/');
  //         }
  //       }
  //       contentTemp = contentTemp['pokemon'];
  //       contentTemp = formatListPokemonByType(contentTemp);
  //       contentType += contentTemp;
  //     }
  //   }

  //   contentTemp = [];
  //   for (int x = 0; x < contentGeneration.length; x++) {
  //     for (int y = 0; y < contentType.length; y++) {
  //       if (contentGeneration[x]['name'] == contentType[y]['name']) {
  //         contentTemp.add(contentGeneration[x]['name']);
  //       }
  //     }
  //   }
  //   contentTemp = PokemonFilter().removeRepetiblePokemonList(contentTemp);
  //   contentTemp.sort();
  //   content = await mapNameforPokemon(contentTemp);
  //   return content;
  // }

  // Future<List<Pokemon>> pokemonSearchByWord(word) async {
  //   var temp;
  //   temp = await ApiService().myRequest('pokemon/$word');
  //   if (temp == null) {
  //     return [Pokemon()];
  //   } else {
  //     temp = temp['forms'];
  //     temp = [temp[0]['name']];
  //     content = await mapNameforPokemon(temp);
  //     return content;
  //   }
  // }

}