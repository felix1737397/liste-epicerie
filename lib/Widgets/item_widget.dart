import 'package:event/event.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:liste_epicerie/Entities/db.dart';
import 'package:liste_epicerie/Entities/item.dart';
import 'package:liste_epicerie/Widgets/modification_widget.dart';
import 'package:vector_math/vector_math.dart' as math;

class ItemWidget extends StatefulWidget {
  final Function() refresh;
  const ItemWidget({
    Key? key,
    required this.refresh,
  }) : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    //tiles
    return Column(
      children: [
        FutureBuilder(
            future: MongoDatabase.getDocuments(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    for (Item item in snapshot.data!)
                      //tile
                      InkWell(
                        onTap: () {
                          ModificationWidget(
                              item: item, refresh: widget.refresh);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          child: ListTile(
                            title: Text(item.name ?? ""),
                            subtitle: Text("Unités: ${item.unit ?? ""}"),
                            trailing:
                                Text("Quantité: ${item.amount.toString()}"),
                            leading: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ModificationWidget(
                                        item: item, refresh: widget.refresh);
                                  },
                                );
                              },
                            ),
                            //delete button
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Supprimer"),
                                    content: const Text(
                                        "Voulez-vous vraiment supprimer cet élément?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Annuler"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          MongoDatabase.delete(item);
                                          widget.refresh();
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Supprimer"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )
                  ],
                );
              }
              return const Text("Loading");
            }),
      ],
    );
  }
}
