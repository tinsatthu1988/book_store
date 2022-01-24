import 'package:flutter/material.dart';

class Book with ChangeNotifier {
  int id;
  String title;
  String author;
  String category;
  String description;
  double unitPrice;
  String imageUrl;
  bool isFavorite;

  Book(
      {required this.id,
      required this.title,
      required this.author,
      required this.category,
      required this.description,
      required this.unitPrice,
      required this.imageUrl,
      this.isFavorite = false});

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}
