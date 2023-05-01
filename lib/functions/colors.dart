import 'dart:ui';

class ColorsBackground {

  getColor(type, char) {
    var temp = type.split(char);
    switch (temp[0]) {
      case 'Normal':
        return const Color.fromARGB(255, 238, 238, 238);
      case 'Luta':
        return const Color.fromARGB(255, 195, 201, 217);
      case 'Vôo':
        return const Color.fromARGB(255, 248, 244, 171);
      case 'Veneno':
        return const Color.fromARGB(255, 196, 5, 199);
      case 'Terra':
        return const Color.fromARGB(255, 166, 99, 60);
      case 'Pedra':
        return const Color.fromARGB(255, 222, 184, 135);
      case 'Inseto':
        return const Color.fromARGB(255, 144, 238, 144);
      case 'Fantasma':
        return const Color.fromARGB(255, 164, 86, 166);
      case 'Aço':
        return const Color.fromARGB(255, 219, 221, 227);
      case 'Fogo':
        return const Color.fromARGB(255, 255, 165, 0);
      case 'Água':
        return const Color.fromARGB(255, 62, 159, 255);
      case 'Grama':
        return const Color.fromARGB(255, 8, 231, 8);
      case 'Elétrico':
        return const Color.fromARGB(255, 255, 255, 0);
      case 'Psíquico':
        return const Color.fromARGB(255, 255, 238, 137);
      case 'Gelo':
        return const Color.fromARGB(255, 165, 229, 255);
      case 'Dragão':
        return const Color.fromARGB(255, 236, 55, 55);
      case 'Trevas':
        return const Color.fromARGB(255, 122, 122, 122);
      case 'Fada':
        return const Color.fromARGB(255, 255, 182, 193);
      case 'Desconhecido':
        return const Color.fromARGB(255, 182, 191, 147);
      case 'Sombra':
        return const Color.fromARGB(255, 211, 211, 211);
      default:
        return const Color.fromARGB(255, 255, 0, 255);
    }
  }
}