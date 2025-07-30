// providers/transaction_provider.dart
import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  final List<Transaction> _transactions = [];

  List<Transaction> get transactions => _transactions;

  void addTransaction(Transaction transaction) {
    _transactions.add(transaction);
    notifyListeners();
  }

  void updateTransaction(String id, Transaction newTransaction) {
    final index = _transactions.indexWhere((t) => t.id == id);
    if (index != -1) {
      _transactions[index] = newTransaction;
      notifyListeners();
    }
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((t) => t.id == id);
    notifyListeners();
  }

  List<Transaction> get expenses {
    return _transactions.where((t) => t.type == TransactionType.expense).toList();
  }

  List<Transaction> get incomes {
    return _transactions.where((t) => t.type == TransactionType.income).toList();
  }

  double get totalExpenses {
    return expenses.fold(0, (sum, t) => sum + t.amount);
  }

  double get totalIncomes {
    return incomes.fold(0, (sum, t) => sum + t.amount);
  }

  double get balance {
    return totalIncomes - totalExpenses;
  }
}