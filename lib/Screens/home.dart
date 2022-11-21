import "package:flutter/material.dart";
import 'package:liste_epicerie/Entities/high_score_entity.dart';

class Home extends StatelessWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(children: [Text("allo")]),
          backgroundColor: Color.fromARGB(255, 255, 225, 125)),
    );
  }
}
