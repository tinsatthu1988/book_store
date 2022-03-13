import 'dart:convert';
import 'package:http/http.dart' as httpClient;
import '../models/book.dart';
import 'package:flutter/material.dart';

class BooksProvider with ChangeNotifier {
  final List<Book> _items  = [
    Book(
      id: 1,
      title: 'The Storyteller: Tales of Life and Music',
      author: 'Dave Grohl',
      category: 'Arts & Photography',
      description:
          'Having entertained the idea for years, and even offered a few questionable opportunities ("It\'s a piece of cake! Just do 4 hours of interviews, find someone else to write it, put your face on the cover, and voila!") I have decided to write these stories just as I have always done, in my own hand. The joy that I have felt from chronicling these tales is not unlike listening back to a song that I\'ve recorded and can\'t wait to share with the world, or reading a primitive journal entry from a stained notebook, or even hearing my voice bounce between the Kiss posters on my wall as a child.',
      unitPrice: 29.99,
      imageUrl:
          'https://res.cloudinary.com/tinsatthu/image/upload/v1642922944/book/2_r24vtf.jpg',
    ),
    Book(
      id: 2,
      title: 'I Am Confident, Brave & Beautiful',
      author: 'Hopscotch Girls',
      category: 'Arts & Photography',
      description:
          'If you\'re looking for an activity for your toddler, preschooler, kindergartner or school-aged child, this cute and positive book helps kids build confidence while inspiring and entertaining them. It\'s a fun and mess-free way to engage in arts and crafts for girls age 3, 4, 5, 6, 7, 8 and up. Makes a perfect birthday gift.',
      unitPrice: 13.45,
      imageUrl:
          'https://res.cloudinary.com/tinsatthu/image/upload/v1642922943/book/1_duns4s.jpg',
    ),
    Book(
      id: 3,
      title: 'My First Learn to Write Workbook',
      author: 'Crystal Radke',
      category: 'Education & Teaching',
      description:
          'Set kids up to succeed in school with a learn to write for kids guide that teaches them letters, shapes, and numbers―and makes it fun. My First Learn-to-Write Workbook introduces early writers to proper pen control, line tracing, and more with dozens of handwriting exercises that engage their minds and boost their reading and writing comprehension.',
      unitPrice: 19.99,
      imageUrl:
          'https://res.cloudinary.com/tinsatthu/image/upload/v1642923292/book/3_myv18g.jpg',
    ),
    Book(
      id: 4,
      title: 'My First Toddler Coloring Book',
      author: 'Tanya Emelyanova',
      category: 'Education & Teaching',
      description:
          'Toddlers learn best while having fun. My First Toddler Coloring Book introduces fundamental skills like reading, counting, and shapes through engaging coloring exercises. Kids will have a blast as they learn pre-K concepts and reinforce their understanding through creativity and play.',
      unitPrice: 9.96,
      imageUrl:
          'https://res.cloudinary.com/tinsatthu/image/upload/v1642923292/book/7_xzw0hw.jpg',
    ),
    Book(
      id: 5,
      title: 'The 1619 Project: A New Origin Story',
      author: 'Nikole Hannah-Jones',
      category: 'History',
      description:
          'In late August 1619, a ship arrived in the British colony of Virginia bearing a cargo of twenty to thirty enslaved people from Africa. Their arrival led to the barbaric and unprecedented system of American chattel slavery that would last for the next 250 years. This is sometimes referred to as the country’s original sin, but it is more than that: It is the source of so much that still defines the United States.',
      unitPrice: 14.99,
      imageUrl:
          'https://res.cloudinary.com/tinsatthu/image/upload/v1642924286/book/10_acnhb6.jpg',
    ),
    Book(
      id: 6,
      title: 'The President and the Freedom Fighter',
      author: 'Brian Kilmeade',
      category: 'History',
      description:
          'In The President and the Freedom Fighter, Brian Kilmeade tells the little-known story of how two American heroes moved from strong disagreement to friendship, and in the process changed the entire course of history.',
      unitPrice: 17.54,
      imageUrl:
          'https://res.cloudinary.com/tinsatthu/image/upload/v1642924286/book/11_w8x4te.jpg',
    ),
  ];

  // getter
  List<Book> get items {
    return [..._items];
  }

  Book findById(int id){
    return _items.firstWhere((element) => element.id == id);
  }

  List<Book> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  // setter
  void addBook(Book book) {
    Uri url = Uri.parse('http://10.0.2.2:8081/api/book');

    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };

    httpClient.post(url, headers: headers, body: json.encode({
      'title': book.title,
      'author': book.author,
      'category': book.category,
      'description': book.description,
      'unitPrice': book.unitPrice,
      'imageUrl': book.imageUrl,
      'isFavorite': book.isFavorite,
      'unitsInStock': 100,
      'active': true
    })).then((response) {
      print(json.decode(response.body));
      final res = json.decode(response.body);
      Book newBook = Book( title: res['title'],
                            author: res['author'],
                            category: res['category'],
                            description: res['description'],
                            unitPrice: res['unitPrice'],
                            imageUrl: res['imageUrl'],
                            id: res['id']
      );
      _items.add(newBook);
      print(json.encode(newBook));
      notifyListeners();
    });
  }

  void updateBook(int id, Book newBook) {
    int bookIndex = _items.indexWhere((element) => element.id == id);
    if (bookIndex >= 0) {
      _items[bookIndex] = newBook;
      notifyListeners();
    } else {
      print("problem with updating book");
    }
  }

  void deleteBook(int id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
