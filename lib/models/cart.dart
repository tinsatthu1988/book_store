import 'package:flutter/material.dart';

class CartItem {
  String bookId;
  String title;
  int quantity;
  double unitPrice;

  CartItem({required this.bookId, required this.title, required this.quantity, required this.unitPrice});
   Map toJson() => {
    'bookId': bookId,
    'title': title,
    'quantity': quantity,
    'unitPrice': unitPrice
  };
}


class Cart with ChangeNotifier {
  Map<int, CartItem> _items = {};

  Map<int, CartItem> get items {
    return {..._items};
  }

  void addItem(int bookId, double unitPrice, String title,) {
    if (_items.containsKey(bookId)) {
      _items.update(bookId, (existingCartItem) => CartItem(bookId: existingCartItem.bookId,
          title: existingCartItem.title, quantity: existingCartItem.quantity + 1, unitPrice: existingCartItem.unitPrice));
    } else {
      _items.putIfAbsent(bookId, () => CartItem(bookId: DateTime.now().toString(), title: title, quantity: 1, unitPrice: unitPrice));
    }
    notifyListeners();
  }

  void removeItem(int bookId) {
    _items.remove(bookId);
    notifyListeners();
  }

  void clear() {
    _items = {};
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