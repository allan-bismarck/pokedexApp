import 'package:flutter/material.dart';
import 'package:pokedex/letterPokemon.dart';
import 'package:pokedex/myAppBar.dart';
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
    double fontsize = size.width > size.height ? size.height : size.width;
    final appStore = Provider.of<AppStore>(context);
    initLists(appStore);

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(size.height * 0.11),
            child: const MyAppBar(title: 'Pokedex', arrowBack: false)),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: size.width * 0.9,
                  ),
                  child: Column(children: [
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: TextFormField(
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: fontsize * 0.04),
                          controller: controller,
                          decoration: InputDecoration(
                              labelText: 'Pesquisar pelo nome',
                              labelStyle: TextStyle(
                                  color: Color.fromARGB(255, 158, 158, 158)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                              suffixIcon: InkWell(
                                  child: Icon(
                                    size: fontsize * 0.07,
                                    Icons.search,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  onTap: () async {
                                    await pokemonSearch(context, appStore);
                                  })),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text('Ou selecione as preferências abaixo',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: fontsize * 0.04
                        ),
                    ),
                    LetterPokemon(
                      text: 'Geração',
                      size: 0.7,
                    ),
                    Card(
                      elevation: 5,
                      child: Column(children: [
                        ToggleButtonsSearch(
                            list: generationPart1,
                            size: maxSizeWidthToggle,
                            select: 'generation',
                            fontsize: fontsize),
                        ToggleButtonsSearch(
                            list: generationPart2,
                            size: maxSizeWidthToggle,
                            select: 'generation',
                            fontsize: fontsize),
                      ]),
                    ),
                    LetterPokemon(
                      text: 'Tipo',
                      size: 0.7,
                    ),
                    Card(
                        elevation: 5,
                        child: Column(
                          children: [
                            ToggleButtonsSearch(
                                list: typesPart1,
                                size: maxSizeWidthToggle,
                                select: 'type',
                                fontsize: fontsize),
                            ToggleButtonsSearch(
                                list: typesPart2,
                                size: maxSizeWidthToggle,
                                select: 'type',
                                fontsize: fontsize),
                            ToggleButtonsSearch(
                                list: typesPart3,
                                size: maxSizeWidthToggle,
                                select: 'type',
                                fontsize: fontsize),
                            ToggleButtonsSearch(
                                list: typesPart4,
                                size: maxSizeWidthToggle,
                                select: 'type',
                                fontsize: fontsize),
                            ToggleButtonsSearch(
                                list: typesPart5,
                                size: maxSizeWidthToggle,
                                select: 'type',
                                fontsize: fontsize),
                          ],
                        )),
                    const SizedBox(height: 10),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(15),
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiary,
                            elevation: 4),
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
                        child: Text(
                          'Pesquisar',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontSize: fontsize * 0.035
                          ),
                        )),
                  ]),
                )),
          ),
        ));
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
                builder: (context) => PokemonListScreen(namePokemon: word)));
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
