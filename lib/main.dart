import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/cart.dart';
import 'models/order.dart';
import 'providers/books_provider.dart';
import 'screens/book_edit_screen.dart';
import 'screens/books_overview_screen.dart';
import 'screens/book_detail_screeen.dart';
import 'screens/cart_screen.dart';
import 'screens/order_screen.dart';
import 'screens/user_book_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => BooksProvider(),),
        ChangeNotifierProvider(create: (BuildContext context) => Cart(),),
        ChangeNotifierProvider(create: (BuildContext context) => Orders(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.redAccent,
          fontFamily: 'Lato',
        ),
        home: BooksOverviewScreen(),
        routes: {
          BookDetailScreen.routeName: (ctx) => BookDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          UserBookScreen.routeName: (ctx) => UserBookScreen(),
          BookEditScreen.routeName: (ctx) => BookEditScreen(),
        },
      ),
    );
  }
}


  
