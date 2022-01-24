import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../models/cart.dart';

class CartItemWidget extends StatelessWidget {
  final String bookId;
  final int keyBookId;
  final String title;
  final int quantity;
  final double unitPrice;

  CartItemWidget(
      this.bookId, this.keyBookId, this.unitPrice, this.quantity, this.title);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(bookId),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) { Provider.of<Cart>(context, listen: false).removeItem(keyBookId); },
      background: Container(
        color: Theme.of(context).errorColor,
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        alignment: Alignment.centerRight,
        child: Icon(Icons.delete_forever, color: Colors.white, size: 40,),
        // padding: EdgeInsets.only(right: 20),
      ),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: Padding(
                padding: EdgeInsets.all(2),
                child: FittedBox(
                  child: Text(
                    '\$$unitPrice',
                  ),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: \$${unitPrice * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
