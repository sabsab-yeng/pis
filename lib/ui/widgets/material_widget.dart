import 'package:flutter/material.dart';
class MultiSelectMaterial extends StatefulWidget {
  final List<String> materialList;
  final Function(List<String>) onSelectionChanged;

  MultiSelectMaterial(this.materialList, {this.onSelectionChanged});

  @override
  _MultiSelectMaterialState createState() => _MultiSelectMaterialState();
}

class _MultiSelectMaterialState extends State<MultiSelectMaterial> {
  // String selectedChoice = "";
  List<String> selectedChoices = List();

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.materialList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}