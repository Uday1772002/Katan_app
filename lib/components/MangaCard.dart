import 'package:flutter/material.dart';

class MangaCard extends StatelessWidget {
  final String mangaImg, mangaTitle;

  const MangaCard({Key? key, required this.mangaImg, required this.mangaTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 130,
      child: Column(
        children: [
          Expanded(
            flex: 70,
            child: Container(
              child: Image.network(
                mangaImg,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 30,
            child: Container(
              child: Text(mangaTitle),
            ),
          ),
        ],
      ),
    );
  }
}
