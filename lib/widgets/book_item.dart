import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/book_detail_screeen.dart';
import '../models/book.dart';
import '../models/cart.dart';

class BookItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Book book = Provider.of<Book>(context, listen: false);
    Cart cart = Provider.of<Cart>(context, listen: false);

    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(BookDetailScreen.routeName, arguments: book.id),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: Image.network(
            book.imageUrl,
            fit: BoxFit.cover,
          ),
          footer: GridTileBar(
            title: Text(
              book.title,
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.black54,
            leading: Consumer<Book>(
              builder: (ctx, book, child) => IconButton(
                icon: Icon(book.isFavorite ? Icons.favorite : Icons.favorite_border),
                color: Theme.of(context).accentColor,
                onPressed: () => book.toggleFavoriteStatus(),
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.shopping_cart),
              color: Theme.of(context).accentColor,
              onPressed: () {
                cart.addItem(book.id, book.unitPrice, book.title);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Added item to cart!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
