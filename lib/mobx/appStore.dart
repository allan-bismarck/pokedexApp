import 'package:mobx/mobx.dart';
import 'package:pokedex/functions/mapper.dart';
import 'package:pokedex/functions/pokemon.dart';
import 'package:pokedex/service/service.dart';
import 'package:pokedex/functions/strings.dart';

import '../functions/filter.dart';

class AppStore {
  List<Pokemon> content = [];

  var tempSelectedGeneration = <bool>[
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  var selectedGeneration = Observable<List<bool>>(
      [false, false, false, false, false, false, false, false]);

  var tempSelectedType = <bool>[
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  var selectedType = Observable<List<bool>>([
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ]);

  late final setToggle = Action(_setToggle);

  List<bool> returnToggleButtonsSelecteds() {
    bool isSelectedType = false;
    bool isSelectedGeneration = false;
    var strings = GlobalStrings();

    for (int x = 0; x < strings.generation.length; x++) {
      if (selectedGeneration.value[x] == true) {
        isSelectedGeneration = true;
        break;
      }
    }

    for (int x = 0; x < strings.type.length; x++) {
      if (selectedType.value[x] == true) {
        isSelectedType = true;
        break;
      }
    }

    return [isSelectedGeneration, isSelectedType];
  }

  Future<List<Pokemon>> pokemonSearchByToggleButtons() async {
    var contentGeneration = [], contentType = [], contentTemp;
    content = [];
    var strings = GlobalStrings();
    var apiService = ApiService();
    var mapper = Mapper();

    for (int x = 0; x < strings.generation.length; x++) {
      if (selectedGeneration.value[x] == true) {
        contentTemp = await apiService.myRequest('generation/${x + 1}/');
        contentTemp = contentTemp['pokemon_species'];
        contentGeneration += contentTemp;
      }
    }

    for (int x = 0; x < strings.type.length; x++) {
      if (selectedType.value[x] == true) {
        if (x == 18) {
          contentTemp = await apiService.myRequest('type/10001/');
        } else {
          if (x == 19) {
            contentTemp = await apiService.myRequest('type/10002/');
          } else {
            contentTemp = await apiService.myRequest('type/${x + 1}/');
          }
        }
        contentTemp = contentTemp['pokemon'];
        contentTemp = formatListPokemonByType(contentTemp);
        contentType += contentTemp;
      }
    }

    contentTemp = [];
    for (int x = 0; x < contentGeneration.length; x++) {
      for (int y = 0; y < contentType.length; y++) {
        if (contentGeneration[x]['name'] == contentType[y]['name']) {
          contentTemp.add(contentGeneration[x]['name']);
        }
      }
    }
    contentTemp = PokemonFilter().removeRepetiblePokemonList(contentTemp);
    contentTemp.sort();
    content = await mapper.mapNameforPokemon(contentTemp);
    return content;
  }

  Future<List<Pokemon>> pokemonSearchByWord(word) async {
    var mapper = Mapper();
    var temp;
    temp = await ApiService().myRequest('pokemon/$word');
    if (temp == null) {
      return [Pokemon()];
    } else {
      temp = temp['forms'];
      temp = [temp[0]['name']];
      content = await mapper.mapNameforPokemon(temp);
      return content;
    }
  }

  formatListPokemonByType(content) {
    List<dynamic> temp = [];
    for (int index = 0; index < content.length; index++) {
      temp.add(content[index]['pokemon']);
    }
    return temp;
  }

  selectedItens(itemSelected) {
    var strings = GlobalStrings();
    if (itemSelected.contains(RegExp(r'[0-9]'))) {
      for (int x = 0; x < strings.generation.length; x++) {
        if (itemSelected == strings.generation[x]) {
          tempSelectedGeneration[x] = !tempSelectedGeneration[x];
          setToggle();
        }
      }
    } else {
      for (int x = 0; x < strings.type.length; x++) {
        if (itemSelected == strings.type[x]) {
          tempSelectedType[x] = !tempSelectedType[x];
          setToggle();
        }
      }
    }
  }

  _setToggle() {
    selectedGeneration.value = tempSelectedGeneration;
    selectedType.value = tempSelectedType;
  }
}
