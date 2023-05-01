class Translator {
  Translator();

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
}