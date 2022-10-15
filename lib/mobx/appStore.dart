import 'package:mobx/mobx.dart';
import '../service/api.dart';

class AppStore {
  var content;
  List<String> generation = <String>[
    '1ª',
    '2ª',
    '3ª',
    '4ª',
    '5ª',
    '6ª',
    '7ª',
    '8ª',
  ];

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

  List<String> type = <String>[
    'Normal',
    'Luta',
    'Vôo',
    'Veneno',
    'Chão',
    'Pedra',
    'Inseto',
    'Fantasma',
    'Aço',
    'Fogo',
    'Água',
    'Grama',
    'Elétrico',
    'Psiquico',
    'Gelo',
    'Dragão',
    'Trevas',
    'Fada',
    'Desconhecido',
    'Sombra',
  ];

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

  allPokemonsReturn() async {
    content = await api().myRequest('pokemon?limit=1154');
    content = content['results'];
  }

  pokemonSearchByToggleButtons() async {
    bool isSelectedType = false;
    bool isSelectedGeneration = false;
    var contentGeneration = [], contentType = [];
    content = [];

    for (int x = 0; x < generation.length; x++) {
      if (selectedGeneration.value[x] == true) {
        print(generation[x]);
        isSelectedGeneration = true;
        content = await api().myRequest('generation/${x + 1}/');
        contentGeneration += content['pokemon_species'];
      }
    }
    if (isSelectedGeneration == true) {
      content = contentGeneration;
    }

    for (int x = 0; x < type.length; x++) {
      if (selectedType.value[x] == true) {
        print(type[x]);
        isSelectedType = true;
        content = await api().myRequest('type/${x + 1}/');
        content = content['pokemon'];
        contentType += formatListPokemonByType(content);
      }
    }
    if (isSelectedType == true) {
      content = contentType;
    }

    if (isSelectedGeneration == false && isSelectedType == false) {
      await allPokemonsReturn();
    }

    if (isSelectedGeneration == true && isSelectedType == true) {
      content = [];
      for (int x = 0; x < contentGeneration.length; x++) {
        for (int y = 0; y < contentType.length; y++) {
          if (contentGeneration[x]['name'] == contentType[y]['name']) {
            content.add(contentGeneration[x]);
          }
        }
      }
      removeRepetiblePokemonList();
    }
  }

  pokemonSearchByWord(word) async {
    content = [];
    content = await api().myRequest('pokemon/$word');
    if (content == null) {
      return false;
    } else {
      content = content['forms'];
      return true;
    }
  }

  formatListPokemonByType(content) {
    List<dynamic> temp = [];
    for (int index = 0; index < content.length; index++) {
      temp.add(content[index]['pokemon']);
    }
    return temp;
  }

  extractPokemonsFromSpecies(content) async {
    List<dynamic> temp = [];
    var pokemons;
    for (int index = 0; index < content.length; index++) {
      pokemons = await api().myRequest(content[index]['url'].substring(26));
      pokemons = pokemons['varieties'];
      pokemons = formatListPokemonByType(pokemons);
      for (int i = 0; i < pokemons.length; i++) {
        temp.add(pokemons[i]);
      }
    }
    return temp;
  }

  identifyGeneration(generation) {
    switch (generation) {
      case 'generation-i':
        return 1;
      case 'generation-ii':
        return 2;
      case 'generation-iii':
        return 3;
      case 'generation-iv':
        return 4;
      case 'generation-v':
        return 5;
      case 'generation-vi':
        return 6;
      case 'generation-vii':
        return 7;
      case 'generation-viii':
        return 8;
      default:
        return 0;
    }
  }

  removeRepetiblePokemonList() {
    for (int x = 0; x < content.length; x++) {
      for (int y = 0; y < content.length; y++) {
        if (x != y && content[x]['name'] == content[y]['name']) {
          content.remove(content[y]);
        }
      }
    }
  }

  selectedItens(itemSelected) {
    if (itemSelected.contains(RegExp(r'[0-9]'))) {
      for (int x = 0; x < generation.length; x++) {
        if (itemSelected == generation[x]) {
          tempSelectedGeneration[x] = !tempSelectedGeneration[x];
          setToggle();
        }
      }
    } else {
      for (int x = 0; x < type.length; x++) {
        if (itemSelected == type[x]) {
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

  getContent() {
    return content;
  }
}
