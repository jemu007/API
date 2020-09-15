import 'package:wall/model/categories.dart';

String apiKey = "563492ad6f917000010000010664c71aac704ff58853c07ad5991753";
String api1Key = "563492ad6f9170000100000176c2c175fccd4ef49048d87c28263ebf";

List<PhotosModel> getphotos() {
  List<PhotosModel> photos = new List();

  PhotosModel photosModel = new PhotosModel();

  photosModel.imgUrl =
      "https://images.pexels.com/photos/545008/pexels-photo-545008.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  photosModel.categoriesName = "Street Art";
  photos.add(photosModel);

  photosModel = new PhotosModel();
  photosModel.imgUrl =
      "https://images.pexels.com/photos/704320/pexels-photo-704320.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  photosModel.categoriesName = "Wild Life";
  photos.add(photosModel);

  photosModel = new PhotosModel();
  photosModel.imgUrl =
      "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  photosModel.categoriesName = "Nature";
  photos.add(photosModel);

  photosModel = new PhotosModel();
  photosModel.imgUrl =
      "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  photosModel.categoriesName = "City";
  photos.add(photosModel);

  photosModel = new PhotosModel();
  photosModel.imgUrl =
      "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  photosModel.categoriesName = "Motivation";

  photos.add(photosModel);
  photosModel = new PhotosModel();

  photosModel.imgUrl =
      "https://images.pexels.com/photos/2116475/pexels-photo-2116475.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  photosModel.categoriesName = "Bikes";
  photos.add(photosModel);
  photosModel = new PhotosModel();

  photosModel.imgUrl =
      "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  photosModel.categoriesName = "Cars";
  photos.add(photosModel);
  photosModel = new PhotosModel();

  return photos;
}
