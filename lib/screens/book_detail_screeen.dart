import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../models/book.dart';
import '../providers/books_provider.dart';

class BookDetailScreen extends StatelessWidget {

  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    int bookId = ModalRoute.of(context)!.settings.arguments as int;
    Book loadedBook = Provider.of<BooksProvider>(context, listen: false).findById(bookId);

    return Scaffold(
      appBar: AppBar(
        title: Text(loadedBook.title,)
      )
    );
  }

}