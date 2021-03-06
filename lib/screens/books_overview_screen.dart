import 'package:book_store/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/books_grid.dart';
import '../models/cart.dart';
import '../screens/cart_screen.dart';
import '../widgets/navbar_drawer.dart';
import '../providers/books_provider.dart';

enum FilterOptions {
  Favorites,
  All,
}

class BooksOverviewScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BooksOverviewScreen();
}

class _BooksOverviewScreen extends State<BooksOverviewScreen> {
  bool _showFavoritesOnly = false;
  bool _isLoading = false;
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() { _isLoading = true;});
      Provider.of<BooksProvider>(context).fetchAndSetBooks().then((value) => setState(() { _isLoading = false; }));
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Book Store'),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                  child: Text('Only favorites'),
                  value: FilterOptions.Favorites),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showFavoritesOnly = true;
                } else {
                  _showFavoritesOnly = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            builder: (ctx, cartData, childWidget) => Badge(
              child: childWidget!,
              value: cartData.itemCount.toString(),
              color: Colors.redAccent,
            ),
            child: IconButton(
                onPressed: () =>
                    Navigator.of(context).pushNamed(CartScreen.routeName),
                icon: Icon(Icons.shopping_cart)
            ),
          ),
        ],
      ),
      drawer: NavbarDrawer(),
      body: _isLoading ? Center(child: CircularProgressIndicator(),) : BooksGrid(_showFavoritesOnly),
    );
  }
}
