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
      appBar: AppBar(title: Text(loadedBook.title),),
      body: SingleChildScrollView(child: Column(children: [
        Container(height: 300, width: double.infinity, child: Image.network(loadedBook.imageUrl),),
        SizedBox(height: 10,),
        Text('${loadedBook.author}', style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),),
        SizedBox(height: 10,),
        Text('${loadedBook.category}', style: TextStyle(fontSize: 20, color: Colors.grey, fontStyle: FontStyle.italic),),
        SizedBox(height: 10,),
        Chip(label: Text('\$${loadedBook.unitPrice.toStringAsFixed(2)}', style: TextStyle(color: Theme.of(context).primaryTextTheme.headline6!.color, fontSize: 20),), backgroundColor: Theme.of(context).primaryColor,),
        SizedBox(height: 10,),
        Container(width: double.infinity, child: Text(loadedBook.description, style: TextStyle(fontSize: 15),), padding: EdgeInsets.symmetric(horizontal: 10),),
      ],),),
    );
  }

}