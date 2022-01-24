import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../widgets/cart_item_widget.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    Cart cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Cart'), centerTitle: true,),
      body: Column(children: <Widget>[
        Card(
          margin: EdgeInsets.all(15.0),
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: TextStyle(fontSize: 20),),
                Spacer(),
                Chip(label: Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: TextStyle(color: Theme.of(context).primaryTextTheme.headline6!.color),), backgroundColor: Theme.of(context).primaryColor,),
                FlatButton(onPressed: () {}, child: Text('ORDER NOW', style: TextStyle(color: Theme.of(context).primaryColor),),),
              ],
            ),
          ),
        ),
        Expanded(child: ListView.builder(itemCount: cart.itemCount, itemBuilder: (ctx, idx) => CartItemWidget(cart.items.values.toList()[idx].bookId, cart.items.keys.toList()[idx], cart.items.values.toList()[idx].unitPrice, cart.items.values.toList()[idx].quantity, cart.items.values.toList()[idx].title)),),
      ],),
    );
  }

}