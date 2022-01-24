import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/books_provider.dart';
import 'screens/books_overview_screen.dart';
import 'screens/book_detail_screeen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => BooksProvider(),
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
        },
      ),
    );
  }
}


  
