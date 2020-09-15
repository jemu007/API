import 'package:flutter/material.dart';
import 'package:wall/model/wallpaper.dart';

Widget titleName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text("Wallpaper",
          style: TextStyle(
            color: Colors.red,
          ))
    ],
  );
}

Widget wallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
      // color: Colors.blue,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: wallpapers.map((wallpaper) {
          return GridTile(
              child: Container(
                  child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: Image.network(
              wallpaper.src.portrait,
              fit: BoxFit.cover,
            ),
          )));
        }).toList(),
      ));
}
