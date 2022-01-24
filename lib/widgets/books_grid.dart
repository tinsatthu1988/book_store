import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/books_provider.dart';
import '../widgets/book_item.dart';

class BooksGrid extends StatelessWidget {

  final bool _showFavoriteOnly;

  BooksGrid(this._showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    final booksData = Provider.of<BooksProvider>(context);
    final books = _showFavoriteOnly ? booksData.favoriteItems : booksData.items;

    return GridView.builder(
      padding: EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 2/3, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (ctx, idx) =>
        ChangeNotifierProvider.value(value: books[idx], child: BookItem(),),
      itemCount: books.length,
    );
  }

}