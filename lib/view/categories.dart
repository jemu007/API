import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wall/data/data.dart';
import 'package:wall/model/wallpaper.dart';
import 'package:wall/widget/widget.dart';

class Categorie extends StatefulWidget {
  final String categorieName;

  const Categorie({Key key, this.categorieName});
  @override
  _CategorieState createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  List<WallpaperModel> wallpapers = List();

  getSearchPhoto(String query) async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=$query&per_page=500&page=1",
        headers: {"Authorization": apiKey});
    print(response.body);
    Map<String, dynamic> jsonData = jsonDecode(response.body);

    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);

      wallpapers.add(wallpaperModel);
    });
    setState(() {});
  }

  @override
  void initState() {
    getSearchPhoto(widget.categorieName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleName(),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              wallpapersList(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}
