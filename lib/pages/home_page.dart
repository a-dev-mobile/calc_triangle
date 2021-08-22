// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'widget/image_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GridView.count(
          crossAxisCount: 1,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            BuildCard(
              pathImage: 'assets/image/triangle/4.webp',
            ),
            ImageWidget()
          ],
        ),
      ),
    );
  }
}

class BuildCard extends StatelessWidget {
  const BuildCard({
    Key? key,
    required this.pathImage,
  }) : super(key: key);
  final String pathImage;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: Colors.green,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(01000),
        onTap: () {
          print('tap');
        },
        child: Column(
          children: [
            Image(
              image: AssetImage(pathImage),
            ),
            Text('asd')
          ],
        ),
      ),
    );
  }
}
