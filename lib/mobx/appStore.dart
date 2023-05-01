import 'dart:ui';

import 'package:mobx/mobx.dart';
import 'package:pokedex/colors.dart';
import 'package:pokedex/extractor.dart';
import 'package:pokedex/pokemon.dart';
import 'package:pokedex/service/service.dart';
import 'package:pokedex/strings.dart';

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

    for (int x = 0; x < strings.generation.length; x++) {
      if (selectedGeneration.value[x] == true) {
        contentTemp = await ApiService().myRequest('generation/${x + 1}/');
        contentTemp = contentTemp['pokemon_species'];
        contentGeneration += contentTemp;
      }
    }

    for (int x = 0; x < strings.type.length; x++) {
      if (selectedType.value[x] == true) {
        if (x == 18) {
          contentTemp = await ApiService().myRequest('type/10001/');
        } else {
          if (x == 19) {
            contentTemp = await ApiService().myRequest('type/10002/');
          } else {
            contentTemp = await ApiService().myRequest('type/${x + 1}/');
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
    contentTemp = removeRepetiblePokemonList(contentTemp);
    contentTemp.sort();
    content = await mapNameforPokemon(contentTemp);
    return content;
  }

  Future<List<Pokemon>> pokemonSearchByWord(word) async {
    var temp;
    temp = await ApiService().myRequest('pokemon/$word');
    if (temp == null) {
      return [Pokemon()];
    } else {
      temp = temp['forms'];
      temp = [temp[0]['name']];
      content = await mapNameforPokemon(temp);
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

  removeRepetiblePokemonList(list) {
    for (int x = 0; x < list.length; x++) {
      for (int y = 0; y < list.length; y++) {
        if (x != y && list[x] == list[y]) {
          list.remove(list[y]);
        }
      }
    }
    return list;
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

  _setToggle() {
    selectedGeneration.value = tempSelectedGeneration;
    selectedType.value = tempSelectedType;
  }
}
