import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:liste_epicerie/Entities/db.dart';
import 'package:liste_epicerie/Entities/item.dart';
import 'package:liste_epicerie/Widgets/item_widget.dart';

class ModificationWidget extends StatefulWidget {
  final Item item;
  final Function() refresh;

  const ModificationWidget({
    Key? key,
    required this.refresh,
    required this.item,
  }) : super(key: key);

  @override
  State<ModificationWidget> createState() => _ModificationWidgetState();
}

//on initialization of widget
@override
class _ModificationWidgetState extends State<ModificationWidget> {
  Item newItem = Item();

  void initState() {
    super.initState();
    newItem = widget.item;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("modifier un produit"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(
              labelText: "Nom du produit",
            ),
            initialValue: widget.item.name,
            onChanged: (String value) {
              setState(() {
                print(value);
                newItem.name = value;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Unité",
            ),
            initialValue: widget.item.unit,
            onChanged: (String value) {
              setState(() {
                newItem.unit = value;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Quantité",
            ),
            initialValue: widget.item.amount.toString(),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // O
            onChanged: (String value) {
              setState(() {
                newItem.amount = double.parse(value);
              });
            },
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Annuler"),
        ),
        TextButton(
          onPressed: () async {
            print(newItem.name);
            await MongoDatabase.update(newItem);
            widget.refresh();
            Navigator.pop(context);
          },
          child: const Text("modifier"),
        ),
      ],
    );
  }
}
