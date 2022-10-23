import 'package:flutter/material.dart';
import 'package:pokedex/pokemon.dart';
import 'package:pokedex/pokemonListScreen.dart';
import 'package:provider/provider.dart';
import 'mobx/appStore.dart';
import 'toggleButtons.dart';

TextEditingController controller = TextEditingController();

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int maxSizeWidthToggle = 4;

  List<String> typesPart1 = [],
      typesPart2 = [],
      typesPart3 = [],
      typesPart4 = [],
      typesPart5 = [],
      generationPart1 = [],
      generationPart2 = [];

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final appStore = Provider.of<AppStore>(context);
    initLists(appStore);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                      labelText: 'Pesquisar pelo nome',
                      labelStyle: TextStyle(color: Colors.blueAccent),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(73, 68, 137, 255))),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: Colors.blueAccent)),
                      suffixIcon: InkWell(
                          child: Icon(Icons.search),
                          onTap: () async {
                            await pokemonSearch(context, appStore);
                          })),
                ),
                const SizedBox(height: 15),
                const Text('OU\nSelecione as preferências abaixo',
                    textAlign: TextAlign.center, textScaleFactor: 1.3),
                const SizedBox(height: 15),
                const Text('Geração'),
                const SizedBox(height: 5),
                ToggleButtonsSearch(
                    list: generationPart1, size: maxSizeWidthToggle),
                ToggleButtonsSearch(
                    list: generationPart2, size: maxSizeWidthToggle),
                const SizedBox(height: 15),
                const Text('Tipo'),
                const SizedBox(height: 5),
                ToggleButtonsSearch(list: typesPart1, size: maxSizeWidthToggle),
                ToggleButtonsSearch(list: typesPart2, size: maxSizeWidthToggle),
                ToggleButtonsSearch(list: typesPart3, size: maxSizeWidthToggle),
                ToggleButtonsSearch(list: typesPart4, size: maxSizeWidthToggle),
                ToggleButtonsSearch(list: typesPart5, size: maxSizeWidthToggle),
                const SizedBox(height: 10),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                    ),
                    onPressed: () async {
                      List<bool> selecteds =
                          appStore.returnToggleButtonsSelecteds();
                      (selecteds[0] == false || selecteds[1] == false)
                          ? showSnackBarMessage(
                              'Selecione alguma preferência para pesquisar')
                          : Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const PokemonListScreen()),
                            );
                    },
                    child: const Text(
                      'Pesquisar',
                      textScaleFactor: 1.2,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  pokemonSearch(context, appStore) async {
    if (await isValidInput() == true) {
      List<Pokemon> temp = await appStore.pokemonSearchByWord(controller.text);
      if (temp[0].name == '') {
        await showSnackBarMessage('Digite o nome do pokémon corretamente');
      } else {
        String word = controller.text;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PokemonListScreen(namePokemon: word)));
      }
    }
    controller.text = '';
    FocusScope.of(context).unfocus();
  }

  isValidInput() async {
    if (controller.text == '') {
      await showSnackBarMessage(
          'Digite um nome do pokémon que deseja consultar');
      return false;
    } else {
      if (controller.text.contains(RegExp(r'[A-Z]'))) {
        await showSnackBarMessage('Digite apenas letras minúsculas');
        return false;
      }
      if (controller.text.contains(RegExp(r'[0-9]'))) {
        await showSnackBarMessage('Digite apenas letras');
        return false;
      }
      return true;
    }
  }

  showSnackBarMessage(message) async {
    await ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    ));
  }

  initLists(appStore) {
    for (int x = 0; x < maxSizeWidthToggle; x++) {
      typesPart1.add(appStore.type[x]);
      typesPart2.add(appStore.type[x + 4]);
      typesPart3.add(appStore.type[x + 8]);
      typesPart4.add(appStore.type[x + 12]);
      typesPart5.add(appStore.type[x + 16]);
    }

    for (int x = 0; x < maxSizeWidthToggle; x++) {
      generationPart1.add(appStore.generation[x]);
      generationPart2.add(appStore.generation[x + 4]);
    }
  }
}
