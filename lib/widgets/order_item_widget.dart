import 'package:flutter/material.dart';

import '../models/order.dart';

class OrderItemWidget extends StatelessWidget {

  final Order order;

  OrderItemWidget(this.order);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      ListTile(
        title: Text('${order.totalPrice}'),
      ),
    ],);
  }

}