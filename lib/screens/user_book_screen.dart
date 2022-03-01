import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/books_provider.dart';
import '../widgets/user_book_item_widget.dart';
import '../widgets/navbar_drawer.dart';
import '../screens/book_edit_screen.dart';

class UserBookScreen extends StatelessWidget {

  static const routeName = '/user-book';

  @override
  Widget build(BuildContext context) {
    final booksData = Provider.of<BooksProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your books'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: () => Navigator.of(context).pushNamed(BookEditScreen.routeName),)
        ],
      ),
      drawer: NavbarDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(itemCount: booksData.items.length, itemBuilder: (ctx, idx) => Column(children: [
          UserBookItemWidget(booksData.items[idx].title, booksData.items[idx].imageUrl),
          Divider(),
        ],),),
      ),
    );
  }

}