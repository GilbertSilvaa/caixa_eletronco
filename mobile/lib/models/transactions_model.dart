import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mobile/models/transaction.dart';

class TransactionsModel extends ChangeNotifier {
  final List<Transaction> _list = [];

  UnmodifiableListView<Transaction> get transactions =>
      UnmodifiableListView(_list);

  void add(Transaction t) {
    _list.add(t);
    notifyListeners();
  }
}
