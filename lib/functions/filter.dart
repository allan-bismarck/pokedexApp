class PokemonFilter {

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
}