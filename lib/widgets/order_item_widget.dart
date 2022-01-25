import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/order.dart';

class OrderItemWidget extends StatefulWidget {
  final Order order;

  OrderItemWidget(this.order);

  @override
  State<StatefulWidget> createState() => _OrderItemWidget();
}


class _OrderItemWidget extends State<OrderItemWidget> {

  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(children: <Widget>[
        ListTile(
          title: Text('\$${widget.order.totalPrice.toStringAsFixed(2)}'),
          subtitle: Text(DateFormat('dd/MM/yyyy HH:mm').format(widget.order.dateTime)),
          trailing: IconButton(icon: Icon(Icons.expand_more), onPressed: () => setState(() { _expanded = !_expanded; }),),
        ),
        if (_expanded)
        Container(
          height: min(widget.order.books.length * 20.0 + 10.0, 60),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
          child: ListView(children: widget.order.books.map((book) =>
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(book.title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                Text('\$${book.unitPrice}x${book.quantity}', style: TextStyle(fontSize: 14, color: Colors.grey),),
              ],
            ),
          ).toList(),),),
      ],),
    );
  }

}