import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wall/data/data.dart';
import 'package:wall/model/wallpaper.dart';
import 'package:wall/widget/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;

  const Search({Key key, this.searchQuery});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchController = new TextEditingController();
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
    getSearchPhoto(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -30,
        centerTitle: true,
        elevation: 0.0,
        title: titleName(),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    color: Colors.grey[300]),
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(4),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: "Search Wallpaper",
                              border: InputBorder.none),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Search(
                                        searchQuery: searchController.text)));
                          },
                          child: Icon(Icons.search)),
                    ],
                  ),
                ),
              ),
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
