import "package:flutter/material.dart";
import 'package:liste_epicerie/Entities/db.dart';
import 'package:liste_epicerie/Entities/item.dart';
import 'package:liste_epicerie/Screens/new_item_form.dart';
import 'package:event/event.dart';

import 'package:liste_epicerie/Widgets/item_widget.dart';
import 'package:liste_epicerie/Widgets/recipee_widget.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    void _update() {
      setState(() {});
    }

    //reload
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 255, 225, 125),
            title:
                Text("Liste d'épicerie", style: TextStyle(color: Colors.black)),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Ajouter des produits à votre liste",
                              style: TextStyle(fontSize: 16)),
                        )
                      ],
                    ),
                    Spacer(),
                    // add button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return NewItemForm(refresh: _update);
                              });
                        },
                        child: const Icon(Icons.add),
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 1,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                              "Ajouter des produits à partir d'une recette",
                              style: TextStyle(fontSize: 16)),
                        )
                      ],
                    ),
                    Spacer(),
                    // add button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FloatingActionButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return RecipeeWidget(refresh: _update);
                              });
                        },
                        child: const Icon(Icons.add),
                        backgroundColor: Colors.black,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 1,
                  color: Colors.black,
                ),
                Column(
                  children: [
                    ItemWidget(refresh: _update),
                  ],
                )
              ],
            ),
          ),
          backgroundColor: Color.fromARGB(255, 255, 225, 125)),
    );
  }
}
