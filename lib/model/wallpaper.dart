class WallpaperModel {
  String url;
  String photographer;
  String photographer_url;
  int photographer_id;
  SrcModel src;

  WallpaperModel(
      {this.url,
      this.photographer,
      this.photographer_id,
      this.photographer_url,
      this.src});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
        url: jsonData["url"],
        src: SrcModel.fromMap(jsonData["src"]),
        photographer: jsonData["photographer"],
        photographer_id: jsonData["photographer_id"],
        photographer_url: jsonData["photographer_url"]);
  }
}

class SrcModel {
  String original;
  String small;
  String portrait;

  SrcModel({this.original, this.portrait, this.small});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
        original: jsonData["original"],
        small: jsonData["small"],
        portrait: jsonData["portrait"]);
  }
}
