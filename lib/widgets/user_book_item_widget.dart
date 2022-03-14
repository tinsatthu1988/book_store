import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/book_edit_screen.dart';
import '../providers/books_provider.dart';

class UserBookItemWidget extends StatelessWidget {

  final int id;
  final String title;
  final String imageUrl;

  UserBookItemWidget(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl),) ,
      trailing: Container(
        width: 100,
        child: Row(children: [
          IconButton(icon: Icon(Icons.edit), color: Theme.of(context).primaryColor, 
            onPressed: () => Navigator.of(context).pushNamed(BookEditScreen.routeName, arguments: id),
          ),
          IconButton(icon: Icon(Icons.delete), color: Theme.of(context).errorColor, 
            onPressed: () async {
              try {
                String message = await Provider.of<BooksProvider>(context, listen: false).deleteBook(id);
                if (message != '') {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),),);
                }
              } catch (error) {
                throw Exception('Deleting failed');
              }
            }
          ),
      ],),) ,
    );
  }

}