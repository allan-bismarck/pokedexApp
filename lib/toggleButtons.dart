import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex/mobx/appStore.dart';
import 'package:provider/provider.dart';

class ToggleButtonsSearch extends StatefulWidget {
  final List<String> list;
  final int size;
  const ToggleButtonsSearch(
      {super.key, required this.list, required this.size});

  @override
  State<ToggleButtonsSearch> createState() => _ToggleButtonsSearchState();
}

class _ToggleButtonsSearchState extends State<ToggleButtonsSearch> {
  List<bool> _selectedItems = [];
  List<Widget> listWidgets = [];

  @override
  void initState() {
    super.initState();
    for (int itens = 0; itens < widget.size; itens++) {
      _selectedItems.add(false);
      if (widget.list[itens] == 'Desconhecido') {
        listWidgets.add(Text(
          widget.list[itens],
          textScaleFactor: 0.8,
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ));
      } else {
        listWidgets.add(Text(
          widget.list[itens],
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
          )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appStore = Provider.of<AppStore>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // ToggleButtons with a multiple selection.
        Observer(
            builder: (_) => ToggleButtons(
                  onPressed: (int index) {
                    // All buttons are selectable.
                    appStore.selectedItens(widget.list[index]);
                    setState(() {
                      _selectedItems[index] = !_selectedItems[index];
                    });
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  selectedBorderColor: Colors.green[700],
                  selectedColor: Colors.white,
                  fillColor: Colors.green[200],
                  color: Colors.green[400],
                  constraints: const BoxConstraints(
                    minHeight: 40.0,
                    minWidth: 80.0,
                  ),
                  isSelected: _selectedItems,
                  children: listWidgets,
                )),
      ],
    );
  }
}
