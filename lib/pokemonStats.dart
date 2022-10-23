import 'dart:ui';
import 'package:pokedex/service/api.dart';

class PokemonStats {
  String abilities = '';
  String name = '';
  String types = '';
  List<dynamic> stats = [];
  var sprites;
  Color color = Color.fromARGB(255, 255, 255, 255);

  getPokemon(name) async {
    var pokemon = PokemonStats();
    var content = await api().myRequest('pokemon/$name');
    pokemon.name = content['name'];
    pokemon.types = extractTypesFromPokemon(content['types']);
    pokemon.color = getColor(pokemon.types);
    pokemon.sprites = content['sprites']['other']['home']['front_default'];
    var tempAbilities = extractAbilityNames(content['abilities']);
    pokemon.abilities = extractAbilitiesFromPokemon(tempAbilities);
    pokemon.stats = content['stats'];

    return pokemon;
  }

  extractTypesFromPokemon(types) {
    String strType = '';
    for (int index = 0; index < types.length; index++) {
      strType += translateType(types[index]['type']['name']);
      strType += ', ';
    }
    strType = strType.substring(0, strType.length - 2);
    return strType;
  }

  translateType(type) {
    switch (type) {
      case 'normal':
        return 'Normal';
      case 'fighting':
        return 'Luta';
      case 'flying':
        return 'Vôo';
      case 'poison':
        return 'Veneno';
      case 'ground':
        return 'Terra';
      case 'rock':
        return 'Pedra';
      case 'bug':
        return 'Inseto';
      case 'ghost':
        return 'Fantasma';
      case 'steel':
        return 'Aço';
      case 'fire':
        return 'Fogo';
      case 'water':
        return 'Água';
      case 'grass':
        return 'Grama';
      case 'electric':
        return 'Elétrico';
      case 'psychic':
        return 'Psíquico';
      case 'ice':
        return 'Gelo';
      case 'dragon':
        return 'Dragão';
      case 'dark':
        return 'Trevas';
      case 'fairy':
        return 'Fada';
      case 'unknown':
        return 'Desconhecido';
      case 'shadow':
        return 'Sombra';
      default:
        return 'nothing';
    }
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

  getColor(type) {
    var temp = type.split(', ');
    switch (temp[0]) {
      case 'Normal':
        return Color.fromARGB(255, 238, 238, 238);
      case 'Luta':
        return Color.fromARGB(255, 195, 201, 217);
      case 'Vôo':
        return Color.fromARGB(255, 248, 244, 171);
      case 'Veneno':
        return Color.fromARGB(255, 196, 5, 199);
      case 'Terra':
        return Color.fromARGB(255, 166, 99, 60);
      case 'Pedra':
        return Color.fromARGB(255, 222, 184, 135);
      case 'Inseto':
        return Color.fromARGB(255, 144, 238, 144);
      case 'Fantasma':
        return Color.fromARGB(255, 164, 86, 166);
      case 'Aço':
        return Color.fromARGB(255, 219, 221, 227);
      case 'Fogo':
        return Color.fromARGB(255, 255, 165, 0);
      case 'Água':
        return Color.fromARGB(255, 62, 159, 255);
      case 'Grama':
        return Color.fromARGB(255, 8, 231, 8);
      case 'Elétrico':
        return Color.fromARGB(255, 255, 255, 0);
      case 'Psíquico':
        return Color.fromARGB(255, 255, 238, 137);
      case 'Gelo':
        return Color.fromARGB(255, 165, 229, 255);
      case 'Dragão':
        return Color.fromARGB(255, 236, 55, 55);
      case 'Trevas':
        return Color.fromARGB(255, 122, 122, 122);
      case 'Fada':
        return Color.fromARGB(255, 255, 182, 193);
      case 'Desconhecido':
        return Color.fromARGB(255, 182, 191, 147);
      case 'Sombra':
        return Color.fromARGB(255, 211, 211, 211);
      default:
        return Color.fromARGB(255, 255, 0, 255);
    }
  }

  extractAbilityNames(list) {
    var temp = [];
    for (int x = 0; x < list.length; x++) {
      temp.add(list[x]['ability']['name']);
    }
    return temp;
  }
}
