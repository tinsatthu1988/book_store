import 'dart:convert';

import 'package:flutter/material.dart';

import 'cart.dart';

class Order {
  String orderTrackingNumber;
  double totalPrice;
  List<CartItem> books;
  DateTime dateTime;

  Order({required this.orderTrackingNumber, required this.totalPrice, required this.books, required this.dateTime});

  Map toJson() => {
    'orderTrackingNumber': orderTrackingNumber,
    'totalPrice': totalPrice,
    'products': books,
    'dateTime': dateTime.toIso8601String()
  };
}


class Orders with ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartBooks, double total) {
    _orders.insert(0, Order(orderTrackingNumber: DateTime.now().millisecondsSinceEpoch.toString(),
        totalPrice: total, dateTime: DateTime.now(), books: cartBooks));
    print(json.encode(_orders));
    notifyListeners();
  }
}