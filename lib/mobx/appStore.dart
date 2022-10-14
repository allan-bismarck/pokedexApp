import 'package:mobx/mobx.dart';
import '../service/api.dart';

class AppStore {
  var content;
  var contentStr = Observable<List<dynamic>>([]);
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

  late final updateContentStr = Action(_updateContentStr);
  late final setToggle = Action(_setToggle);

  _updateContentStr() {
    contentStr.value = content;
  }

  allPokemonsReturn() async {
    content = await api().myRequest('pokemon?limit=1154');
    content = content['results'];
    updateContentStr();
  }

  pokemonSearchByToggleButtons() async {
    bool selected = false;
    content = '';
    contentStr.value = [];
    for (int x = 0; x < generation.length; x++) {
      if (selectedGeneration.value[x] == true) {
        print(generation[x]);
        selected = true;
      }
    }
    for (int x = 0; x < type.length; x++) {
      if (selectedType.value[x] == true) {
        print(type[x]);
        selected = true;
      }
    }

    if (selected == false) {
      await allPokemonsReturn();
    }
  }

  pokemonSearchByWord(word) async {
    content = await api().myRequest('pokemon/$word');
    if (content == null) {
      return false;
    } else {
      content = content['forms'];
      updateContentStr();
      return true;
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
    return contentStr.value;
  }
}
