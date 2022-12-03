import "package:flutter/material.dart";
import 'package:liste_epicerie/Entities/item.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          endDrawer: Drawer(
            width: MediaQuery.of(context).size.width * 0.5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            backgroundColor: Colors.black,
          ),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 255, 225, 125),
            title:
                Text("Liste d'épicerie", style: TextStyle(color: Colors.black)),
            iconTheme: IconThemeData(color: Colors.black),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [Text("Ajouter des produits à votre liste")],
                  ),
                  //separator line
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 1,
                color: Colors.black,
              ),
            ],
          ),
          backgroundColor: Color.fromARGB(255, 255, 225, 125)),
    );
  }
}
