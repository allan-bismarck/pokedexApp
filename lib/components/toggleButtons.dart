import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokedex/mobx/appStore.dart';
import 'package:provider/provider.dart';

class ToggleButtonsSearch extends StatefulWidget {
  final List<String> list;
  final int size;
  final String? select;
  final double? fontsize;
  const ToggleButtonsSearch(
      {super.key,
      required this.list,
      required this.size,
      this.fontsize,
      required this.select});

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
        listWidgets.add(Container(
          alignment: Alignment.center,
          width: widget.fontsize == null ? 2 : widget.fontsize! * 0.2,
          height: widget.fontsize == null ? 2 : widget.fontsize! * 0.11,
          child: Text(
            widget.list[itens],
            textScaleFactor: 0.75,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: widget.fontsize == null ? 2 : widget.fontsize! * 0.04,
            ),
          ),
        ));
      } else {
        listWidgets.add(Container(
          alignment: Alignment.center,
          width: widget.fontsize == null ? 2 : widget.fontsize! * 0.2,
          height: widget.fontsize == null ? 2 : widget.fontsize! * 0.11,
          child: Text(
            widget.list[itens],
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: widget.fontsize == null ? 2 : widget.fontsize! * 0.04,
            ),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appStore = Provider.of<AppStore>(context);

    return Observer(
        builder: (_) => Container(
          height: widget.fontsize == null ? 20 : widget.fontsize! * 0.105,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
          ),
          child: ToggleButtons(
                onPressed: (int index) {
                  // All buttons are selectable.
                  appStore.selectedItens(widget.list[index]);
                  setState(() {
                    _selectedItems[index] = !_selectedItems[index];
                  });
                },
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                borderColor: Theme.of(context).colorScheme.tertiary,
                selectedBorderColor: widget.select == 'generation'
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.white,
                borderWidth: widget.fontsize! * 0.005,
                selectedColor: widget.select == 'generation'
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.white,
                fillColor: widget.select == 'generation'
                    ? Theme.of(context).colorScheme.tertiary
                    : Theme.of(context).colorScheme.secondary,
                color: Theme.of(context).colorScheme.secondary,
                isSelected: _selectedItems,
                children: listWidgets,
                constraints: BoxConstraints(minHeight: 40),
              ),
        ));
  }
}
