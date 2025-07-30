// widgets/transaction_card.dart
import 'package:flutter/material.dart';
import '../../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(
          transaction.type == TransactionType.income
              ? Icons.arrow_circle_up
              : Icons.arrow_circle_down,
          color: transaction.type == TransactionType.income
              ? Colors.green
              : Colors.red,
          size: 40,
        ),
        title: Text(transaction.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(transaction.category),
            Text(
              DateFormat('dd MMM yyyy').format(transaction.date),
              style: const TextStyle(fontSize: 12),
            ),
            if (transaction.note != null && transaction.note!.isNotEmpty)
              Text(
                transaction.note!,
                style: const TextStyle(fontSize: 12),
              ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Rp${transaction.amount.toStringAsFixed(2)}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: transaction.type == TransactionType.income
                    ? Colors.green
                    : Colors.red,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, size: 16),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 16),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

