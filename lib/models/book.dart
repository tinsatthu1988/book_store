import 'package:flutter/material.dart';
import 'package:http/http.dart' as httpClient;
import 'dart:convert';

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

  Map toJson() => {
    'id': id,
    'title': title,
    'author': author,
    'category': category,
    'description': description,
    'unitPrice': unitPrice,
    'imageUrl': imageUrl,
    'isFavorite': isFavorite,
  };

  Future<void> toggleFavoriteStatus() {
    Uri url = Uri.parse('http://10.0.2.2:8081/api/books/$id');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    return httpClient.put(url, headers: headers, body: json.encode({
      'title': title,
      'author': author,
      'category': category,
      'description': description,
      'unitPrice': unitPrice,
      'imageUrl': imageUrl,
      'favorite': !isFavorite,
      'unitsInStock': 100,
      'active': true,
    })).then((response) {
      if (response.statusCode == 200) {
        isFavorite = !isFavorite;
        notifyListeners();
      } else {
        try {
          print(json.decode(response.body));  
        } on FormatException catch (e) {
          print('Message return is not a valid JSON format');
        }
      }
    }).catchError((error) => throw error);
  }
}
