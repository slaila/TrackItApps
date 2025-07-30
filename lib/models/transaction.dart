// models/transaction.dart
enum TransactionType { income, expense }

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String category;
  final TransactionType type;
  final String? note;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
    required this.type,
    this.note,
  });
}