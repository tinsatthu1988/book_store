import 'package:flutter/material.dart';

class CartItem {
  String id;
  String title;
  int quantity;
  double unitPrice;

  CartItem({required this.id, required this.title, required this.quantity, required this.unitPrice});
}


class Cart with ChangeNotifier {
  Map<int, CartItem> _items = {};

  Map<int, CartItem> get items {
    return {..._items};
  }

  void addItem(int bookId, double unitPrice, String title,) {
    if (_items.containsKey(bookId)) {
      _items.update(bookId, (existingCartItem) => CartItem(id: existingCartItem.id,
          title: existingCartItem.title, quantity: existingCartItem.quantity + 1, unitPrice: existingCartItem.unitPrice));
    } else {
      _items.putIfAbsent(bookId, () => CartItem(id: DateTime.now().toString(), title: title, quantity: 1, unitPrice: unitPrice));
    }
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) => total += cartItem.unitPrice*cartItem.quantity);
    return total;
  }


}