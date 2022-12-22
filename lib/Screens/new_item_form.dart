import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:liste_epicerie/Entities/db.dart';
import 'package:liste_epicerie/Entities/item.dart';
import 'package:liste_epicerie/Widgets/item_widget.dart';

class NewItemForm extends StatefulWidget {
  final Function() refresh;
  const NewItemForm({
    Key? key,
    required this.refresh,
  }) : super(key: key);

  @override
  State<NewItemForm> createState() => _NewItemFormState();
}

class _NewItemFormState extends State<NewItemForm> {
  Item item = Item();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Ajouter un produit"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: "Nom du produit",
            ),
            onChanged: (String value) {
              setState(() {
                item.name = value;
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: "Unité",
            ),
            onChanged: (String value) {
              setState(() {
                item.unit = value;
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(
              labelText: "Quantité",
            ),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ], // O
            onChanged: (String value) {
              setState(() {
                item.amount = double.parse(value);
              });
            },
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Annuler"),
        ),
        TextButton(
          onPressed: () async {
            await MongoDatabase.insert(item);
            Navigator.of(context).pop();
            widget.refresh();
          },
          child: const Text("Ajouter"),
        ),
      ],
    );
  }
}
