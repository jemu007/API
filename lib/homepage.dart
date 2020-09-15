import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wall/model/wallpaper.dart';
import 'package:wall/view/categories.dart';
import 'data/data.dart';
import 'model/categories.dart';
import 'view/view.dart';
import 'widget/widget.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<PhotosModel> photos = new List();
  List<WallpaperModel> wallpapers = List();
  TextEditingController searchController = new TextEditingController();

  getTrendingPhoto() async {
    var response = await http.get(
        "https://api.pexels.com/v1/search?query=nature&per_page=500&page=1",
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

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
    final response = await http.get(
        "https://api.pexels.com/v1/search?query=coding&per_page=100&page=1",
        headers: {"Authorization": apiKey});
    setState(() {
      getTrendingPhoto();
      photos = getphotos();
    });
    return null;
  }

  Item selectedUser;
  List<Item> users = [
    Item(
        'Android',
        Icon(
          Icons.android,
          color: Colors.black,
        )),
    Item(
        'Flutter',
        Icon(
          Icons.flag,
          color: Colors.blue,
        )),
    Item(
        'ReactNative',
        Icon(
          Icons.format_indent_decrease,
          color: Colors.amber,
        )),
    Item(
        'iOS',
        Icon(
          Icons.mobile_screen_share,
          color: Colors.greenAccent,
        )),
  ];

  @override
  void initState() {
    getTrendingPhoto();
    photos = getphotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: titleName(),
      ),
      body: RefreshIndicator(
        onRefresh: refreshList,
        child: SingleChildScrollView(
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
                Container(
                  height: 65,
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: photos.length,
                      itemBuilder: (context, index) {
                        return HomePhoto(
                            titleName: photos[index].categoriesName,
                            imgUrl: photos[index].imgUrl);
                      }),
                ),
                DropdownButton<Item>(
                  hint: Text("Select item"),
                  value: selectedUser,
                  elevation: 30,
                  onChanged: (Item value) {
                    setState(() {
                      selectedUser = value;
                    });
                  },
                  items: users.map((Item user) {
                    return DropdownMenuItem<Item>(
                      value: user,
                      child: Row(
                        children: <Widget>[
                          user.icon,
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            user.name,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                wallpapersList(wallpapers: wallpapers, context: context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePhoto extends StatelessWidget {
  String titleName;
  String imgUrl;
  HomePhoto({@required this.titleName, this.imgUrl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Categorie(
                      categorieName: titleName.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 6),
        child: Stack(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Image.network(
                  imgUrl,
                  // color: Colors.black12,
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                )),
            ClipRRect(
              borderRadius: BorderRadius.circular(26),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: 100,
                color: Colors.black38,
                child: Text(
                  titleName,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
