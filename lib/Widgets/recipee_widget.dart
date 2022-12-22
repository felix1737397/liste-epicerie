import 'package:event/event.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:liste_epicerie/Entities/db.dart';
import 'package:liste_epicerie/Entities/item.dart';
import 'package:liste_epicerie/Widgets/modification_widget.dart';
import 'package:liste_epicerie/recipe_service.dart';
import 'package:vector_math/vector_math.dart' as math;

class RecipeeWidget extends StatefulWidget {
  final Function() refresh;
  const RecipeeWidget({
    Key? key,
    required this.refresh,
  }) : super(key: key);

  @override
  State<RecipeeWidget> createState() => _RecipeeWidgetState();
}

class _RecipeeWidgetState extends State<RecipeeWidget> {
  //lien de base pour que tu puisses tester, car tu ne peux pas paste dans ton emulateur
  String link =
      "https://www.ricardocuisine.com/en/recipes/9586-pasta-with-mushrooms-and-braised-beef";
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("Ajout à partir d'une recette"),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: "Lien de la recette",
            ),
            initialValue: link,
            onChanged: (String value) {
              setState(() {
                link = value;
              });
            },
          ),
        ]),
        actions: [
          TextButton(
            onPressed: () async {
              await RecipeService.addFromRecipe(link);
              widget.refresh();
              Navigator.of(context).pop();
            },
            child: const Text("Ajouter"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Annuler"),
          ),
        ]);
  }
}
